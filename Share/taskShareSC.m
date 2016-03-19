function rankMat = taskShareSC(timeVec, nscRankMat, iscRankMat, isEqConsid, OptimFnc )
    function [indEqVec, isFrstUniqVec] = fndEqElLossMatrix(lossMat)
        nAltern = size(lossMat,1);
        indEqVec = zeros(nAltern,1);
        isFrstUniqVec = true(nAltern,1);
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
            indEqVec(ii) = jj;
            isFrstUniqVec(ii) = ii == jj;
        end
    end
    % фиксировать рандом
    rng(11);
    % loss matrix
    fullLossMat = lossMatrix(timeVec,nscRankMat,iscRankMat,isEqConsid);
    % убрать единичные наблюдения
    maskMinRates = sum(~(isnan(nscRankMat)&isnan(iscRankMat)),2)>=2;
    lossMat = fullLossMat(maskMinRates,maskMinRates);
    % удалить повторы
    [indEqVec, isFrstUniqVec] = fndEqElLossMatrix(lossMat);
    grpLossMat = groupLossMatrix(lossMat, indEqVec);
    fprintf('Alternatives in lossMat: %i\n',sum(isFrstUniqVec));
    % 
    buzdShare( grpLossMat );
    % Optimization
    rankMat(isFrstUniqVec,:) = OptimFnc(grpLossMat);
    rankMat = rankMat(indEqVec,:);
    tmpRankMat = rankMat;
    % дозаполнить единичные наблюдения
    rankMat = zeros(size(nscRankMat,1),size(tmpRankMat,2));
    for i = 1:size(tmpRankMat,2)
        ind = [find(maskMinRates);find(~maskMinRates)];
        [rankMat(ind,i), ~] = bestInsertion(fullLossMat(ind,ind),true,tmpRankMat(:,i));
    end
end

