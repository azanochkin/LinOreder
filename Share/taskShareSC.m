function rankMat = taskShareSC(timeVec, nscRankMat, iscRankMat, isEqConsid, OptimFnc )
    % loss matrix
    fullLossMat = lossMatrix(timeVec,nscRankMat,iscRankMat,isEqConsid);
    % убрать единичные наблюдения
    maskMinRatesVec = sum(~(isnan(nscRankMat)&isnan(iscRankMat)),2)>=2;
    lossMat = fullLossMat(maskMinRatesVec,maskMinRatesVec);
    fprintf('-- > observations with 2 or greater ranks: %i\n',sum(maskMinRatesVec));
    %% квадратичный штраф
%     fullLossSqMat = lossSqMatrix(timeVec,nscRankMat,iscRankMat,isEqConsid);
%     lossSqMat = fullLossSqMat(maskMinRatesVec,maskMinRatesVec);
%     normSqConst = abs(sum(lossSqMat(:)));
    %% метризованное среднее
    nscCutRankMat = nscRankMat(maskMinRatesVec,:);
    [lossMetrMat,normMetrConst] = lossMetrMatrix(nscCutRankMat);
    %% вычисление медианы
    %lossCompMat = lossMat;
    %lossCompMat = lossMat+lossSqMat/normSqConst;
    lossCompMat = lossMat+lossMetrMat/normMetrConst;
    [tmpRankMat,penVec] = taskShare(lossCompMat,OptimFnc);
    %% восстановление значений функционалов
%     penLinVec = fix(penVec);
%     penAddVec = round((penVec - penLinVec)*normSqConst);
    %% дозаполнить единичные наблюдения
    rankMat = zeros(size(nscRankMat,1),size(tmpRankMat,2));
    indVec = [find(maskMinRatesVec);find(~maskMinRatesVec)];
    %
%     normSqConst = abs(sum(fullLossSqMat(:)));
%     fullLossCompMat = fullLossMat + fullLossSqMat/normSqConst;
    [fullLossMetrMat,normMetrConst] = lossMetrMatrix(nscRankMat);
    fullLossCompMat = fullLossMat + fullLossMetrMat/normMetrConst;
    %
    fullLossCompMat = fullLossCompMat(indVec,indVec);
    for i = 1:size(tmpRankMat,2)
        [rankMat(indVec,i), ~] = bestInsertion(fullLossCompMat,true,...
            tmpRankMat(:,i),0);%penLinVec(i)+penAddVec(i)/normSqConst);
        rankMat(indVec,i) = renumber(rankMat(indVec,i));
    end
end

