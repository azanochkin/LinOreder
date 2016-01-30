function pen = getPenalty(rankVec,lossMat)
    nAltern = size(lossMat,1);
    tmp = repmat(rankVec(:),1,nAltern);
    isGeq = tmp<=tmp';
    pen = sum(lossMat(isGeq));
end
