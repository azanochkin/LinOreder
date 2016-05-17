function [ newRankVec, newRankPen ] = insertion(rankVec, rankPen, lossMat, eqPen, shiftPen)
    nAltern = size(lossMat,1);
    [sortRankVec,orderVec] = sort(rankVec(:));
    isEqVec = [false; (sortRankVec(1:end-1)==sortRankVec(2:end))];
    isnCVec = true(nAltern,1);
    cPos = 1;
    cntr = 0;
    while (cPos <= nAltern) && (cntr < nAltern*200)
        cntr = cntr+1;
        cOrd = orderVec(cPos);
        isnCVec(cPos) = false;
        lVec = lossMat(orderVec(isnCVec),cOrd)';
        gVec = lossMat(cOrd,orderVec(isnCVec));
        isEqCVec = isEqVec(isnCVec);
        if cPos < nAltern
            isEqCVec(cPos) = isEqVec(cPos+1) && isEqVec(cPos);
        end
        isnCVec(cPos) = true;
        [nePenVec,eqPenVec] = getInsertPen(lVec, gVec, isEqCVec);
        remPen = getRemPen(cPos,nePenVec,eqPenVec,isEqVec);
        [indPos,isEq,minPen] = bestInsPosRand(nePenVec,eqPenVec,eqPen,shiftPen);
        if minPen < remPen
            nPos = indFind([~isEqCVec; true], indPos);   
            if nPos<cPos
                lDiapVec = nPos+1:cPos;
                rDiapVec = nPos:cPos-1;
            else
                lDiapVec = cPos:nPos-1;
                rDiapVec = cPos+1:nPos;
            end
            if cPos < nAltern
                isEqVec(cPos+1) = isEqVec(cPos+1) && isEqVec(cPos);
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
            %
            cPos = min(cPos-1,nPos);
        end
        %
        cPos = cPos + 1;
    end
    newRankVec = zeros(nAltern,1);
    posVec = find(~isEqVec);
    newRankVec(orderVec) = posVec(cumsum(~isEqVec));
    newRankPen = rankPen;
    %checkPenalty( newRankPen, newRankVec, lossMat,'INSERTION')
end

