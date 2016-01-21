function [rankVec,kemenyDist] = multistart( optimFnc, lossMatNE, lossMatE , varargin )
    if nargin == 4
        maxIter = varargin{1};
    else
        maxIter = 20;
    end
    nAltern = size(lossMatNE,1);
    perm = 1:nAltern;
    kemenyDist = zeros(maxIter,1);
    rankVec = zeros(nAltern,maxIter);
    for j = 1 : maxIter
        [rankVecTmp,kemenyDistTmp] = optimFnc(lossMatNE(perm,perm),lossMatE(perm,perm));
        rankVec(:,j) = rankVecTmp;
        kemenyDist(j) = kemenyDistTmp;
%         if kemenyDistTmp<kemenyDist
%             rankVec(perm) = rankVecTmp;
%             kemenyDist = kemenyDistTmp;
%         end
        perm = randperm(size(lossMatNE,1));
    end
    [~,ind] = min(kemenyDist);
    realPenalty = getPenalty(rankVec(:,ind),lossMatNE, lossMatE);
    fprintf('MULTISTART> real: %i , comp: %i \n',realPenalty, kemenyDist(ind));
end

