function [results,TT3] = IT3FBLS_Predict(x, Model)
%% 加载模型参数
beta = Model.beta;      % 节点与顶层的连接权值
% C = Model.C;            % 正则化系数
R = Model.R;    % 每个模糊子系统的模糊规则数
F = Model.F;    % 模糊子系统的个数
% K = Model.K;    
% NumEnhan = Model.NumEnhan;  % 增强节点个数
WeightEnhan = Model.WeightEnhan;    % 模糊子系统与增强节点的连接权值
paramStruct = Model.paramStruct;
lower_alpha_k = Model.lower_alpha_k;       % 水平切片𝜇𝑠的下边界取值
upper_alpha_k = Model.upper_alpha_k;   % 水平切片𝜇𝑠的上边界取值
w_lower = Model.w_lower;    % 后件下界
w_upper = Model.w_upper;    % 后件上界

%% IT3FBLS预测
%% 1. 计算IT3FNN层输出
[N, ~] = size(x);
t_y = zeros(N,1);

for iData = 1:N
    x_in = x(iData,:);    % 第iData条样本

    % 输入样本关于各切片的隶属度
    n = size(paramStruct,1);
    membershipData = cell(n,R);
    for i=1:n       % 第i维样本
        for j=1:R   % 第j维规则
            membershipData{i,j} = computeMembershipIT3(x_in(i), paramStruct{i,j}, 0.5);
        end
    end

    zStruct = ruleFiringIT3(x_in, membershipData, lower_alpha_k, upper_alpha_k);
    for f = 1:1:F
        % 计算第f个子系统的输出
        y_hat = outputIT3FLS(R, length(lower_alpha_k), ...
            w_lower{f}, w_upper{f}, lower_alpha_k, upper_alpha_k, zStruct);
        
        t_y(iData,f) = y_hat;
    end
end
TT1 = t_y;    % 测试用

%% 2. 计算增强节点输出
HH2 = [TT1 0.1 * ones(size(TT1,1),1)];
TT2 = tansig(HH2 * WeightEnhan);   

%% 3. 预测输出
TT3=[TT1 TT2];
results = TT3 * beta;    % 输出

end

