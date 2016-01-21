function [ rankVec, kemenyDist ] = insertion(rankVec, lossMatNE, lossMatE)
    function rankVec = getRank(altOrder,maskEq)
        rankVec = zeros(nAltern,1);
        rankVec(altOrder) = 1:nAltern;
        for j = 2:nAltern
            if maskEq(j,j-1)
                rankVec(altOrder(j)) = rankVec(altOrder(j-1));
            end
        end
    end
    nAltern = size(lossMatNE,1);
    %
    [sortRankVec,altOrder] = sort(rankVec);
    sortrankMat = repmat(sortRankVec(:),1,nAltern);
    maskEq = sortrankMat==sortrankMat';
    %
    kemenyDist = getPenalty(rankVec,lossMatNE, lossMatE);
    k = 1;
    while k <= nAltern
        l = altOrder(k);
        %
        lVec = lossMatNE(altOrder,l)';
        gVec = lossMatNE(l,altOrder);
        eVec = lossMatE(l,altOrder);
        %
        takeVec = [lVec(1:k),gVec(k+1:end)];
        takeVec(maskEq(k,:)) = eVec(maskEq(k,:));
        takePen = sum(takeVec);
        %
        kMask = true(nAltern,1);
        kMask(k) = false;
        lMat = repmat(lVec(kMask),nAltern,1);
        gMat = repmat(gVec(kMask),nAltern,1);
        neMat = tril(lMat,-1) + triu(gMat,0);
        nePenVec = sum(neMat,2);
        %
        eMat = repmat(eVec(kMask),nAltern-1,1);
        eqMat = neMat(1:end-1,:);
        mask = maskEq(kMask,kMask);
        eqMat(mask) = eMat(mask);
        eqPenVec = sum(eqMat,2);
        % убрать эквивалентные алтернативы
        [mPen,mInd] = min([eqPenVec;nePenVec] - takePen);
        if mPen<0
            flag = mInd>=nAltern;
            if flag 
                mInd = mInd - nAltern + 1;
            end
            if mInd>k
                'not ok'
                mInd = mInd-1;
                leftPos = k:mInd;
                rightPos = [k+1:mInd,k];
            else
                'ok'
                leftPos = mInd:k;
                rightPos = [k,mInd:k-1];
            end
            %maskEq(leftPos,leftPos) = maskEq(rightPos,rightPos);
            maskEq(leftPos,:) = maskEq(rightPos,:);
            maskEq(:,leftPos) = maskEq(:,rightPos);
            if flag 
                maskEq(mInd,:) = false;
                maskEq(:,mInd) = false;
                maskEq(mInd,mInd) = true;
            else
                maskEq(mInd,:) = maskEq(mInd+1,:);
                maskEq(:,mInd) = maskEq(:,mInd+1);
            end
            altOrder(leftPos) = altOrder(rightPos);
            kemenyDist = kemenyDist + mPen;
            realPenalty = getPenalty(getRank(altOrder,maskEq),lossMatNE, lossMatE);
            fprintf('HEUR_LIN> real: %i , comp: %i \n',realPenalty, kemenyDist);
            k = min(k-1,mInd);
        end
        k = k + 1;
    end
    rankVec = getRank(altOrder,maskEq);
    realPenalty = getPenalty(rankVec,lossMatNE, lossMatE);
    fprintf('HEUR_LIN> real: %i , comp: %i \n',realPenalty, kemenyDist);
end

