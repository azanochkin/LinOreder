function pen = getPenalty(rankVec,lossNEMat, lossEMat)
    nAltern = size(lossNEMat,1);
    tmp = repmat(rankVec,1,nAltern);
    tmpNE = tmp<tmp';
    pen = sum(lossNEMat(tmpNE));
    tmpE = tmp == tmp';
    pen = pen + sum(lossEMat(tmpE))/2;
end
