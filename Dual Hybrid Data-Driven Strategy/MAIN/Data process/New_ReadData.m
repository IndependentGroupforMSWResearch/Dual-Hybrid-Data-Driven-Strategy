function [Data,Data_Tag] = New_ReadData( ID )

switch ID
    %% Ò»¡¢¶þºÅÂ¯-DXN
    case 1 
        load DXN-141-117.mat DXN
        Data = DXN(:,1:end-1);
        Data_Tag = DXN(:,end);
    %% Orange_juice_OJ
    case 2
        load NIR-HighDimension.mat NIR
%         Data = NIR(2:2:end,1:end-1);
%         Data_Tag = NIR(2:2:end,end);
        Data = NIR(:,1:end-1);
        Data_Tag = NIR(:,end);
    %% Gas sensor array under flow modulation
    case 3
        load Gas-HighDimension.mat Gas
        Data = Gas(:,1:end-1);
        Data_Tag = Gas(:,end);
    %% Relative location of CT slices on axial axis
    case 4
        load CT-HighDimension.mat CT
%         Data = CT(1:5:end,1:end-1);
%         Data_Tag = CT(1:5:end,end);
        Data = CT(:,1:end-1);
        Data_Tag = CT(:,end);
    %% Residential Building Data Set
    case 5
        load RB-HighDimension.mat RB
%         Data = RB(1:3:end,1:end-1);
%         Data_Tag = RB(1:3:end,end);
        Data = RB(:,1:end-1);
        Data_Tag = RB(:,end);
    %% Superconductivty Data Set
    case 6
        load Superconductivty.mat Superconductivty_Element1
%         load Superconductivty.mat Superconductivty
        Data = Superconductivty_Element1(1:2:end,2:end-1);
        Data_Tag = Superconductivty_Element1(1:2:end,end);
    %% Pyrim
    case 7
        load Pyrim-MediumDimension.mat Pyrim
%         Data = Pyrim(1:5:end,1:end-1);
%         Data_Tag = Pyrim(1:5:end,end);
        Data = Pyrim(:,1:end-1);
        Data_Tag = Pyrim(:,end);
    %% HousingDataSet
    case 8
        load Housing-MediumDimension.mat Housing
%         Data = Housing(1:5:end,1:end-1);
%         Data_Tag = Housing(1:5:end,end);
        Data = Housing(:,1:end-1);
        Data_Tag = Housing(:,end);
    %% Cleveland
    case 9
        load Cleveland-MediumDimension.mat Cleveland
%         Data = Cleveland(1:3:end,1:end-1);
%         Data_Tag = Cleveland(1:3:end,end);
        Data = Cleveland(:,1:end-1);
        Data_Tag = Cleveland(:,end);
    %% Concrete Compressive Strength
    case 10
        load CCS-LowDimension.mat CCS
%         Data = CCS(1:10:end,1:end-1);
%         Data_Tag = CCS(1:10:end,end);
        Data = CCS(:,1:end-1);
        Data_Tag = CCS(:,end);
    %% Abalone
    case 11
        load Abalone-LowDimension.mat Abalone
%         Data = Abalone(1:30:end,1:end-1);
%         Data_Tag = Abalone(1:30:end,end);
        Data = Abalone(:,1:end-1);
        Data_Tag = Abalone(:,end);
    %% Concrete Slump Test  
    case 12
        load CST-LowDimension.mat CST
        Data = CST(1:end,1:end-1);
        Data_Tag = CST(1:end,end);
    %% Strike
    case 13
        load Strike-LowDimension.mat Strike
%         Data = Strike(1:6:end,1:end-1);
%         Data_Tag = Strike(1:6:end,end);
        Data = Strike(:,1:end-1);
        Data_Tag = Strike(:,end);
    %% Basketball
    case 14
        load Basketball-LowDimension.mat Basketball
%         Data = Basketball(1:5:end,1:end-1);
%         Data_Tag = Basketball(1:5:end,end);
        Data = Basketball(:,1:end-1);
        Data_Tag = Basketball(:,end);
    
    otherwise
        disp('Please select correct data set ID');
end
end

