function [ newRankVec, kemenyDist ] = insertion(rankVec, lossMat, varargin)
    function pen = remPen(curPos,nePenVec,eqPenVec,maskEq)
        iskEq = maskEq(curPos);
        if curPos < length(maskEq)
            iskEq = iskEq || maskEq(curPos+1);
        end
        r = sum(~maskEq(1:curPos));
        if iskEq
            pen = eqPenVec(r);
        else
            pen = nePenVec(r);
        end
    end
    if nargin == 2
        isEqPrior = true;
    else
        isEqPrior = varargin{1};
    end
    nAltern = size(lossMat,1);
    [sortRankVec,altOrder] = sort(rankVec(:));
    maskEq = [false; (sortRankVec(1:end-1)==sortRankVec(2:end))];
    kemenyDist = getPenalty(rankVec,lossMat);
    k = 1;
    numGrid = 1:nAltern;
    cntr = 0;
    while k <= nAltern
        cntr = cntr+1;
        l = altOrder(k);
        kMask = true(nAltern,1);
        kMask(k) = false;
        lVec = lossMat(altOrder(kMask),l)';
        gVec = lossMat(l,altOrder(kMask));
        tmpMaskEq = maskEq(kMask);
        if k < nAltern
            tmpMaskEq(k) = tmpMaskEq(k) && maskEq(k);
        end
        [nePenVec,eqPenVec] = getInsertPen(lVec, gVec, tmpMaskEq);
        takePen = remPen(k,nePenVec,eqPenVec,maskEq);
        [n,isEq,minPen] = bestInsPos(nePenVec,eqPenVec,isEqPrior);
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
            k = min(k-1,n);
            %
%             newRankVec(altOrder) = cumsum(~maskEq);
%             realPenalty = getPenalty(newRankVec,lossMat);
%             fprintf('INSERTION(in)> real: %i , comp: %i \n',realPenalty, kemenyDist);
            %
        end
        %
        k = k + 1;
    end
    newRankVec = zeros(nAltern,1);
    posVec = find(~maskEq);
    newRankVec(altOrder) = posVec(cumsum(~maskEq));
%     realPenalty = getPenalty(newRankVec,lossMat);
%     fprintf('INSERTION> real: %i , comp: %i , counter: %i\n',realPenalty, kemenyDist, cntr);            
end

