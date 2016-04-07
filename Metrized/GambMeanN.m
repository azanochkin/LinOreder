function resRankVec = GambMeanN(relMatrixArr)
    %resRankVec = NaN(size(relMatrixArr,1),1);
    nAltern = size(relMatrixArr,1);
    nExpert = size(relMatrixArr,3);
    W = zeros(nAltern,nExpert);
    A = zeros(nAltern,nAltern);
    for k = 1:nExpert
        relMat = relMatrixArr(:,:,k);
        W(:,k) = sum(-relMat+relMat',2);
        A = A + ~(relMat | relMat');   
    end
    W = sum(W,2);
    A(1:(nAltern+1):nAltern^2) = 0;
    A(1:(nAltern+1):nAltern^2) = nAltern*nExpert - sum(A,2);
    resRankVec = A\W;
    minRank = min(resRankVec);
    %resRankVec = (resRankVec - minRank)/(max(resRankVec)-minRank);
    resRankVec = (resRankVec - minRank);
end

