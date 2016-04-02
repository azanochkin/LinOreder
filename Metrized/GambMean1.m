function resRankVec = GambMean1(rankVecMat)
    resRankVec = NaN(size(rankVecMat,1),1);
    mask = ~all(isnan(rankVecMat),2);
    rankVecMat = rankVecMat(mask,:);
    nAltern = size(rankVecMat,1);
    nExpert = size(rankVecMat,2);
    W = zeros(nAltern,nExpert);
    A = zeros(nAltern,nAltern);
    for k = 1:nExpert
        rankVec = rankVecMat(:,k);
        for i = 1:nAltern
            w = rankVec(i) - rankVec;
            A(:,i) = A(:,i) + isnan(w);
            W(i,k) = sum(w(~isnan(w)));
        end    
    end
    W = sum(W,2);
    A(1:(nAltern+1):nAltern^2) = 0;
    A(1:(nAltern+1):nAltern^2) = nAltern*nExpert - sum(A,2);
    resRankVec(mask) = A\W;
    minRank = min(resRankVec);
    resRankVec = (resRankVec - minRank)/(max(resRankVec)-minRank);
    %resRankVec = (resRankVec - minRank);
end

