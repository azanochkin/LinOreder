function resRankVec = GambMean(rankVecMat)
    resRankVec = NaN(size(rankVecMat,1),1);
    mask = ~all(isnan(rankVecMat),2);
    rankVecMat = rankVecMat(mask,:);
%
nanRankVec = rankVecMat;
nanRankVec(isnan(nanRankVec)) = min(nanRankVec(:))-1;
[~,indVec,indUniqNanVec] = unique(nanRankVec,'rows');
rankVecMat = rankVecMat(indVec,:);
wtVec = accumarray(indUniqNanVec,ones(length(indUniqNanVec),1));
%
    nAltern = size(rankVecMat,1);
    nExpert = size(rankVecMat,2);
    W = zeros(nAltern,nExpert);
    A = zeros(nAltern,nAltern);
    for k = 1:nExpert
        rankVec = rankVecMat(:,k);
        for i = 1:nAltern
            w = rankVec(i) - rankVec;
            A(:,i) = A(:,i) + wtVec(i)*(wtVec.*isnan(w));
            W(i,k) = wtVec(i)*sum(wtVec(~isnan(w)).*w(~isnan(w)));
        end    
    end
    W = sum(W,2);
    A(1:(nAltern+1):nAltern^2) = 0;
    A(1:(nAltern+1):nAltern^2) = sum(wtVec)*nExpert*wtVec - sum(A,2);
    rankVecMat = A\W;
    minRank = min(rankVecMat);
    rankVecMat = (rankVecMat - minRank)/(max(rankVecMat)-minRank);
    %resRankVec = (resRankVec - minRank);
%
resRankVec(mask) = rankVecMat(indUniqNanVec);
end

