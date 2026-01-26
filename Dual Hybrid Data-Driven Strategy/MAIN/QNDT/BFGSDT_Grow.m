function Tree = BFGSDT_Grow(DataSet,Parameter,tag_num,TreeDeep,Coordinate)
    MinSamples = Parameter.Tree.MinSamples;
    % 每一行是一个样本
    % tag_num:是记录实际特征编号的数组
    % 以下开始构建tree
    % 树的高度
    Tree.deep = TreeDeep;
    %初始化树的分裂特征为第0个
    Tree.dim = 0; 
    %初始化分裂位置是inf 
    Tree.split_loc = inf;  
    % 每个节点中包含的数据
    Tree.dataset = DataSet;
    % 切分点坐标
    Tree.coordinate = Coordinate;
    % 选择最好的切分点
    if size(DataSet,1) > MinSamples
        [Index,Value] = ChooseBestSplit(DataSet, MinSamples); 
        if Index ~= 0
            Tree.dim = Index; 
            Tree.split_loc = Value;
            Tree.coordinate = horzcat(Coordinate,Index);
            % 将数据集切分成左右两个子集
            [LSet,RSet] = BinSplit(DataSet, Index, Value);  
            % 每个节点中包含的数据
            Tree.Ldataset = LSet;
            Tree.Rdataset = RSet;
            Tree.Lnode = BFGSDT_Grow( LSet,Parameter,tag_num,TreeDeep + 1,Tree.coordinate);  
            Tree.Rnode = BFGSDT_Grow( RSet,Parameter,tag_num,TreeDeep + 1,Tree.coordinate);   
        else 
            Tree.dim = 0;  
            dataset = [DataSet(:,unique(Tree.coordinate)),DataSet(:,end)];
            % IT2FNN训练子空间
            [Model] = LeastSquareBFGS(dataset,Parameter);
            Tree.Parameter.Model = Model;  
            return;  
        end  
         
    else
        % 如果仅剩下MinSamples个样本时 不再继续切分
        Tree.dim = 0;  
        dataset = [DataSet(:,unique(Tree.coordinate)),DataSet(:,end)];
        [Model] = LeastSquareBFGS(dataset,Parameter);
        Tree.Parameter.Model = Model;  
        return; 
    end
end

