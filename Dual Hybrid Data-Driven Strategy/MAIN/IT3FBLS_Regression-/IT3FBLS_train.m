function [Model]  = IT3FBLS_train(X_train,Y_train,batchSize,C,R,F,K,NumEnhan)

% %% 0) 数据分批
% [batchesX, batchesY] = partitionBatches(X_train, Y_train, batchSize);
% Nbatches = length(batchesX);    % 批次数

%% 1) 初始化IT3FBLS参数
alpha_k = linspace(0, 1, K+2);
alpha_k = alpha_k(2:end-1);
lower_alpha_k = alpha_k.^1.2;       % 水平切片𝜇𝑠的下边界取值
upper_alpha_k = alpha_k.^(1/1.2);   % 水平切片𝜇𝑠的上边界取值

% 定义高斯参数
N = size(X_train,1);                        % 输入样本数
n = size(X_train,2);                        % 输入维度
[~,C_mat] = kmeans(X_train, R,'emptyaction','singleton');
C_mat = C_mat';                             % 中心
sigmaUpper_mat  = ones(n,R) ;               % 宽度上界
sigmalower_mat  = sigmaUpper_mat - 0.2;     % 宽度下界

paramStruct = cell(n,R);
for i=1:n
    for j=1:R
        paramStruct{i,j}.C       = C_mat(i,j);
        paramStruct{i,j}.sigUp   = sigmaUpper_mat(i,j);
        paramStruct{i,j}.siglow = sigmalower_mat(i,j);
    end
end

% 第f个子系统的后件上下界初始化
w_lower = cell(1,F);
w_upper = cell(1,F);
for f = 1:1:F
    w_lower{f} = 0.9 * rand(R,1);
    w_upper{f} = w_lower{f} + 0.2;
end

% IT3FNN层与增强节点的连接权重和偏置项
WeightEnhan = rand(F+1,NumEnhan) - 0.5;
beta = zeros(F+NumEnhan,1); % 初始化wf和we

% 保存模型
Model.beta = beta;      % 权重参数
Model.C = C;            % 正则化系数
Model.R = R;            % 每个模糊子系统的模糊规则数
Model.F = F;            % 模糊子系统的个数
Model.K = K;            % 切片数
Model.NumEnhan = NumEnhan;          % 增强节点个数
Model.WeightEnhan = WeightEnhan;    % 模糊子系统与增强节点的连接权值
Model.paramStruct = paramStruct;    % IT3FNN层参数
Model.lower_alpha_k = lower_alpha_k;       % 水平切片𝜇𝑠的下边界取值
Model.upper_alpha_k = upper_alpha_k;   % 水平切片𝜇𝑠的上边界取值
Model.w_lower = w_lower;    % 后件下界
Model.w_upper = w_upper;    % 后件上界

%% 2）计算IT3FBLS模型的层向量
[~,T3] = IT3FBLS_Predict(X_train, Model);
T1 = T3(:,1:F);
T2 = T3(:,F+1:end);

%% 3）参数更新
% dTotal = size(T3,2);
% gammaVec = zeros(dTotal,1);
% sigma_kernel = 1.0;  % kernel带宽(自定)
% for col = 1:dTotal
%     colData = T3(:,col);
%     v_col = computeEdgePotential1D(colData, sigma_kernel);
%     gammaVec(col) = 1/(v_col + 1e-8);
% end
% GammaMat = diag(gammaVec);
% 
% % 3.1 采用熵加权自适应正则算法
% T3tT3 = T3'*T3;
% regMat = (T3tT3 + C * GammaMat);
% beta = regMat \ (T3' * Y_train);

% 采用岭回归
beta = (T3'  *  T3+eye(size(T3',1)) * (C)) \ ( T3'  *  Y_train);

% % 3.2 采用梯度下降二次更新参数
% maxgen = 100;
% lr = 0.01;
% wh1=ones(1,N);
% for epoch=1:maxgen %迭代循环
%     epoch
%     % [Y_pre,T3] = IT3FBLS_Predict(X_train, Model);
%     % 计算增强节点输出
%     Y_pre = T3 * beta;    % 输出
% 
%     W1=beta(1:F,:); % 增强节点的权重
%     W2=beta(F+1:end,:); % 增强节点的权重
%     Wh=WeightEnhan(1:F,:);   % 2层间的权重
%     Wh_beta=WeightEnhan(F+1,:);% 偏置项
%     T2temp=((1-T2.^2));
%     error = Y_pre - Y_train;
% 
%     % 更新两层间的权重
%     tempWh=T1'*((error*W2').*T2temp);
%     Wh = Wh - lr * tempWh;   % 更新
%     % 更新偏置项
%     tempWhbeta=wh1*((error*W2').*T2temp);
%     Wh_beta = Wh_beta - lr * tempWhbeta;
%     WeightEnhan=[Wh; Wh_beta];
% 
%     % % 梯度下降更新wf和we(无效)
%     % wf = W1 - 0.0001 * T1' * error;
%     % we = W2 - 0.0001 * T2' * error;
%     % beta = [wf;we];
%     % H2 = [T1 0.1 * ones(size(T1,1),1)];
%     % T2 = tansig(H2 * WeightEnhan);
%     % T3=[T1 T2];
% 
%     % 岭回归更新wf和we(有效)
%     H2 = [T1 0.1 * ones(size(T1,1),1)];
%     T2 = tansig(H2 * WeightEnhan);
%     T3=[T1 T2];
%     beta = (T3' * T3+eye(size(T3',1)) * (C)) \ ( T3'  *  Y_train);
% 
%     % Model.beta = beta;      % 权重参数
%     % Model.WeightEnhan = WeightEnhan;    % 模糊子系统与增强节点的连接权值
% 
%     RMSE(epoch) = sqrt(sumsqr(error)/(N)) / 2;
% end

%% 保存模型
Model.beta = beta;      % 权重参数
Model.C = C;            % 正则化系数
Model.R = R;            % 每个模糊子系统的模糊规则数
Model.F = F;            % 模糊子系统的个数
Model.K = K;            % 切片数
Model.NumEnhan = NumEnhan;          % 增强节点个数
Model.WeightEnhan = WeightEnhan;    % 模糊子系统与增强节点的连接权值
Model.paramStruct = paramStruct;    % IT3FNN层参数
Model.lower_alpha_k = lower_alpha_k;       % 水平切片𝜇𝑠的下边界取值
Model.upper_alpha_k = upper_alpha_k;   % 水平切片𝜇𝑠的上边界取值
Model.w_lower = w_lower;    % 后件下界
Model.w_upper = w_upper;    % 后件上界

end

