function [ newRankVec, kemenyDist ] = insertionMy(rankVec, kemDist, lossMat)
    [newRankVec,newKemDist] = insertion(rankVec, kemDist, lossMat, false);
    [rghLossMat,newRankVec] = groupLossMatrix( lossMat, newRankVec);
    nRank = max(newRankVec);
    [ rghRankVec, kemenyDist ] = insertion(1:nRank, newKemDist, rghLossMat, true);
    newRankVec = rghRankVec(newRankVec);
    %
    nAltern = length(newRankVec);
    posVec = zeros(1,nAltern+1);
    for i = newRankVec'
        posVec(i+1) = posVec(i+1)+1;
    end
    posVec = 1 + cumsum(posVec);
    newRankVec = posVec(newRankVec);
    %
%     realPenalty = getPenalty(newRankVec,lossMat);
%     fprintf('INSERTION_MY> real: %i , comp: %i\n',realPenalty, kemenyDist);
end