function [DataSpliTran]= DataProcessing(ParaData,X,Y)
% 数据预处理
% 数据集切分 // SpliStra=2:train and test, SpliStra=2:train validation and test
% 数据标准化和归一化// ProcStra=1:标准化，ProcStra=0:归一化
%% 数据切分
Choose = ParaData.splisequ;
SpliStra = ParaData.spliNumb;
if SpliStra == 2
    DataSpliTran = TT_SampleGeneration(X,Y,Choose);
end
if SpliStra == 3
    DataSpliTran = TVT_SampleGeneration(X,Y,Choose);
end
%% 数据处理
DataSpliTran = StanOrNorm(ParaData,DataSpliTran);
end