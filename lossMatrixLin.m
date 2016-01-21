function [lossMatNE, lossMatE] = lossMatrixLin(rankVecMat)
    nAltern = size(rankVecMat,1);
    nExperts = size(rankVecMat,2);
    lossMatE = zeros(nAltern);
    lossMatNE = zeros(nAltern);
    for i = 1:nExperts
        tmp = repmat(rankVecMat(:,i),1,nAltern);
        tmpNE = tmp>tmp';
        lossMatNE = lossMatNE + 1 - (tmpNE' - tmpNE);
        tmpE = tmp==tmp';
        lossMatE = lossMatE + 1 - tmpE;
        tmpNan = isnan(tmp)|isnan(tmp');
        lossMatNE = lossMatNE - tmpNan;
        lossMatE = lossMatE - tmpNan;
    end
    lossMatNE(1:(nAltern+1):nAltern^2) = zeros(nAltern,1);
    lossMatE(1:(nAltern+1):nAltern^2) = zeros(nAltern,1);
end

