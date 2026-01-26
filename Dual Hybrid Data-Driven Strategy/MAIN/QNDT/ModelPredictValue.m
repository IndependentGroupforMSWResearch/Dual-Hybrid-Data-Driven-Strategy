function [Result] = ModelPredictValue(Model,DataSetPara,Parameter,SplitData)
    Number = DataSetPara.Number;
    StandOrNorm = DataSetPara.StandOrNorm;
    if StandOrNorm == 0
        MX = SplitData.TransMeanX;
        SX = SplitData.TransStanX;
        MY = SplitData.TransMeanY;
        SY = SplitData.TransStanY;
        if Number == 2
            % 训练集
            Result.TransTrainY = BFGSDT_Predict(Model,Parameter,SplitData.TransTrainX);
            Result.OriTrainY = rescale(Result.TransTrainY,MY,SY);
            ModelEvaluate(SplitData.OriTrainY,Result.OriTrainY,1,'训练集');
            % 测试集
            Result.TransTestingY = BFGSDT_Predict(Model,Parameter,SplitData.TransTestingX);
            Result.OriTestingY = rescale(Result.TransTestingY,MY,SY);
            ModelEvaluate(SplitData.OriTestingY,Result.OriTestingY,2,'测试集');
        else
            % 训练集
            Result.TransTrainY = BFGSDT_Predict(Model,Parameter,SplitData.TransTrainX);
            Result.OriTrainY = rescale(Result.TransTrainY,MY,SY);
            ModelEvaluate(SplitData.OriTrainY,Result.OriTrainY,1,'训练集');
            % 验证集
            Result.TransValidationY = BFGSDT_Predict(Model,Parameter,SplitData.TransValidationX);
            Result.OriValidationY = rescale(Result.TransValidationY,MY,SY);
            ModelEvaluate(SplitData.OriValidationY,Result.OriValidationY,2,'验证集');
            % 测试集
            Result.TransTestingY = BFGSDT_Predict(Model,Parameter,SplitData.TransTestingX);
            Result.OriTestingY = rescale(Result.TransTestingY,MY,SY);
            ModelEvaluate(SplitData.OriTestingY,Result.OriTestingY,3,'测试集');
        end
    else
            MaxX = SplitData.MaxX;
            MinX = SplitData.MinX;
            MaxY = SplitData.MaxY;
            MinY = SplitData.MinY;
            
        if Number == 2

            % 训练集
            Result.TransTrainY = BFGSDT_Predict(Model,Parameter,SplitData.TransTrainX);
            Result.OriTrainY = Result.TransTrainY .* (MaxY - MinY) + MinY;
            ModelEvaluate(SplitData.OriTrainY,Result.OriTrainY,1,'训练集');
            
            % 测试集
            Result.TransTestingY = BFGSDT_Predict(Model,Parameter,SplitData.TransTestingX);
            Result.OriTestingY = Result.TransTestingY .* (MaxY - MinY) + MinY;
            ModelEvaluate(SplitData.OriTestingY,Result.OriTestingY,2,'测试集');
            
        else
            % 训练集
            Result.TransTrainY = BFGSDT_Predict(Model,Parameter,SplitData.TransTrainX);
            Result.OriTrainY = Result.TransTrainY .* (MaxY - MinY) + MinY;
            ModelEvaluate(SplitData.OriTrainY,Result.OriTrainY,1,'训练集');
            % 验证集
            Result.TransValidationY = BFGSDT_Predict(Model,Parameter,SplitData.TransValidationX);
            Result.OriValidationY = Result.TransValidationY .* (MaxY - MinY) + MinY;
            ModelEvaluate(SplitData.OriValidationY,Result.OriValidationY,2,'验证集');
            % 测试集
            Result.TransTestingY = BFGSDT_Predict(Model,Parameter,SplitData.TransTestingX);
            Result.OriTestingY = Result.TransTestingY .* (MaxY - MinY) + MinY;
            ModelEvaluate(SplitData.OriTestingY,Result.OriTestingY,3,'测试集');
        end
    end


    
end

