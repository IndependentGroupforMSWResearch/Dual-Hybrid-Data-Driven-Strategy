function [ Index, Value ] = ChooseBestSplit( dataSet, MinSamples )  
    % note:循环寻找最佳切分点时注意循环内部的数据集大小，防止计算平方误差函数报错
    % dataSet：训练集
    % ErrorDropValue：是容许的误差下降值
    % MinSamples：是切分的最小样本数  
    [m,n] = size(dataSet);%数据集的大小 
    % 计算初始误差 
    IniErr = regErr(dataSet);
    % 初始化,无穷大
    BestErr = inf;  
    BestIndex = 0;  
    BestValue = 0;  
          
    % 利用递归的方式寻找，最佳的位置和最优的值
    % 外层循环遍历了每一个特征
    for j = 1:(n-1)%得到列  
        % 这里去除了一个特征的重复的样本
        b = unique(dataSet(:,j));%得到特征所在的列  
        lenFeatures = length(b);  
        % 内层循环是特征的每一个不同的值
        for i = 1:lenFeatures  
            temp = b(i,:); 
            % 考虑切割的时候，直接从第一个位置开始切割呢？
            [mat0,mat1] = BinSplit(dataSet, j ,temp);  
            m0 = size(mat0);  
            m1 = size(mat1);  
            % 注意这里切割时是否已经小于0，防止regErr函数报异常
            if m0(:,1) < (round(MinSamples/2)) || m1(:,1) < (round(MinSamples/2))  
                continue;  
            end 
            newErr = regErr(mat0) + regErr(mat1); 
            if newErr < BestErr  
                BestErr = newErr;  
                BestIndex = j;  
                BestValue = temp;  
            end  
        end  
    end  
    Index = BestIndex;  
    Value = BestValue;  
end  