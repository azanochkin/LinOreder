function [ newRankVec, newRankPen ] = insertionMyFix(rankVec, rankPen, lossMat, isFix)
    % ���������
    eqPen = length(rankVec)/10;
    roundLossMat = round(lossMat);
    rankPen = getPenalty(rankVec,roundLossMat);
    [rankVec,rankPen] = insertionRegRnd(rankVec, rankPen, roundLossMat, eqPen, 0);
    % �������� ������
    [rankVec,rankPen] = insertion(rankVec, rankPen, roundLossMat, 0, 0);
    % �������� ��� ���������
    if isFix
        rankPen = getPenalty(rankVec,lossMat);
        [rankVec,rankPen] = insertion(rankVec, rankPen, lossMat, 0, 0);
    end
    % �����������
    [rghLossMat,rghRankVec] = groupLossMatrix( lossMat, rankVec);
    nRank = max(rghRankVec);
    %
    if isFix
        [ newRankVec, newRankPen ] = insertion(1:nRank, rankPen, rghLossMat, 0, 0);
    else
        roundLossMat = round(rghLossMat);
        [ newRankVec, newRankPen ] = insertion(1:nRank, rankPen, roundLossMat, 0, 0);
        newRankPen = getPenalty(newRankVec,rghLossMat);
    end
    newRankVec = newRankVec(rghRankVec);    
    %
    nAltern = length(newRankVec);
    posVec = zeros(nAltern+1,1);
    for i = newRankVec'
        posVec(i+1) = posVec(i+1)+1;
    end
    posVec = 1 + cumsum(posVec);
    newRankVec = posVec(newRankVec);
    %
    %checkPenalty( newRankPen, newRankVec, lossMat,'INSERTION_MY_FIX')
end