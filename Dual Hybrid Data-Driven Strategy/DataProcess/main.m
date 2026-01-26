clear all
clc
load CCS-LowDimension.mat;
Data = CCS;
Num = round(size(Data,1) * 0.8);
MainModelData = CCS(1:Num,:);
ComModelData = CCS(Num+1:end,:);

X1 = ComModelData(1:3:end,:);
X2 = ComModelData(2:3:end,:);
TrainData = [MainModelData;X1;X2];
OursTrainData = [X1;X2];

TestingData = ComModelData(3:3:end,:);
OursTestingData = TestingData;