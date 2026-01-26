function [Data] = TT_SampleGeneration(X,Y,Choose)
% 将数据集切分成训练集和测试集
% 1-从上往下按原始顺序切分训练集和测试集
% 2-随机打乱Dataset顺序，再顺序切分产生训练集和测试集
% 3-偶数训练，奇数测试
% 4-0.632Bootstrap 采样方法
[N,~] = size(X);
switch Choose
    case 1
       %% 从上往下切分训练集和测试集
        % 训练集  占总数的2/3
        train_num = round(N*(2/3));  
        Data.OriginalX1 = X((1:train_num),:);
        Data.OriginalY1 = Y((1:train_num),:);
        
        % 测试集 占总数的1/3
        Data.OriginalX2 = X((train_num+1:end),:);
        Data.OriginalY2 = Y((train_num+1:end),:);

    case 2
       %% 随机产生训练集和测试集
        % 初始样本打乱
        rng default
        num = randperm(N); % 随机打乱样本顺序
        % randi(6,1,6) % 实现有放回的抽取
        % 训练集  占总数的2/3
        train_num = round(N*(2/3));  
        Data.OriginalX1 = X(num(1:train_num),:);
        Data.OriginalY1 = Y(num(1:train_num),:);
        
        % 测试集 占总数的1/3
        Data.OriginalX2 = X(num(train_num+1:end),:);
        Data.OriginalY2 = Y(num(train_num+1:end),:);

    case 3
       %% 偶数训练，奇数测试
        % 训练集  偶数
        Data.OriginalX1 = X(2:2:end,:);
        Data.OriginalY1 = Y(2:2:end,:);
        % 测试集 奇数
        Data.OriginalX2 = X(1:2:end,:);
        Data.OriginalY2 = Y(1:2:end,:);
    case 4
       %% 1-2-3
        % 训练集  
        trainset_X_1 = X(1:3:end,:);
        trainset_Y_1 = Y(1:3:end,:);
        trainset_X_2 = X(2:3:end,:);
        trainset_Y_2 = Y(2:3:end,:);
        Data.OriginalX1 = [trainset_X_1;trainset_X_2];
        Data.OriginalY1 = [trainset_Y_1;trainset_Y_2];
        % 测试集  占总数的1/3
        Data.OriginalX2 = X(3:3:end,:);
        Data.OriginalY2 = Y(3:3:end,:);
    case 5
       %% 2-3-1
        % 训练集  
        trainset_X_1 = X(2:3:end,:);
        trainset_Y_1 = Y(2:3:end,:);
        trainset_X_2 = X(3:3:end,:);
        trainset_Y_2 = Y(3:3:end,:);
        Data.OriginalX1 = [trainset_X_1;trainset_X_2];
        Data.OriginalY1 = [trainset_Y_1;trainset_Y_2];
        % 测试集 占总数的1/3
        Data.OriginalX2 = X(1:3:end,:);
        Data.OriginalY2 = Y(1:3:end,:);
    case 6
       %% 3-1-2
        % 训练集  
        trainset_X_1 = X(3:3:end,:);
        trainset_Y_1 = Y(3:3:end,:);
        trainset_X_2 = X(1:3:end,:);
        trainset_Y_2 = Y(1:3:end,:);
        Data.OriginalX1 = [trainset_X_1;trainset_X_2];
        Data.OriginalY1 = [trainset_Y_1;trainset_Y_2];
        % 测试集 占总数的1/3
        Data.OriginalX2 = X(2:3:end,:);
        Data.OriginalY2 = Y(2:3:end,:);
    case 7
         %% 0.632Bootstrap 采样方法
         % randi(6,1,6) % 实现有放回的抽取
        [M,~] = size(X);
        tag_number = 1:M;
        % 对样本进行bootstrap采样
        train_tag=bootrsp(tag_number,1);
        % 训练集  
        Data.OriginalX1 = X(train_tag,:);
        Data.OriginalY1 = Y(train_tag,:);

        % 测试集 
        test_tag = setdiff(tag_number,train_tag); 
        Data.OriginalX2 = X(test_tag,:);
        Data.OriginalY2 = Y(test_tag,:);

    case 8
         %% 全训练
        % 训练集  
        Data.OriginalX1 = X(1:end,:);
        Data.OriginalY1 = Y(1:end,:);
        % 测试集
        Data.OriginalX2 = X(1:end,:);
        Data.OriginalY2 = Y(1:end,:);

    otherwise
        disp('Please select correct data set ID');
        
end

