function [rankVec,kemenyDist] = bestInsertion(lossMat)
    nAltern = size(lossMat,1);
    altOrder = zeros(nAltern,1);
    altOrder(1) = 1;
    kemenyDist = 0;
    maskEq = false(nAltern,1);
    numGrid = 1:nAltern;
    for l = 2:nAltern
        lVec = lossMat(altOrder(1:l-1),l)';
        gVec = lossMat(l,altOrder(1:l-1));
        [nePenVec,eqPenVec] = getInsertPen(lVec, gVec, maskEq(1:l-1));
        %
        [ind,isEq,kemAdd] = bestInsPos(nePenVec,eqPenVec);
        tmpNumGrid = numGrid(~maskEq);
        n = tmpNumGrid(ind);
        maskEq(n) = isEq;
        %
        maskEq(n+1:l) = maskEq(n:l-1);
        maskEq(n) = false;
        altOrder(n+1:l) = altOrder(n:l-1);
        altOrder(n) = l;
        kemenyDist = kemenyDist + kemAdd;
    end
    rankVec = zeros(nAltern,1);
    rankVec(altOrder) = cumsum(~maskEq);
    realPenalty = getPenalty(rankVec,lossMat);
    fprintf('BEST_INSERTION> real: %i , comp: %i \n',realPenalty, kemenyDist);
end