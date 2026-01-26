function [Data,Data_Tag] = ReadData( ID )

switch ID
    %% 一号炉-DXN
    case 1
        data1 = xlsread('D:\Documents\Matlab\Data\一号炉\公用系统-1.xls');
        data2 = xlsread('D:\Documents\Matlab\Data\一号炉\锅炉-2.xls');
        data3 = xlsread('D:\Documents\Matlab\Data\一号炉\燃烧-3.xls');
        data4 = xlsread('D:\Documents\Matlab\Data\一号炉\烟囱-4.xls');
        data5 = xlsread('D:\Documents\Matlab\Data\一号炉\尾气处理-5.xls');
        data6 = xlsread('D:\Documents\Matlab\Data\一号炉\发电-6.xls');
        data_tag = xlsread('D:\Documents\Matlab\Data\一号炉\DXN-tag.xls');
        Data = [data1,data2,data3,data4,data5,data6];
        Data_Tag = data_tag;
    %% 二号炉-DXN
    case 2
        data1 = xlsread('D:\Documents\Matlab\Data\二号炉\公用系统-1.xls');
        data2 = xlsread('D:\Documents\Matlab\Data\二号炉\锅炉-2.xls');
        data3 = xlsread('D:\Documents\Matlab\Data\二号炉\燃烧-3.xls');
        data4 = xlsread('D:\Documents\Matlab\Data\二号炉\烟囱-4.xls');
        data5 = xlsread('D:\Documents\Matlab\Data\二号炉\尾气处理-5.xls');
        data6 = xlsread('D:\Documents\Matlab\Data\二号炉\发电-6.xls');
        data_tag = xlsread('D:\Documents\Matlab\Data\二号炉\DXN-tag.xls');
        Data = [data1,data2,data3,data4,data5,data6];
        Data_Tag = data_tag;
    %% 一、二号炉-DXN
    case 3 
        data1 = xlsread('D:\Documents\Matlab\Data\一二号炉\公用系统-1.xls');
        data2 = xlsread('D:\Documents\Matlab\Data\一二号炉\锅炉-2.xls');
        data3 = xlsread('D:\Documents\Matlab\Data\一二号炉\燃烧-3.xls');
        data4 = xlsread('D:\Documents\Matlab\Data\一二号炉\烟囱-4.xls');
        data5 = xlsread('D:\Documents\Matlab\Data\一二号炉\尾气处理-5.xls');
        data6 = xlsread('D:\Documents\Matlab\Data\一二号炉\发电-6.xls');
        data_tag = xlsread('D:\Documents\Matlab\Data\一二号炉\DXN-tag.xls');
        Data = [data1,data2,data3,data4,data5,data6];
        Data_Tag = data_tag;
    %% 水泥强度
    case 4
        data1 = xlsread('D:\Documents\Matlab\Data\concrete\concrete_data.xlsx');
        Data = data1(1:10:end,1:end-1);
        Data_Tag = data1(1:10:end,end);
    %% 森林火灾
    case 5
        data1 = xlsread('D:\Documents\Matlab\Data\ForestFires\ForestFires.xlsx');
        Data = data1(:,1:end-1);
        Data_Tag = data1(:,end);
    %% 房价
    case 6
        data1 = xlsread('D:\Documents\Matlab\Data\HousingData\HousingData.xlsx');
        Data = data1(1:5:end,1:end-1);
        Data_Tag = data1(1:5:end,end);

        %% Orange_juice_OJ
    case 7
        data1_learning = xlsread('D:\Documents\Data\高维小样本数据集\Orange_juice_OJ\OJ_x_learning.xlsx');
        data2_test = xlsread('D:\Documents\Data\高维小样本数据集\Orange_juice_OJ\OJ_x_test.xlsx');
        data_tag_learning = xlsread('D:\Documents\Data\高维小样本数据集\Orange_juice_OJ\OJ_y_learning.xlsx');
        data_tag_test = xlsread('D:\Documents\Data\高维小样本数据集\Orange_juice_OJ\OJ_y_test.xlsx');
        data = [data1_learning;data2_test];
        data_Tag = [data_tag_learning;data_tag_test];
%         Data = data(1:2:end,:);
%         Data_Tag = data_Tag(1:2:end,:);
        Data = data(2:2:end,:);
        Data_Tag = data_Tag(2:2:end,:);
    %% Residential Building Data Set
    case 8
        data1 = xlsread('D:\Documents\Data\高维小样本数据集\Residential Building Data Set\Residential Building Data Set住宅建筑数据集-Cost.xlsx');
%         data1 = xlsread('D:\Documents\Data\高维小样本数据集\Residential Building Data Set\Residential Building Data Set住宅建筑数据集-Price.xlsx');
        Data = data1(1:3:end,1:end-1);
        Data_Tag = data1(1:3:end,end);
%         Data = data1(:,1:end-1);
%         Data_Tag = data1(:,end);
    %% Gas sensor array under flow modulation
    case 9
        data1 = xlsread('D:\Documents\Data\高维小样本数据集\Gas sensor array under flow modulation Data Set\pulmon_acetone.xlsx');
%         data1 = xlsread('D:\Documents\Data\高维小样本数据集\Gas sensor array under flow modulation Data Set\pulmon_ethanol.xlsx');
        Data = data1(:,1:end-1);
        Data_Tag = data1(:,end);
    %% Relative location of CT slices on axial axis
    case 10
        data1 = xlsread('D:\Documents\Data\高维小样本数据集\Relative location of CT slices on axial axis Data Set\slice_localization_data.xlsx');
        Data = data1(1:5:end,1:end-1);
        Data_Tag = data1(1:5:end,end);
%         Data = data1(:,1:end-1);
%         Data_Tag = data1(:,end);
    otherwise
        disp('Please select correct data set ID');
end
end

