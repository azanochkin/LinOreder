function [lossMat,rankVec] = groupLossMatrix( initLossMat, initRankVec)
    [~,~,rankVec] = unique(initRankVec);
    nAltern = size(initLossMat,1);
    nRank = max(rankVec);
    tmpLossMat = zeros(nRank,nAltern);
    for i=1:nRank
        tmpLossMat(i,:) = sum(initLossMat(rankVec==i,:),1);
    end
    lossMat = zeros(nRank);
    for i=1:nRank
        lossMat(:,i) = sum(tmpLossMat(:,rankVec==i),2);
    end
end

