function result = BFGSDT_Compute(X_test,Tree,Parameter)
% 计算一个样本在一棵CART树的预测结果
% 判断是否到达到树的叶子节点
if (Tree.dim == 0)
    Model = Tree.Parameter.Model;
    W = Model.W;

    X = X_test(:,unique(Tree.coordinate));
    result = X * W;
    return  
end  
%得到分裂特征点和特征值
dim = Tree.dim;
split_loc = Tree.split_loc;

% 判断当前样本的特征值与tree的特征值大小
if X_test(1,dim) > split_loc
    result = BFGSDT_Compute(X_test,Tree.Lnode,Parameter);
else
    result = BFGSDT_Compute(X_test,Tree.Rnode,Parameter);
end
end

