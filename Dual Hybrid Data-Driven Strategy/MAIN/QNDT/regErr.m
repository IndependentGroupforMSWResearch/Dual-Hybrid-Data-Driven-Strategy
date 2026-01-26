function [ error ] = regErr( dataSet )  
%求得dataSet的大小  
[m,n] = size(dataSet);
% %% 平均误差
% % dataVar = 输出值的方差 
% dataVar = var(dataSet(:,n));  
% %  error = 方差 × 总数
% error = dataVar * m;  

meanValue = mean(dataSet(:,n));
error = mean((dataSet(:,n)-meanValue).^2);


end  