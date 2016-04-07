function [rankVec,kemenyDist] = bestInsertion(lossMat,varargin)
    nAltern = size(lossMat,1);
    numGrid = 1:nAltern;
    altOrder = zeros(nAltern,1);
    maskEq = false(nAltern,1);
    %
    if nargin == 1
        isEqPrior = true;
    else
        isEqPrior = varargin{1};
    end
    %
    if nargin > 2
        initRankVec = varargin{2};
        [sortInitRankVec, initAltOrder] = sort(initRankVec);
        lnAltOrd = length(initAltOrder);
        altOrder(1:lnAltOrd) = initAltOrder;
        maskEq(2:lnAltOrd) = sortInitRankVec(1:end-1) == sortInitRankVec(2:end);
        stPnt = lnAltOrd + 1;
        kemenyDist = varargin{3} + sum(diag(lossMat(stPnt:end,stPnt:end)));
    else
        altOrder(1) = 1;
        stPnt = 2;
        kemenyDist = sum(diag(lossMat));
    end
    %
    for l = stPnt:nAltern
        lVec = lossMat(altOrder(1:l-1),l)';
        gVec = lossMat(l,altOrder(1:l-1));
        [nePenVec,eqPenVec] = getInsertPen(lVec, gVec, maskEq(1:l-1));
        %
        [ind,isEq,kemAdd] = bestInsPos(nePenVec,eqPenVec,isEqPrior);
        tmpNumGrid = numGrid(~maskEq);
        n = tmpNumGrid(ind);
        %
        maskEq(n) = isEq;
        maskEq(n+1:l) = maskEq(n:l-1);
        maskEq(n) = false;
        altOrder(n+1:l) = altOrder(n:l-1);
        altOrder(n) = l;
        kemenyDist = kemenyDist + kemAdd;
    end
    rankVec = zeros(nAltern,1);
    posVec = find(~maskEq);
    rankVec(altOrder) = posVec(cumsum(~maskEq));
    %checkPenalty( kemenyDist, rankVec, lossMat,'BEST_INSERTION');
end