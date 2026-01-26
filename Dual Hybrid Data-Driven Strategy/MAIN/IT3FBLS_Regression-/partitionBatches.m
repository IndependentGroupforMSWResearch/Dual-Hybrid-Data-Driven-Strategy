function [batchesX, batchesY] = partitionBatches(X_dataAll, Y_dataAll, batchSize)
% =========================================================================
% 将 (X_dataAll, Y_dataAll) 按 batchSize 分成多批
% =========================================================================
    N = size(X_dataAll,1);
    Nb = ceil(N / batchSize);
    batchesX = cell(Nb,1);
    batchesY = cell(Nb,1);
    startIdx = 1;
    for b = 1:Nb
        endIdx = min(startIdx+batchSize-1, N);
        batchesX{b} = X_dataAll(startIdx:endIdx,:);
        batchesY{b} = Y_dataAll(startIdx:endIdx,:);
        startIdx = endIdx+1;
    end
end
