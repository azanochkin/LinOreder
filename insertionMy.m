function [ newRankVec, kemenyDist ] = insertionMy(rankVec, lossMat)
    [ newRankVec, kemenyDist ] = insertion(rankVec, lossMat, false);
    [~,~,newRankVec] = unique(newRankVec);
    nAltern = length(rankVec);
    nRank = max(newRankVec);
    rghLossMat = zeros(nRank);
    for i=1:nAltern
        for j=1:nAltern
            rvi = newRankVec(i);
            rvj = newRankVec(j);
            rghLossMat(rvi,rvj) = rghLossMat(rvi,rvj) + lossMat(i,j);
        end
    end
    [ rghRankVec, kemenyDist ] = insertion(1:nRank, rghLossMat, true);
    newRankVec = rghRankVec(newRankVec);
    %
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

