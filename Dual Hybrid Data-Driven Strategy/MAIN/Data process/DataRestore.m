function RawData = DataRestore(Data,ParaData,DataSpliTran)
% 标准化和归一化数据数据还�?
StanOrNorm = ParaData.StanOrNorm;

if StanOrNorm
    MY = DataSpliTran.TransformMeanY;
    SY = DataSpliTran.TransformStanY;
    RawData = rescale(Data,MY,SY);
end

if ~StanOrNorm
    NormDown = DataSpliTran.TransformNormDown;
    NormUp = DataSpliTran.TransformNormUp ;
    YTrai = DataSpliTran.OriginalY1;
    RawData = ReNormalization(YTrai, Data, NormDown,NormUp);
end

end