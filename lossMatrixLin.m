function lossMat = lossMatrixLin(rankVecMat)
    nAltern = size(rankVecMat,1);
    nExperts = size(rankVecMat,2);
    lossMat = zeros(nAltern);
    for i = 1:nExperts
        repRankMat = repmat(rankVecMat(:,i),1,nAltern);
        maskLE = repRankMat <= repRankMat';
        lossMat(maskLE) = lossMat(maskLE) - 1;
        maskG = repRankMat > repRankMat';
        lossMat(maskG) = lossMat(maskG) + 1;
    end
    lossMat(1:(nAltern+1):nAltern^2) = zeros(nAltern,1);
end

