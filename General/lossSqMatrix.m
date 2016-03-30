function lossMat = lossSqMatrix(timeVec, prefRankMat, subRankMat, varargin)
    nAltern = size(prefRankMat,1);
    nExperts = size(prefRankMat,2);
    lossMat = zeros(nAltern);
    relMatArr = relationMatrix(timeVec, prefRankMat, subRankMat, varargin{:});
    for i = 1:nExperts
        maskLE = relMatArr(:,:,i);
        maskL = maskLE & ~maskLE';
        lossMat(maskL) = lossMat(maskL) - 1;
    end
    lossMat(1:(nAltern+1):nAltern^2) = zeros(nAltern,1);
end