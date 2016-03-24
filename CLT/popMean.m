function [meanRankVec,devVec] = popMean( rankMat )
%POPMEAN Summary of this function goes here
%   Detailed explanation goes here
    [nAltern,nPopulation] = size(rankMat);
    for i = 1:nPopulation
        cntrVec = zeros(nAltern,1);
        rankVec = rankMat(:,i);
        for j = 1:nAltern
            cntrVec(rankVec(j)) = cntrVec(rankVec(j)) + 1;
        end
        for j = 1:nAltern
            rankVec(j) = rankVec(j) + 0.5*(cntrVec(rankVec(j))-1);
        end
        rankMat(:,i) = rankVec;
        if sum(rankVec)~=nAltern*(nAltern+1)/2
            error('error in rankMat')
        end
    end
    meanRankVec = sum(rankMat,2)/nPopulation;
    devVec = metrRelDist( meanRankVec, rankMat );
    %%
    figure(2)
    cla
    hist(sqrt(devVec),min(max(nPopulation/4,10),100));
end

