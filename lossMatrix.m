function lossMat = lossMatrix(timeVec, nscRankMat, iscRankMat)
    nAltern = size(nscRankMat,1);
    nExperts = size(nscRankMat,2);
    lossMat = zeros(nAltern);
    for i = 1:nExperts
        repNscRankMat = repmat(nscRankMat(:,i),1,nAltern);
        repIscRankMat = repmat(iscRankMat(:,i),1,nAltern);
        repTimeMat = repmat(timeVec(:),1,nAltern);
        maskTime = repTimeMat == repTimeMat';
        maskNscLE = repNscRankMat <= repNscRankMat';
        maskNscG = repNscRankMat > repNscRankMat';
        maskIscLE = repIscRankMat <= repIscRankMat';
        maskIscG = repIscRankMat > repIscRankMat';
        %
%         maskG = maskNscG | maskIscG;
%         maskLE = (maskNscLE | maskIscLE) & ~maskG;
        maskG = (maskNscG & maskTime)| maskIscG;
        maskLE = ((maskNscLE & maskTime) | maskIscLE) & ~maskG;
        lossMat(maskLE) = lossMat(maskLE) - 1;
        lossMat(maskG) = lossMat(maskG) + 1;
    end
    lossMat(1:(nAltern+1):nAltern^2) = zeros(nAltern,1);
end