function rankMat = taskShareSC(timeVec, nscRankMat, iscRankMat, OptimFnc )
    function indEq = fndEqElLossMatrix(lossMat)
        nAltern = size(lossMat,1);
        indEq = zeros(nAltern,1);
        mask = true(nAltern,1);
        for ii = 1:nAltern
            mask(ii) = false;
            jj = 1;
            mask(jj) = false;
            while any(lossMat(ii,mask)~=lossMat(jj,mask)) || ...
                    any(lossMat(mask,ii)~=lossMat(mask,jj)) || ...
                    (lossMat(ii,jj)>0) || (lossMat(jj,ii)>0)
                mask(jj) = true;
                jj = jj + 1;
                mask(jj) = false;
            end
            mask(jj) = true;
            mask(ii) = true;
            indEq(ii) = jj;
        end
    end
    function lossMat = groupLossMatrix(initLossMat, indEq)
        nAltern = length(indEq);
        mask = indEq == (1:nAltern)';
        dVec = zeros(nAltern,1);
        for ii = 1:nAltern
            dVec(indEq(ii)) = dVec(indEq(ii)) + 1;
        end
        dMat = diag(dVec(mask));
        lossMat = dMat*initLossMat(mask,mask)*dMat;
    end
    % фиксировать рандом
    rng(1);
    % удалить повторы и убрать единичные наблюдения
    maskMinRates = sum(~(isnan(nscRankMat)&isnan(iscRankMat)),2)>=2;
    %
%     indEq = fndEq(initRankMat(maskMinRates,:));
%     fprintf('rankMat: %i\n',sum(indEq == (1:sum(maskMinRates))'));
    %
    fullLossMat = lossMatrix(timeVec,nscRankMat,iscRankMat);
    lossMat = fullLossMat(maskMinRates,maskMinRates);
    %lossMat = fullLossMat;
    indLossEq = fndEqElLossMatrix(lossMat);
    fprintf('Alternatives in lossMat: %i\n',sum(indLossEq == (1:length(indLossEq))'));
    grpLossMat = groupLossMatrix(lossMat, indLossEq);
    %
    [tmpRankMat, ~] = OptimFnc(grpLossMat);
    rankMat(indLossEq==(1:length(indLossEq))',:) = tmpRankMat;
    rankMat = rankMat(indLossEq,:);
    tmpRankMat = rankMat;
    %
    rankMat = zeros(size(nscRankMat,1),size(tmpRankMat,2));
    for i = 1:size(tmpRankMat,2)
        ind = [find(maskMinRates);find(~maskMinRates)];
        [rankMat(ind,i), ~] = bestInsertion(fullLossMat(ind,ind),true,tmpRankMat(:,i));
    end
end

