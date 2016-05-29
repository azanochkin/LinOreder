function renumRankVec = renumber( rankVec )
%RENUMBER Summary of this function goes here
%   Detailed explanation goes here
    renumRankVec = rankVec;
    indnNanVec = find(~isnan(rankVec));
    rankVec = rankVec(indnNanVec);
    [sortRankVec,orderVec] = sort(rankVec(:));
    isEqVec = [false; (sortRankVec(1:end-1)==sortRankVec(2:end))];
    posVec = find(~isEqVec);
    orderVec = indnNanVec(orderVec);
    renumRankVec(orderVec) = posVec(cumsum(~isEqVec));
end