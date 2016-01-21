function [ rankVec, kemenyDist ] = insertion1(rankVec, lossMatNE, lossMatE)
    function [nePenVec , eqPenVec] = getInsPen(lVec, gVec, eVec, maskEq) 
        lMat = [0 cumsum(lVec(end:-1:1))];
        lMat = lMat(end:-1:1);
        gMat = [0 cumsum(gVec)];
        nePenVec = lMat + gMat;
        %
        l = length(eVec);
        eqPenVec = zeros(1,l);
        for t = 1:l
            eqPenVec(t) = lMat(t) + eVec(t);
            q = 1;
            while maskEq(t+q)
                eqPenVec(t) = eqPenVec(t) + eVec(t+q);
                q = q + 1;
            end
            eqPenVec(t) = eqPenVec(t) + gMat(t+q);
        end
    end
% идея вставки в мередину класса эквивалентности должна быть проведена с
% осторожностью. Возможны проблемы с выбором стартовой точки следующей
% итерации. Это должна быть первая точка текущего класса.
    nAltern = size(lossMatNE,1);
    [sortRankVec,altOrder] = sort(rankVec);
    isnFrstRank = true(nAltern,1);
    isnFrstRank(2:end) = sortRankVec(1:end-1) == sortRankVec(2:end);
    %
    kemenyDist = getPenalty(rankVec,lossMatNE,lossMatE);
    k = 1;
    while k <= nAltern      
        l = altOrder(k);
        %
        lVec = lossMatNE(altOrder,l);
        gVec = lossMatNE(l,altOrder)';
        eVec = lossMatE(l,altOrder)';
        % вычисяем стоимость изъятия
        takeVec = [lVec(1:k),gVec(k+1:end)]; %replace
        mask = sortRankVec==sortRankVec(k);
        takeVec(mask) = eVec(mask);
        takePen = sum(takeVec);
        % стоисть вставки перед (improve it)
        kMask = true(nAltern,1); %raplace
        kMask(k) = false;
        [nePenVec , eqPenVec] = getInsPen(lVec(kMask), gVec(kMask), eVec(kMask), isnFrstRank(kMask));
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