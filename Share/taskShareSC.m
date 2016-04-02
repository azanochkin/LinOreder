function rankMat = taskShareSC(timeVec, nscRankMat, iscRankMat, isEqConsid, OptimFnc )
    % фиксировать рандом
    rng(1);
    % loss matrix
    fullLossMat = lossMatrix(timeVec,nscRankMat,iscRankMat,isEqConsid);
    fullLossSqMat = lossSqMatrix(timeVec,nscRankMat,iscRankMat,isEqConsid);
    % убрать единичные наблюдения
    maskMinRatesVec = sum(~(isnan(nscRankMat)&isnan(iscRankMat)),2)>=2;
    fprintf('-- > emitents with 1 or greater ranks: %i\n',sum(maskMinRatesVec));
    lossMat = fullLossMat(maskMinRatesVec,maskMinRatesVec);
    lossSqMat = fullLossSqMat(maskMinRatesVec,maskMinRatesVec);
    normSqConst = abs(sum(sum(lossSqMat)));
    %% метризованное среднее
    nscCutRankMat = nscRankMat(maskMinRatesVec,:);
    metrNscRankMat = nscCutRankMat./repmat(max(nscRankMat),size(nscCutRankMat,1),1);
    gambRankVec = GambMean(metrNscRankMat);
    repGambRankVec = repmat(gambRankVec,1,length(gambRankVec));
    lossMetrMat = repGambRankVec - repGambRankVec';
    lossMetrMat((lossMetrMat==0)&(~eye(size(lossMetrMat)))) = -min(abs(lossMetrMat(lossMetrMat~=0)))/3;
    normMetrConst = abs(sum(lossMetrMat(lossMetrMat<0)));
    %% вычисление медианы
    lossCompMat = lossMat;
    %lossCompMat = lossMat+lossSqMat/normSqConst;
    %lossCompMat = lossMat+lossMetrMat/normMetrConst;
    [tmpRankMat,penVec] = taskShare(lossCompMat,OptimFnc);
    %% восстановление значений функционалов
    penLinVec = fix(penVec);
    penSqVec = round((penVec - penLinVec)*normSqConst);
    %% дозаполнить единичные наблюдения
    rankMat = zeros(size(nscRankMat,1),size(tmpRankMat,2));
    indVec = [find(maskMinRatesVec);find(~maskMinRatesVec)];
    %
    normSqConst = abs(sum(sum(fullLossSqMat)));
    perlossMat = fullLossMat(indVec,indVec) + fullLossSqMat(indVec,indVec)/normSqConst;
    for i = 1:size(tmpRankMat,2)
        [rankMat(indVec,i), ~] = bestInsertion(perlossMat,true,...
            tmpRankMat(:,i),penLinVec(i)+penSqVec(i)/normSqConst);
    end
end

