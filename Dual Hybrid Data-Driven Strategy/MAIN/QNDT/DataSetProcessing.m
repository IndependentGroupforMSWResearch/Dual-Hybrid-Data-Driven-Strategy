function [SplitData] = DataSetProcessing(X,Y,DataSetPara)
    SegMeth = DataSetPara.SegMeth;
    Number = DataSetPara.Number;
    %% 数据切分
    if Number == 2
        SplitData = TT_SampleGeneration(X,Y,SegMeth);
    elseif Number == 3
        SplitData = TVT_SampleGeneration(X,Y,SegMeth);
    end
    %% 数据处理
    SplitData = DataConvert(SplitData,DataSetPara);
end

