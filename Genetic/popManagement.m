function indSortVec = popManagement( rankMat, pnltVec, distMat, nPopulation)
%POPMANAGEMENT Summary of this function goes here
%   Detailed explanation goes here
    nRankings = length(pnltVec);
    indSortVec = 1:nRankings;
    nIter = 0;
    flag = true;
    while flag && (nIter<40)
        nIter = nIter + 1;
        flag = false;
        for i = (nPopulation+1):nRankings
            indVec = indSortVec([1:nPopulation,i]);
            locDistMat = distMat(indVec,indVec);
            maskMat = ~eye(nPopulation+1);
            locDistMat = reshape(locDistMat(maskMat),nPopulation,nPopulation+1);
            %distVec = sum(locDistMat)/nPopulation;% median???
            distVec = min(locDistMat);
            indWorst = popWorstElem(pnltVec(indVec), distVec);
            if indWorst <= nPopulation
                indSortVec([indWorst,i]) = indSortVec([i,indWorst]);
                flag = true;
            end
        end
    end
    if flag
        disp('~~~~~~~~~~~~~~~~bad news from popManagement');
    end
    %%
    figure(1);
    cla
    hold on;plot(pnltVec,sum(distMat),'+')
    tmpVec = sum(distMat(indSortVec,indSortVec));
    plot(pnltVec(indSortVec(1:60)),tmpVec(1:60),'or')
end

