function [RMSE,MAE,R2,MAPE,Adj_R2,Explained_Variance,MSE,MAAPE] ...
    = ModelEvaluate(TureValue,PredictValue,PictureNumber)
% PictureNumber, 画图的序号
Plot_RF(TureValue,PredictValue,PictureNumber)
MSE = sum((PredictValue-TureValue).^2)/size(TureValue,1);
RMSE = sqrt(sum((PredictValue-TureValue).^2)/size(TureValue,1));
MAE = sum(abs(PredictValue-TureValue))/size(TureValue,1);
R2 = 1-(sum((PredictValue-TureValue).^2)/size(TureValue,1))/var(TureValue);
MdAE = median(abs(PredictValue-TureValue));
MAAPE = sum(atan(abs((PredictValue-TureValue)./TureValue)))/size(TureValue,1);
RMSPE = sqrt(sum((abs((PredictValue-TureValue)./TureValue)).^2)/size(TureValue,1));
Adj_R2 = 1-(1-R2)*((size(TureValue,1)-1)/(size(TureValue,1)-1-4));
Accuracy = ...
    sum(1-(abs(PredictValue-TureValue)./abs(PredictValue)))/size(TureValue,1);
Explained_Variance = 1-var(PredictValue-TureValue)/var(TureValue);
%%%%% 真值小于1时，不使用MPE和MAPE
MPE = (100 * sum((PredictValue-TureValue)./TureValue))/size(TureValue,1);
MAPE = (100 * sum(abs((PredictValue-TureValue)./TureValue)))/size(TureValue,1);
end

