function indSortVec = popManagement1( rankMat, pnltVec, distMat, nPopulation)
%POPMANAGEMENT Summary of this function goes here
%   Detailed explanation goes here
    nRankings = length(pnltVec);
    isInPopVec = true(nRankings,1);
    for nCurPop = nRankings:-1:(nPopulation+1)
        locDistMat = distMat(isInPopVec,isInPopVec);
        maskMat = ~eye(nCurPop);
        locDistMat = reshape(locDistMat(maskMat),nCurPop-1,nCurPop);
        distVec = sum(locDistMat)/nCurPop;% median???
        %distVec = min(locDistMat);
        indWorst = popWorstElem(pnltVec(isInPopVec), distVec);
        indSortVec = find(isInPopVec);
        indWorst = indSortVec(indWorst);
        isInPopVec(indWorst) = false;
    end
    indSortVec = find(isInPopVec);
    %%
    figure(1);
    cla
    hold on;plot(pnltVec,sum(distMat),'+')
    tmpVec = sum(distMat(:,indSortVec));
    plot(pnltVec(indSortVec),tmpVec,'or')
end

