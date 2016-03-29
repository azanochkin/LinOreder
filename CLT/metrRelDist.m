function relDistMat = metrRelDist( frstRankMat, scndRankMat )
%METRRELDIST Summary of this function goes here
%   Detailed explanation goes here
    [nAltern,nFrstPop] = size(frstRankMat);
    nScndPop = size(scndRankMat,2);
    relDistMat = zeros(nFrstPop,nScndPop);
    for i = 1:nFrstPop
        frstRankVec = frstRankMat(:,i);
        frstRankVec = frstRankVec - sum(frstRankVec)/nAltern;
        for j = 1:nScndPop
            scndRankVec = scndRankMat(:,j);
            scndRankVec = scndRankVec - mean(scndRankVec);
            difRankVec = (frstRankVec - scndRankVec);
            relDistMat(i,j) = nAltern * sum(difRankVec.^2);
        end
    end
end

