function [SplitData] = DataConvert(SplitData,DataSetPara)
    Number = DataSetPara.Number;
    StandOrNorm = DataSetPara.StandOrNorm;
    switch StandOrNorm
        %% 标准化
        case 0
            if Number == 2
                [SplitData.TransTrainX,MX,SX] = auto(SplitData.OriTrainX);
                [SplitData.TransTrainY,MY,SY] = auto(SplitData.OriTrainY);
                
                SplitData.TransTestingX = scale(SplitData.OriTestingX,MX,SX);
                SplitData.TransTestingY = scale(SplitData.OriTestingY,MY,SY);

                SplitData.TransMeanX = MX;
                SplitData.TransStanX = SX;
                SplitData.TransMeanY = MY;
                SplitData.TransStanY = SY;
            elseif  Number == 3
                [SplitData.TransTrainX,MX,SX] = auto(SplitData.OriTrainX);
                [SplitData.TransTrainY,MY,SY] = auto(SplitData.OriTrainY);
                SplitData.TransValidationX = scale(SplitData.OriValidationX,MX,SX);
                SplitData.TransValidationY = scale(SplitData.OriValidationY,MY,SY);
                SplitData.TransTestingX = scale(SplitData.OriTestingX,MX,SX);
                SplitData.TransTestingY = scale(SplitData.OriTestingY,MY,SY);

                SplitData.TransMeanX = MX;
                SplitData.TransStanX = SX;
                SplitData.TransMeanY = MY;
                SplitData.TransStanY = SY;
            end
        %% 归一化
        case 1
            if Number == 2
                MaxX = max(SplitData.OriTrainX);
                MinX = min(SplitData.OriTrainX);
                MaxY = max(SplitData.OriTrainY);
                MinY = min(SplitData.OriTrainY);

                SplitData.TransTrainX = (SplitData.OriTrainX - MinX)./(MaxX - MinX);
                SplitData.TransTestingX = (SplitData.OriTestingX - MinX)./(MaxX - MinX);

                SplitData.TransTrainY = (SplitData.OriTrainY - MinY)./(MaxY - MinY);
                SplitData.TransTestingY = (SplitData.OriTestingY - MinY)./(MaxY - MinY);

                SplitData.MaxX = MaxX;
                SplitData.MinX = MinX;
                SplitData.MaxY = MaxY;
                SplitData.MinY = MinY;
                
            elseif Number == 3
                MaxX = max(SplitData.OriTrainX);
                MinX = min(SplitData.OriTrainX);
                MaxY = max(SplitData.OriTrainY);
                MinY = min(SplitData.OriTrainY);

                SplitData.TransTrainX = (SplitData.OriTrainX - MinX)./(MaxX - MinX);
                SplitData.TransValidationX = (SplitData.OriValidationX - MinX)./(MaxX - MinX);
                SplitData.TransTestingX = (SplitData.OriTestingX - MinX)./(MaxX - MinX);

                SplitData.TransTrainY = (SplitData.OriTrainY - MinY)./(MaxY - MinY);
                SplitData.TransValidationY = (SplitData.OriValidationY - MinY)./(MaxY - MinY);
                SplitData.TransTestingY = (SplitData.OriTestingY - MinY)./(MaxY - MinY);

                SplitData.MaxX = MaxX;
                SplitData.MinX = MinX;
                SplitData.MaxY = MaxY;
                SplitData.MinY = MinY;
                
                Data.MaxX = SplitData.MaxX;
                Data.MinX = SplitData.MinX;
                Data.MaxY = SplitData.MaxY;
                Data.MinY = SplitData.MinY;
            end
    end

end

