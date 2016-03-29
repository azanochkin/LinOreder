function rankMat = taskShareSC(timeVec, nscRankMat, iscRankMat, isEqConsid, OptimFnc )
    % фиксировать рандом
    rng(1);
    % loss matrix
    fullLossMat = lossMatrix(timeVec,nscRankMat,iscRankMat,isEqConsid);
    % убрать единичные наблюдения
    maskMinRatesVec = sum(~(isnan(nscRankMat)&isnan(iscRankMat)),2)>=2;
    lossMat = fullLossMat(maskMinRatesVec,maskMinRatesVec);
    %% вычисление медианы
    tmpRankMat = taskShare(lossMat, OptimFnc );
    %% дозаполнить единичные наблюдения
    rankMat = zeros(size(nscRankMat,1),size(tmpRankMat,2));
    indVec = [find(maskMinRatesVec);find(~maskMinRatesVec)];
    perlossMat = fullLossMat(indVec,indVec);
    parfor i = 1:size(tmpRankMat,2)
        [rankMat(indVec,i), ~] = bestInsertion(perlossMat,true,tmpRankMat(:,i));
    end
end

