rng(1)
%% 清空环境变量
clc
clear all
warning off
%% 主模型训练
% 读取机理数据
load MainModelData.mat
MechanismData = MainModelData;
MechanismX = MechanismData(:,1:end-1); 
MechanismY = MechanismData(:,end); 
MechanismDataSet = [MechanismX,MechanismY]; 
[N,D] = size(MechanismDataSet); % D-是特征个数(维度)；N-是样本数量
% 机理数据集参数
MechanismParaData.spliNumb = 2;
MechanismParaData.splisequ = 8;
MechanismParaData.StanOrNorm = 1;
[MechanismDataSpliTran] = DataProcessing(MechanismParaData,MechanismX,MechanismY);
% 机理模型训练 
X1 = MechanismDataSpliTran.TransformX1; 
Y1 = MechanismDataSpliTran.TransformY1; 
% 树分裂参数
Parameter.Tree.MinSamples = 100; % 最小样本个数
Parameter.Tree.FeaturesNum = round(sqrt(D));
Parameter.max_iter = 1000;
Parameter.tol = 1e-05;         % 收敛容忍度
Parameter.alpha = 0.01;     % 初始学习率（可以通过线搜索调整）
Parameter.lamda = 1e-1;
lambda = Parameter.lamda;
eta = Parameter.alpha;
% 构建BFGSDT
Tree = BFGSDT_Train(X1,Y1,Parameter);  

%% 残差数据集获取
load OursTrainData.mat
OursTrainX = OursTrainData(:,1:end-1); 
OursTrainY = OursTrainData(:,end); 

load OursTestingData.mat
OursTestingX = OursTestingData(:,1:end-1); 
OursTestingY = OursTestingData(:,end); 

% 按主模型标准化过程数据
TrainX = scale(OursTrainX,MechanismDataSpliTran.TransformMeanX,MechanismDataSpliTran.TransformStanX);
TestX = scale(OursTestingX,MechanismDataSpliTran.TransformMeanX,MechanismDataSpliTran.TransformStanX);
TrainY = scale(OursTrainY,MechanismDataSpliTran.TransformMeanY,MechanismDataSpliTran.TransformStanY);
TestY = scale(OursTestingY,MechanismDataSpliTran.TransformMeanY,MechanismDataSpliTran.TransformStanY);

% 得到残差数据集
% 训练集测试
MainTrainOUT = BFGSDT_Predict(Tree,Parameter,TrainX);
MainTrainOUT = rescale(MainTrainOUT,MechanismDataSpliTran.TransformMeanY,MechanismDataSpliTran.TransformStanY);
TrainError = OursTrainY - MainTrainOUT;

% 测试集测试  
MainTestOut = BFGSDT_Predict(Tree,Parameter,TestX);
MainTestOut = rescale(MainTestOut,MechanismDataSpliTran.TransformMeanY,MechanismDataSpliTran.TransformStanY);
TestError = OursTestingY - MainTestOut;

ErrorTrainDataSet = [OursTrainX,TrainError];
ErrorTestDataSet = [OursTestingX,TestError];

%% 补偿模型训练
% 数据标准化
[COMTrainX,ComMX,ComSX] = auto(OursTrainX);
[ComTrainY,ComMY,ComSY] = auto(TrainError);
COMTestX = scale(OursTestingX,ComMX,ComSX);
COMTestY = scale(TestError,ComMY,ComSY);

% 初始化超参数
NumRule = 20;        % 初始模糊规则数
NumF = 50;           % IT3FNN子系统数
NumK = 1;           % 二级隶属度切片数
NumEnhan = 50;       % 增强节点数
batchSize = 16;     % 每批样本数

[Model]  = IT3FBLS_train(COMTrainX, ComTrainY,batchSize,lambda,NumRule,NumF,NumK,NumEnhan);
% 训练集测试
[ComTrainOUT] = IT3FBLS_Predict(COMTrainX, Model);
ComTrainOUT = rescale(ComTrainOUT,ComMY,ComSY);

% 测试集测试  
[ComTestOUT] = IT3FBLS_Predict(COMTestX, Model);
ComTestOUT = rescale(ComTestOUT,ComMY,ComSY);
%% 逆矩阵求权重
FinalTrainX = [MainTrainOUT,ComTrainOUT,OursTrainX];
FinalTrainY = OursTrainY;
FinalTestingX = [MainTestOut,ComTestOUT,OursTestingX];
FinalTestingY = OursTestingY;

% 数据处理
% 数据归一化
MaxX = max(FinalTrainX);
MinX = min(FinalTrainX);
MaxY = max(FinalTrainY);
MinY = min(FinalTrainY);
FinalTrainX = (FinalTrainX - MinX) ./ (MaxX - MinX);
FinalTestingX = (FinalTestingX - MinX) ./ (MaxX - MinX);
FinalTrainY = (FinalTrainY - MinY) ./ (MaxY - MinY);
FinalTestingY = (FinalTestingY - MinY) ./ (MaxY - MinY);

%% 岭回归计算权重
I = eye(size(FinalTrainX, 2));  % 单位矩阵，大小为特征数 p
beta = (FinalTrainX' * FinalTrainX + lambda * I) \ (FinalTrainX' * FinalTrainY);

% 训练集
FinalTrainOut = FinalTrainX * beta; % 预测
FinalTrainOut = FinalTrainOut .* (MaxY - MinY) + MinY;
[RMSE_Train,MAE_Train,R2_Train,MAPE_Train] = ModelEvaluate(OursTrainY,FinalTrainOut,1);
fprintf('\n训练集: RMSE = %f \\ MAE = %f \r \\ R2 = %f \\ MAPE = %f\n',RMSE_Train,MAE_Train, R2_Train, MAPE_Train );

% % 2. 计算增量更新的模型系数
% % Ridge回归增量更新公式
beta_new = beta;
Error = 0;
for i = 1 : 1 : size(FinalTestingX,1)
    X = FinalTestingX(i,:);
    FinalTestingOut(i,:) = X* beta_new;
    Error = FinalTestingY(i,:) - FinalTestingOut(i,:);

    % 更新回归系数
    beta_new = beta_new + eta * Error * X'; % VSS-LMS
    eta = eta /(1 + 0.1 * Error^2);
end
FinalTestingOut = FinalTestingOut .* (MaxY - MinY) + MinY;
[RMSE_Test,MAE_Test,R2_Test,MAPE_Test] = ModelEvaluate(OursTestingY,FinalTestingOut,2);
fprintf('\n测试集: RMSE = %f \\ MAE = %f \r \\ R2 = %f \\ MAPE = %f\n',RMSE_Test,MAE_Test, R2_Test, MAPE_Test );