function lossMat = lossMatrixE(timeVec, prefRankMat, subRankMat, varargin)
    nAltern = size(prefRankMat,1);
    nExperts = size(prefRankMat,2);
    lossMat = zeros(nAltern);
    relMatArr = relationMatrix(timeVec, prefRankMat, subRankMat, varargin{:});
    for i = 1:nExperts
        maskLE = relMatArr(:,:,i);
        maskG = ~maskLE & maskLE';
        maskE = maskLE & maskLE';
        lossMat(maskLE) = lossMat(maskLE) - 1;
        lossMat(maskG) = lossMat(maskG) + 1;
        tmpMat = maskE*diag(-1./(max(2,sum(maskE))-1));
        lossMat(maskE) = tmpMat(maskE);
    end
    lossMat(1:(nAltern+1):nAltern^2) = zeros(nAltern,1);
end