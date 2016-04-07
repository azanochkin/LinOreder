function [ rankVec, rankPen ] = insertionMy1(rankVec, rankPen, lossMat ,isQuant)
    function [rankVec, rankPen] = recurs(rankVec, rankPen, ...
            lossMat, eqPen ,quant, depth)
        [lossMat,rankVec] = groupLossMatrix( lossMat, rankVec);
        nRank = max(rankVec);
        [rghRankVec,rankPen] = insertionRegRnd(1:nRank, rankPen, lossMat, eqPen ,quant);
        %fprintf('%i(%i),  ',rankPen,nRank);
        if depth > 0
            [rghRankVec,rankPen] = recurs(rghRankVec, rankPen, lossMat, eqPen ,quant, depth-1);
        end
        rankVec = rghRankVec(rankVec);
    end
    if isQuant
        quant = 0;
    else
        quant = 1;
    end
    eqPenVec = [round(linspace(length(rankVec)/4,0,5)),0];
    for eqPen=eqPenVec
        [rankVec,rankPen] = insertionRegRnd(rankVec, rankPen, lossMat, eqPen,quant);
        %fprintf('%i(%i),  ',rankPen,length(rankVec));
    end
    [rankVec,rankPen] = recurs(rankVec, rankPen, lossMat, 0 ,quant, 2);
    %fprintf('\n');
    %
    nAltern = length(rankVec);
    posVec = zeros(nAltern+1,1);
    for i = rankVec'
        posVec(i+1) = posVec(i+1)+1;
    end
    posVec = 1 + cumsum(posVec);
    rankVec = posVec(rankVec);
    %
    %checkPenalty( rankPen, rankVec, lossMat,'INSERTION_MY_FIX')
end