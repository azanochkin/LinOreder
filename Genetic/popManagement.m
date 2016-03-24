function indSortVec = popManagement( rankMat, pnltVec, nPopulation)
%POPMANAGEMENT Summary of this function goes here
%   Detailed explanation goes here
    function indWorst = findWorst(pnltVec, distVec)
        pnltStd = std(pnltVec);
        distStd = std(distVec);
        if pnltStd == 0
            pnltStd = 1;
        end
        if distStd == 0
            distStd = 1;
        end
        utilVec = pnltVec/pnltStd + 0.5*distVec/distStd;
        minSum = min(utilVec);
        indWorst = find(utilVec == minSum);
        minPen = min(pnltVec(indWorst));
        indWorst = indWorst(find(minPen == pnltVec(indWorst),1,'last'));
    end
    distMat = linOrderDist(rankMat,rankMat);
    nRankings = length(pnltVec);
    indSortVec = 1:nRankings;
    nIter = 0;
    flag = true;
    while flag && (nIter<10)
        nIter = nIter + 1;
        flag = false;
        for i = (nPopulation+1):nRankings
            indVec = indSortVec([1:nPopulation,i]);
            locDistMat = distMat(indVec,indVec);
            maskMat = ~eye(nPopulation+1);
            locDistMat = reshape(locDistMat(maskMat),nPopulation,nPopulation+1);
            %distVec = sum(locDistMat)/nPopulation;% median???
            distVec = min(locDistMat);
            indWorst = findWorst(pnltVec(indVec), distVec);
            if indWorst <= nPopulation
                indSortVec([indWorst,i]) = indSortVec([i,indWorst]);
                flag = true;
            end
        end
    end
    %%
%     figure(1);
%     cla
%     hold on;plot(pnltVec,sum(distMat),'+')
%     tmpVec = sum(distMat(indSortVec,indSortVec));
%     plot(pnltVec(indSortVec(1:60)),tmpVec(1:60),'or')
end

