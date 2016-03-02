function lossMat = lossMatrix(timeVec, prefRankMat, subRankMat)
    nAltern = size(prefRankMat,1);
    nExperts = size(prefRankMat,2);
    lossMat = zeros(nAltern);
    relMatArr = relationMatrix(timeVec, prefRankMat, subRankMat);
    for i = 1:nExperts
        maskLE = relMatArr(:,:,i);
        maskG = ~maskLE & maskLE';
        lossMat(maskLE) = lossMat(maskLE) - 1;
        lossMat(maskG) = lossMat(maskG) + 1;
    end
    lossMat(1:(nAltern+1):nAltern^2) = zeros(nAltern,1);
end