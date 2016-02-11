function [rankVec,kemenyDist] = multistart( optimFnc, lossMat, varargin )
    if nargin == 3
        maxIter = varargin{1};
    else
        maxIter = 20;
    end
    nAltern = size(lossMat,1);
    perm = 1:nAltern;
    kemenyDist = zeros(maxIter,1);
    rankVec = zeros(nAltern,maxIter);
    for j = 1 : maxIter
        [rankVecTmp,kemenyDistTmp] = optimFnc(lossMat(perm,perm));
        rankVec(perm,j) = rankVecTmp;
        kemenyDist(j) = kemenyDistTmp;
%         if kemenyDistTmp<kemenyDist
%             rankVec(perm) = rankVecTmp;
%             kemenyDist = kemenyDistTmp;
%         end
        perm = randperm(nAltern);
    end
    [~,ind] = min(kemenyDist);
    realPenalty = getPenalty(rankVec(:,ind),lossMat);
    plot(sort(kemenyDist,'descend'),'-.^g');
    fprintf('MULTISTART> real: %i , comp: %i \n',realPenalty, kemenyDist(ind));
end

