function scatterRanks( rankMat )
%PLOTRANKS Summary of this function goes here
%   Detailed explanation goes here
    [unRankMat,~,indVec] = unique(rankMat,'rows');
    s = 2+(accumarray(indVec,ones(1,length(indVec))));
    c = linspace(1,10,length(s));
    [~,ordVec] = sort(-s);
    scatter(unRankMat(ordVec,1),unRankMat(ordVec,2),s(ordVec),c(ordVec),'fill')
end

