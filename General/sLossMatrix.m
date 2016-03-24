function lossMat = sLossMatrix( rankMat )
%SLOSSMATRIX Summary of this function goes here
%   Detailed explanation goes here
    timeVec = ones(size(rankMat,1),1);
    prefRankMat = rankMat;
    subRankMat = nan(size(rankMat));
    lossMat = lossMatrix(timeVec, prefRankMat, subRankMat);
end

