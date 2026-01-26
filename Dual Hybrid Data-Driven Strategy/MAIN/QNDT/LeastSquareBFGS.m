function [Model] = LeastSquareBFGS(Data,Parameter)
    max_iter = Parameter.max_iter;
    tol = Parameter.tol;         % 收敛容忍度
    alpha = Parameter.alpha;     % 初始学习率（可以通过线搜索调整）
    lamda = Parameter.lamda;
    
    % 训练数据
    X = Data(:,1:end-1);
    Y = Data(:,end);
    [N,FeatureNum] = size(X);
    
    % 初始化权重 W 和其他变量
    W = randn(FeatureNum, 1);    % 小幅度初始化 W
    H_inv = eye(FeatureNum);     % 初始化海森矩阵的逆为单位矩阵
    
    grad = - (1 / N) * X' * (Y - X * W) + lamda * W;
    
    % 主迭代过程
    for iter = 1:max_iter
        % 计算当前损失函数的梯度
        grad = - (1 / N) * X' * (Y - X * W) + lamda * W;
        
        % 计算海森矩阵的逆更新（BFGS方法）
        % 当前梯度变化量
        if iter > 1
            s = W - W_prev;         % 参数更新变化量
            y = grad - grad_prev;   % 梯度变化量
            
            % % 更新海森矩阵的逆
            rho = 1 / (y' * s);
            H_inv = H_inv + rho * (s * s' - H_inv * y * s' - s * y' * H_inv);

        end
        
        % 使用拟牛顿法更新 W
        W_prev = W;            % 保存上一步的 W
        grad_prev = grad;      % 保存上一步的梯度
        
        % 更新权重
        W = W - alpha * H_inv * grad;
        
        
        % 检查收敛条件（例如梯度的范数小于容忍度）
        if norm(grad) < tol
            fprintf('收敛于第 %d 次迭代！\n', iter);
            break;
        end
    end
    %% 保存模型
    Model.W = W;
end

