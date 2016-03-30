function [ newRankVec, kemenyDist ] = insertionRnd(rankVec, kemenyDist, lossMat)
    nAltern = size(lossMat,1);
    [sortRankVec,altOrder] = sort(rankVec(:));
    maskEq = [false; (sortRankVec(1:end-1)==sortRankVec(2:end))];
    numGrid = 1:nAltern;
    cntr = 0;
    kGrid = randi(nAltern,1,2*nAltern);
    kGrid = [kGrid,  1:nAltern, 1:nAltern];
    for k = kGrid
        cntr = cntr+1;
        l = altOrder(k);
        % стоисть вставки
        kMask = true(nAltern,1);
        kMask(k) = false;
        lVec = lossMat(altOrder(kMask),l)';
        gVec = lossMat(l,altOrder(kMask));
        tmpMaskEq = maskEq(kMask);
        if k < nAltern
            tmpMaskEq(k) = tmpMaskEq(k) && maskEq(k);
        end
        [nePenVec,eqPenVec] = getInsertPen(lVec, gVec, tmpMaskEq);
        % стоимость изъ€ти€
        iskEq = maskEq(k);
        if k < nAltern
            iskEq = iskEq || maskEq(k+1);
        end
        r = sum(~maskEq(1:k));
        if iskEq
            takePen = eqPenVec(r);
        else
            takePen = nePenVec(r);
        end
        %
        [n,isEq,minPen] = bestInsPos(nePenVec,eqPenVec,true);
        if minPen < takePen
            tmpNumGrid = numGrid([~tmpMaskEq; true]);
            n = tmpNumGrid(n);   
            if n<k
                lDiap = n+1:k;
                rDiap = n:k-1;
            else
                lDiap = k:n-1;
                rDiap = k+1:n;
            end
            if k < nAltern
                maskEq(k+1) = tmpMaskEq(k);
            end
            maskEq(lDiap) = maskEq(rDiap);
            maskEq(n) = false;
            if n < nAltern
                maskEq(n+1) = isEq;
            end
            %
            l = altOrder(k);
            altOrder(lDiap) = altOrder(rDiap);
            altOrder(n) = l;
            kemenyDist = kemenyDist + minPen - takePen;
        end
    end
    newRankVec = zeros(nAltern,1);
    posVec = find(~maskEq);
    newRankVec(altOrder) = posVec(cumsum(~maskEq));
    realPenalty = getPenalty(newRankVec,lossMat);
    fprintf('INSERTION> real: %i , comp: %i , counter: %i\n',realPenalty, kemenyDist, cntr);            
end

