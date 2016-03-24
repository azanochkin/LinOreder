function relMatArr = sRelationMatrix( rankMat )
%SRELATIONMATRIX Summary of this function goes here
%   Detailed explanation goes here
    timeVec = ones(size(rankMat,1),1);
    prefRankMat = rankMat;
    subRankMat = nan(size(rankMat));
    relMatArr = relationMatrix(timeVec, prefRankMat, subRankMat);
end

