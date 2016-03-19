function consRankVec = rifling( proxRankVec, kemRankMat )
    nPopulation = size(kemRankMat,2);
    distVec = zeros(nPopulation,1);
    lossMat = lossMatrixLin(proxRankVec);
    pMask = ~isnan(proxRankVec);
    for i = 1:nPopulation
        distVec(i) = getPenalty(kemRankMat(:,i),lossMat);
    end
    minDist = min(distVec);
    indMin = find(distVec == minDist);
    consRankMat = zeros(size(kemRankMat,1),length(indMin));
    for i = 1:length(indMin)
        rankVec = kemRankMat(:,indMin(i));
        consRankMat(:,i) = classify1(rankVec,rankVec(pMask),proxRankVec(pMask),false);
    end
    consRankVec = round(median(consRankMat,2));%??????????????????????????????????????
end

