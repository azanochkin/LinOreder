function renumRankVec = renumber( rankVec )
%RENUMBER Summary of this function goes here
%   Detailed explanation goes here
    nAltern = length(rankVec);
    [sortRankVec,orderVec] = sort(rankVec(:));
    isEqVec = [false; (sortRankVec(1:end-1)==sortRankVec(2:end))];
    posVec = find(~isEqVec);
    renumRankVec = zeros(nAltern,1);
    renumRankVec(orderVec) = posVec(cumsum(~isEqVec));
end