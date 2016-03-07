function [lossMat,rankVec] = groupLossMatrix( initLossMat, initRankVec)
    [~,~,rankVec] = unique(initRankVec);
    nAltern = size(initLossMat,1);
    nRank = max(rankVec);
    lossMat = zeros(nRank);
    for i=1:nAltern
        for j=1:nAltern
            rvi = rankVec(i);
            rvj = rankVec(j);
            lossMat(rvi,rvj) = lossMat(rvi,rvj) + initLossMat(i,j);
        end
    end
end

