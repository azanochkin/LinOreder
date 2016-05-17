function [ newRankVec, newRankPen ] = insertionRegRnd( rankVec, rankPen,...
    lossMat, eqPen, shiftPen,varargin)
    nAltern = size(lossMat,1);
    [sortRankVec,orderVec] = sort(rankVec(:));
    isEqVec = [false; (sortRankVec(1:end-1)==sortRankVec(2:end))];
    isnCVec = true(nAltern,1);
    if isempty(varargin)
        scanOrdVec = randperm(nAltern);
    else
        scanOrdVec = varargin{1};
    end
    %for cOrd = scanOrdVec
    for i = 1:length(scanOrdVec)
        cOrd = scanOrdVec(i);
        cPos= find(orderVec==cOrd,1);
        isnCVec(cPos) = false;
        lVec = lossMat(orderVec(isnCVec),cOrd)';
        gVec = lossMat(cOrd,orderVec(isnCVec));
        isEqCVec = isEqVec(isnCVec);
        isnCVec(cPos) = true;
        if cPos < nAltern
            isEqCVec(cPos) = isEqCVec(cPos) && isEqVec(cPos);
        end
        [nePenVec,eqPenVec] = getInsertPen(lVec, gVec, isEqCVec);
        remPen = getRemPen(cPos,nePenVec,eqPenVec,isEqVec);
        [indPos,isEq,minPen] = bestInsPosRand(nePenVec,eqPenVec,eqPen,shiftPen);
        nPos = indFind([~isEqCVec; true], indPos);   
        if true%(nPos ~= cPos)||(maskEq(cPos)~=isEq)% modify
            if nPos<cPos
                lDiapVec = nPos+1:cPos;
                rDiapVec = nPos:cPos-1;
            else
                lDiapVec = cPos:nPos-1;
                rDiapVec = cPos+1:nPos;
            end
            if cPos < nAltern
                isEqVec(cPos+1) = isEqCVec(cPos);
            end
            isEqVec(lDiapVec) = isEqVec(rDiapVec);
            isEqVec(nPos) = false;
            if nPos < nAltern
                isEqVec(nPos+1) = isEq;
            end
            %
            cOrd = orderVec(cPos);
            orderVec(lDiapVec) = orderVec(rDiapVec);
            orderVec(nPos) = cOrd;
            %
            rankPen = rankPen + minPen - remPen;
        end
    end
    newRankVec = zeros(nAltern,1);
    posVec = find(~isEqVec);
    newRankVec(orderVec) = posVec(cumsum(~isEqVec));
    newRankPen = rankPen;
    %checkPenalty( newRankPen, newRankVec, lossMat,'INSERTION_RND')
end

