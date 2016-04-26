function renumRankVec = srenumber( rankVec )
%RENUMBER Summary of this function goes here
%   Detailed explanation goes here
    renumRankVec = rankVec;
    isNanVec = isnan(rankVec);
    [~,~,indRankVec] = unique(rankVec(~isNanVec));
    numVec = 1:max(indRankVec);
    renumRankVec(~isNanVec) = numVec(indRankVec);
end