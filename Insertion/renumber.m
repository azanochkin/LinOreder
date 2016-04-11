function renumRankVec = renumber( rankVec )
%RENUMBER Summary of this function goes here
%   Detailed explanation goes here
    nAltern = length(rankVec);
    posVec = zeros(nAltern+1,1);
    for i = rankVec'
        posVec(i+1) = posVec(i+1)+1;
    end
    posVec = 1 + cumsum(posVec);
    renumRankVec = posVec(rankVec);
end

