function [DataSpliTran] = StanOrNorm(ParaData,DataSpliTran)
% 数据预处理
% 数据标准化和归一化// ProcStra=1:标准化，ProcStra=2:归一化
SpliStra = ParaData.spliNumb;
if SpliStra == 2
    ProcStra = ParaData.StanOrNorm;
    if ProcStra
        % 数据标准化处理
        [DataSpliTran.TransformX1,MX,SX] = auto(DataSpliTran.OriginalX1);
        [DataSpliTran.TransformY1,MY,SY] = auto(DataSpliTran.OriginalY1);
        DataSpliTran.TransformMeanX = MX;
        DataSpliTran.TransformStanX = SX;
        DataSpliTran.TransformMeanY = MY;
        DataSpliTran.TransformStanY = SY;
        DataSpliTran.TransformX1 = rmmissing(DataSpliTran.TransformX1,2);
        % 测试集 
        DataSpliTran.TransformX2 = scale(DataSpliTran.OriginalX2,MX,SX);
        DataSpliTran.TransformY2 = scale(DataSpliTran.OriginalY2,MY,SY);
        DataSpliTran.TransformX2 = rmmissing(DataSpliTran.TransformX2,2);
    end
    if ~ProcStra
    % 数据归一化处理
    NormDown = 0;
    NormUp = 1;
    [DataSpliTran.TransformX1, DataSpliTran.TransformX2] = Normalization...
        ( NormDown, NormUp,DataSpliTran.OriginalX1,DataSpliTran.OriginalX2);
    [DataSpliTran.TransformY1, DataSpliTran.TransformY2] = Normalization...
        (NormDown, NormUp,DataSpliTran.OriginalY1,DataSpliTran.OriginalY2);
    DataSpliTran.TransformNormDown = NormDown;
    DataSpliTran.TransformNormUp = NormUp;
    end
end
if  SpliStra == 3
    ProcStra = ParaData.StanOrNorm;
    if ProcStra
        % 数据标准化处理
        [DataSpliTran.TransformX1,MX,SX] = auto(DataSpliTran.OriginalX1);
        [DataSpliTran.TransformY1,MY,SY] = auto(DataSpliTran.OriginalY1);
        DataSpliTran.TransformX1 = rmmissing(DataSpliTran.TransformX1,2);
        DataSpliTran.TransformMeanX = MX;
        DataSpliTran.TransformStanX = SX;
        DataSpliTran.TransformMeanY = MY;
        DataSpliTran.TransformStanY = SY;
        % 验证集
        DataSpliTran.TransformX2 = scale(DataSpliTran.OriginalX2,MX,SX);
        DataSpliTran.TransformY2 = scale(DataSpliTran.OriginalY2,MY,SY);
        DataSpliTran.TransformX2 = rmmissing(DataSpliTran.TransformX2,2);
        % 测试集 
        DataSpliTran.TransformX3 = scale(DataSpliTran.OriginalX3,MX,SX);
        DataSpliTran.TransformY3 = scale(DataSpliTran.OriginalY3,MY,SY);
        DataSpliTran.TransformX3 = rmmissing(DataSpliTran.TransformX3,2);
    end
    if ~ProcStra
    % 数据归一化处理
    NormDown = 0;
    NormUp = 1;
    [DataSpliTran.TransformX1, DataSpliTran.TransformX2, DataSpliTran.TransformX3] = Normalization...
        (NormDown,NormUp,DataSpliTran.OriginalX1,DataSpliTran.OriginalX2,DataSpliTran.OriginalX3);
    [DataSpliTran.TransformY1, DataSpliTran.TransformY2, DataSpliTran.TransformY3] = Normalization...
        (NormDown,NormUp,DataSpliTran.OriginalY1,DataSpliTran.OriginalY2,DataSpliTran.OriginalY3);
    DataSpliTran.TransformNormDown = NormDown;
    DataSpliTran.TransformNormUp = NormUp;
    end
end