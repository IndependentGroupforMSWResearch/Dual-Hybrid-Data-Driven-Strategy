function [Data] = TVT_SampleGeneration(X,Y,Choose)
% 将数据集切分成训练集和测试集
% 1-从上往下按原始顺序切分训练集、验证集和测试集
% 2-随机打乱Dataset顺序，再顺序切分产生训练集、验证集和测试集
% 3-针对DXN1#2#炉数据的处理方法
% 4-2:1:1切分
[N,~] = size(X);
switch Choose
    case 1
       %% 从上往下切分训练集和测试集
        % 训练集  占总数的1/2
        train_num = round(N*(1/2));  
        Data.OriginalX1 = X((1:train_num),:);
        Data.OriginalY1 = Y((1:train_num),:);
        
        % 验证集  占总数的1/4
        Validation_num = round(N*(3/4));
        Data.OriginalX2 = X((train_num+1:Validation_num),:);
        Data.OriginalY2 = Y((train_num+1:Validation_num),:);
        
        % 测试集 占总数的1/4
        Data.OriginalX3 = X((Validation_num+1:end),:);
        Data.OriginalY3 = Y((Validation_num+1:end),:);

    case 2 
       %% 随机产生训练集和测试集
        rng default
        num = randperm(N); % 随机打乱样本顺序
        % randi(6,1,6) % 实现有放回的抽取
        % 训练集  占总数的1/2
        train_num = round(N*(1/2));  
        Data.OriginalX1 = X(num(1:train_num),1:end-1);
        Data.OriginalY1 = Y(num(1:train_num),end);

        % 验证集  占总数的1/4
        Validation_num = round(N*(3/4));
        Data.OriginalX2 = X(num((train_num+1):Validation_num),:);
        Data.OriginalY2 = Y(num((train_num+1):Validation_num),:);


        % 测试集 占总数的1/4
        Data.OriginalX3 = X(num((Validation_num+1):end),:);
        Data.OriginalY3 = Y(num((Validation_num+1):end),:);
    case 4
       %% 12-3-4
        % 训练集  
        trainset_X_1 = X(1:4:end,:);
        trainset_Y_1 = Y(1:4:end,:);
        trainset_X_2 = X(2:4:end,:);
        trainset_Y_2 = Y(2:4:end,:);
        Data.OriginalX1 = [trainset_X_1;trainset_X_2];
        Data.OriginalY1 = [trainset_Y_1;trainset_Y_2];
        % 验证集  占总数的1/4
        Data.OriginalX2 = X(3:4:end,:);
        Data.OriginalY2 = Y(3:4:end,:);
        
        % 测试集 占总数的1/4
        Data.OriginalX3 = X(4:4:end,:);
        Data.OriginalY3 = Y(4:4:end,:);
    case 5
       %% 23-4-1
        % 训练集  
        trainset_X_1 = X(2:4:end,:);
        trainset_Y_1 = Y(2:4:end,:);
        trainset_X_2 = X(3:4:end,:);
        trainset_Y_2 = Y(3:4:end,:);
        Data.OriginalX1 = [trainset_X_1;trainset_X_2];
        Data.OriginalY1 = [trainset_Y_1;trainset_Y_2];
        % 验证集  占总数的1/4
        Data.OriginalX2 = X(4:4:end,:);
        Data.OriginalY2 = Y(4:4:end,:);
        
        % 测试集 占总数的1/4
        Data.OriginalX3 = X(1:4:end,:);
        Data.OriginalY3 = Y(1:4:end,:);
    case 6
       %% 34-1-2
        % 训练集  
        trainset_X_1 = X(3:4:end,:);
        trainset_Y_1 = Y(3:4:end,:);
        trainset_X_2 = X(4:4:end,:);
        trainset_Y_2 = Y(4:4:end,:);
        Data.OriginalX1 = [trainset_X_1;trainset_X_2];
        Data.OriginalY1 = [trainset_Y_1;trainset_Y_2];
        % 验证集  占总数的1/4
        Data.OriginalX2 = X(1:4:end,:);
        Data.OriginalY2 = Y(1:4:end,:);
        
        % 测试集 占总数的1/4
        Data.OriginalX3 = X(2:4:end,:);
        Data.OriginalY3 = Y(2:4:end,:);
    case 7
       %% 41-2-3
        % 训练集  
        trainset_X_1 = X(4:4:end,:);
        trainset_Y_1 = Y(4:4:end,:);
        trainset_X_2 = X(1:4:end,:);
        trainset_Y_2 = Y(1:4:end,:);
        Data.OriginalX1 = [trainset_X_1;trainset_X_2];
        Data.OriginalY1 = [trainset_Y_1;trainset_Y_2];
        % 验证集  占总数的1/4
        Data.OriginalX2 = X(2:4:end,:);
        Data.OriginalY2 = Y(2:4:end,:);
        
        % 测试集 占总数的1/4
        Data.OriginalX3 = X(3:4:end,:);
        Data.OriginalY3 = Y(3:4:end,:);
    otherwise
        disp('Please select correct data set ID');
        
end

