function penVec = getPenalty(rankMat,lossMat)
    nAltern = size(lossMat,1);
    if nAltern~=size(rankMat,1)
        if nAltern~=size(rankMat,2)
            error('    Not concerted lossMat and rankMat');
        else
            rankMat = rankMat';
        end
    end
    nRanges = size(rankMat,2);
    penVec = zeros(1,nRanges);
    for i = 1:nRanges
        rankVec = rankMat(:,i);
        tmpMat = repmat(rankVec,1,nAltern);
        isGeq = tmpMat<=tmpMat';
        penVec(i) = sum(lossMat(isGeq));
    end
end
