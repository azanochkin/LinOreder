function [ rankVec, kemenyDist ] = insertion(rankVec, lossMatNE, lossMatE)
% идея вставки в мередину класса эквивалентности должна быть проведена с
% осторожностью. Возможны проблемы с выбором стартовой точки следующей
% итерации. Это должна быть первая точка текущего класса.
    nAltern = size(lossMatNE,1);
    %
    [sortRankVec,altOrder] = sort(rankVec);
    %
    kemenyDist = getPenalty(rankVec,lossMatNE,lossMatE);
    k = 1;
    while k <= nAltern      
        l = altOrder(k);
        %
        lVec = lossMatNE(altOrder,l)';
        gVec = lossMatNE(l,altOrder);
        eVec = lossMatE(l,altOrder);
        % вычисяем стоимость изъятия
        takeVec = [lVec(1:k),gVec(k+1:end)]; %replace
        mask = sortRankVec==sortRankVec(k);
        takeVec(mask) = eVec(mask);
        takePen = sum(takeVec);
        % стоисть вставки перед (improve it)
        kMask = true(nAltern,1); %raplace
        kMask(k) = false;
        lMat = repmat(lVec(kMask),nAltern,1);
        gMat = repmat(gVec(kMask),nAltern,1);
        neMat = tril(lMat,-1) + triu(gMat,0);
        nePenVec = sum(neMat,2);
        % стоимость вставки внутрь группы
        eMat = repmat(eVec(kMask),nAltern-1,1);
        eqMat = neMat(1:end-1,:);
        sortrankMat = repmat(sortRankVec(kMask),1,nAltern-1);
        mask = sortrankMat==sortrankMat';
        eqMat(mask) = eMat(mask);
        eqPenVec = sum(eqMat,2);
        % выбор наилучшей позиции для вставки
        tmp = sortRankVec(kMask);
        maskEqVec = true(nAltern,1);
        maskEqVec(2:end-1) = tmp(1:end-1)~=tmp(2:end);
        minPenNE = min(nePenVec(maskEqVec));
        minPenE = min(eqPenVec(maskEqVec(1:end-1)));
        if min(minPenNE,minPenE) < takePen
            % при изъятии понижаем уровень у всех, кто выше
            mask = sortRankVec==sortRankVec(k);
            mask(k) = false;
            if ~any(mask)
                sortRankVec(k+1:end) = sortRankVec(k+1:end) -1;
            end
            if minPenNE < minPenE %<=
                maskEqVec(maskEqVec) = nePenVec(maskEqVec) == minPenNE;
                mInd = find(maskEqVec,1);
                if mInd>k
                    leftPos = k:mInd;
                    rightPos = [k+1:mInd,k];
                else
                    leftPos = mInd:k;
                    rightPos = [k,mInd:k-1];
                end
                sortRankVec(leftPos) = sortRankVec(rightPos);
                if mInd == 1
                    sortRankVec(mInd) = 1;
                else 
                    sortRankVec(mInd) = sortRankVec(mInd-1) + 1;
                end
                sortRankVec(mInd+1:end) = sortRankVec(mInd+1:end) + 1;
                altOrder(leftPos) = altOrder(rightPos);
                kemenyDist = kemenyDist + minPenNE - takePen;
            else
                maskEqVec = maskEqVec(1:end-1);
                maskEqVec(maskEqVec) = eqPenVec(maskEqVec) == minPenE;
                mInd = find(maskEqVec,1);
                if mInd>k
                    leftPos = k:mInd;
                    rightPos = [k+1:mInd,k];
                else
                    leftPos = mInd:k;
                    rightPos = [k,mInd:k-1];
                end
                sortRankVec(leftPos) = sortRankVec(rightPos);
                sortRankVec(mInd) = sortRankVec(mInd+1);
                altOrder(leftPos) = altOrder(rightPos);
                kemenyDist = kemenyDist + minPenE - takePen;
            end
%                 rankVec(altOrder) = sortRankVec;
%                 realPenalty = getPenalty(rankVec,lossMatNE, lossMatE);
%                 fprintf('INSERTION_insd> real: %i , comp: %i \n',realPenalty, kemenyDist);
            k = min(k-1,mInd);
        end
        k = k + 1;
    end 
    [~,~,sortRankVec] = unique(sortRankVec);
    rankVec(altOrder) = sortRankVec;
        realPenalty = getPenalty(rankVec,lossMatNE, lossMatE);
        fprintf('INSERTION> real: %i , comp: %i \n',realPenalty, kemenyDist);
end