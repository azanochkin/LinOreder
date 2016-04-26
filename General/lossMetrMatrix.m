function [lossMetrMat,normMetrConst] = lossMetrMatrix(rankMetrMat)
    nAltern = size(rankMetrMat,1);
    normRankMetrMat = rankMetrMat;
    %normRankMetrMat = rankMetrMat./repmat(normVec,nAltern,1);
    gambRankMetrVec = GambMean(normRankMetrMat);
    repGambRankMetrMat = repmat(gambRankMetrVec,1,nAltern);
    lossMetrMat = repGambRankMetrMat - repGambRankMetrMat';
    lossMetrMat((lossMetrMat==0)&(~eye(size(lossMetrMat)))) = -min(abs(lossMetrMat(lossMetrMat~=0)))/3;
    normMetrConst = abs(sum(lossMetrMat(lossMetrMat<0)));
end