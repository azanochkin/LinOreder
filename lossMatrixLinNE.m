function lossMat = lossMatrixLinNE(rankVecMat)
    nAltern = size(rankVecMat,1);
    nExperts = size(rankVecMat,2);
    lossMatE = zeros(nAltern);
    lossMatNE = zeros(nAltern);
    for i = 1:nExperts
        tmp = repmat(rankVecMat(:,i),1,nAltern);
        tmpNE = tmp>tmp';
        tmpE = tmp==tmp';
        lossMatNE = lossMatNE + 1 - (tmpNE' - tmpNE) - tmpE;
        lossMatE = lossMatE + 1;
    end
    lossMatNE(1:(nAltern+1):nAltern^2) = zeros(nAltern,1);
    lossMatE(1:(nAltern+1):nAltern^2) = zeros(nAltern,1);
    lossMat = lossMatNE - (lossMatNE + lossMatNE' - lossMatE);
end

