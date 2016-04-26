function scatterRanks( rankMat )
%PLOTRANKS Summary of this function goes here
%   Detailed explanation goes here
    [unRankMat,~,indVec] = unique(rankMat,'rows');
    s = 2+(accumarray(indVec,ones(1,length(indVec))));
    c = linspace(1,10,length(s));
    scatter(unRankMat(:,1),unRankMat(:,2),s,c,'fill')
end

