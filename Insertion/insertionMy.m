function [ newRankVec, kemenyDist ] = insertionMy(rankVec, kemDist, lossMat)
    [newRankVec,newKemDist] = insertion(rankVec, kemDist, lossMat, false);
    [rghLossMat,newRankVec] = groupLossMatrix( lossMat, newRankVec);
    nRank = max(newRankVec);
    [ rghRankVec, kemenyDist ] = insertion(1:nRank, newKemDist, rghLossMat, true);
    newRankVec = rghRankVec(newRankVec);    
    %
    nAltern = length(newRankVec);
    posVec = zeros(nAltern+1,1);
    for i = newRankVec'
        posVec(i+1) = posVec(i+1)+1;
    end
    posVec = 1 + cumsum(posVec);
    newRankVec = posVec(newRankVec);
    %
    checkPenalty( kemenyDist, newRankVec, lossMat,'INSERTION_MY')
end