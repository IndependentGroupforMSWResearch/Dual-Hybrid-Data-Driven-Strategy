function Tree= BFGSDT_Train(X_train,Y_train,Parameter)
    % 训练数据
    FeaturesNum = Parameter.Tree.FeaturesNum;
    
    tag_num = zeros(2,FeaturesNum);
    TreeDeep = 0;
    Coordinate = [];
    dataSet = [X_train,Y_train];
    Tree = BFGSDT_Grow(dataSet, Parameter,tag_num,TreeDeep,Coordinate);
end

