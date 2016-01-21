function [ rankVec, kemenyDist ] = bestInsertionNew(lossMatNE, lossMatE)
% идея вставки в мередину класса эквивалентности должна быть проведена с
% осторожностью. Возможны проблемы с выбором стартовой точки следующей
% итерации. Это должна быть первая точка текущего класса.
    nAltern = size(lossMatNE,1);
    %
    sortRankVec = zeros(nAltern,1);
    altOrder = zeros(nAltern,1);
    rankVec = zeros(nAltern,1);
    %
    sortRankVec(1) = 1;
    altOrder(1) = 1;
    kemenyDist = 0;
    for k = 2:nAltern
        %
        kMask = true(nAltern,1);
        kMask(k:end) = false;
        lVec = lossMatNE(altOrder(kMask),k)';
        gVec = lossMatNE(k,altOrder(kMask));
        eVec = lossMatE(k,altOrder(kMask));
        % стоисть вставки перед (improve it)
        lMat = repmat(lVec(kMask),k,1);
        gMat = repmat(gVec(kMask),k,1);
        neMat = tril(lMat,-1) + triu(gMat,0);
        nePenVec = sum(neMat,2);
        % стоимость вставки внутрь группы
        eMat = repmat(eVec(kMask),k-1,1);
        eqMat = neMat(1:end-1,:);
        sortrankMat = repmat(sortRankVec(kMask),1,k-1);
        mask = sortrankMat==sortrankMat';
        eqMat(mask) = eMat(mask);
        eqPenVec = sum(eqMat,2);
        % выбор наилучшей позиции для вставки
        tmp = sortRankVec(kMask);
        maskEqVec = true(k,1);
        maskEqVec(2:end-1) = tmp(1:end-1)~=tmp(2:end);
        minPenNE = min(nePenVec(maskEqVec));
        minPenE = min(eqPenVec(maskEqVec(1:end-1)));
        %
        if minPenNE < minPenE %<=
            maskEqVec(maskEqVec) = nePenVec(maskEqVec) == minPenNE;
            mInd = find(maskEqVec,1);
            sortRankVec(mInd+1:k) = sortRankVec(mInd:k-1);
            if mInd == 1
                sortRankVec(mInd) = 1;
            else 
                sortRankVec(mInd) = sortRankVec(mInd-1) + 1;
            end
            sortRankVec(mInd+1:k) = sortRankVec(mInd+1:k) + 1;
            altOrder(mInd+1:k) = altOrder(mInd:k-1);
            altOrder(mInd) = k;
            kemenyDist = kemenyDist + minPenNE;
        else
            maskEqVec = maskEqVec(1:end-1);
            maskEqVec(maskEqVec) = eqPenVec(maskEqVec) == minPenE;
            mInd = find(maskEqVec,1);
            sortRankVec(mInd+1:k) = sortRankVec(mInd:k-1);
            sortRankVec(mInd) = sortRankVec(mInd+1);
            altOrder(mInd+1:k) = altOrder(mInd:k-1);
            altOrder(mInd) = k;
            kemenyDist = kemenyDist + minPenE;
        end
%             rankVec(altOrder(1:k)) = sortRankVec(1:k);
%             realPenalty = getPenalty(rankVec(1:k),lossMatNE(1:k,1:k), lossMatE(1:k,1:k));
%             fprintf('INSERTION_insd> real: %i , comp: %i \n',realPenalty, kemenyDist);
    end 
    [~,~,sortRankVec] = unique(sortRankVec);
    rankVec(altOrder) = sortRankVec;
        realPenalty = getPenalty(rankVec,lossMatNE, lossMatE);
        fprintf('BEST_INSERTION_NEW> real: %i , comp: %i \n',realPenalty, kemenyDist);
end