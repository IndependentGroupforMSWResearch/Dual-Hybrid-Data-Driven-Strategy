function [ dataSet_1, dataSet_2 ] = BinSplit( dataSet, Index, value )  
    % 将数据集按照某一特征值分成dataSet_1, dataSet_2两个子数据集
    [m,n] = size(dataSet);%计算数据集的大小
    if Index == 0
        disp('没有找到最佳切分点，index=%d\n',Index);
        return
    end
    DataTemp = dataSet(:,Index)';%变成行  
      
    %计算行中标签列的元素大于value的行  
    index_1 = [];%空的矩阵  
    index_2 = [];  
    
    % 将大于Value的列存到index_1中
    % 将小于Value的列存到index_2中
    for i = 1:m  
        if DataTemp(1,i) > value  
            index_1 = [index_1,i];  
        else  
            index_2 = [index_2,i];  
        end  
    end  
    [m_1,n_1] = size(index_1);%这里要取列数  
    [m_2,n_2] = size(index_2);  
      
    if n_1>0 && n_2>0  
        for j = 1:n_1  
            dataSet_1(j,:) = dataSet(index_1(1,j),:);  
        end  
      
        for j = 1:n_2  
            dataSet_2(j,:) = dataSet(index_2(1,j),:);  
        end  
    elseif n_1 == 0  
            dataSet_1 = [];  
            dataSet_2 = dataSet;  
    elseif n_2 == 0  
            dataSet_2 = [];  
            dataSet_1 = dataSet;  
    end  
end  
