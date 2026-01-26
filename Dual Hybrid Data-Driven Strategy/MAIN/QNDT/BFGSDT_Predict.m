function Result = BFGSDT_Predict(Tree,Parameter,X_test)
% X_test£∫≤‚ ‘ºØ
[m,n] = size(X_test);
for i = 1:m
   Result(i,1) = BFGSDT_Compute(X_test(i,:),Tree,Parameter);  
end 

end

