function [ newRankVec, newRankPen ] = insertionMyFix(rankVec, rankPen, lossMat, isFix)
    % Дробление
    %eqPen = length(rankVec)/10
    roundLossMat = round(lossMat);
    [rankVec,~] = insertionRegRnd(rankVec, 0, roundLossMat, 3, 0);
    [rankVec,~] = insertionRegRnd(rankVec, 0, roundLossMat, -1, 0);
    [rankVec,~] = insertionRegRnd(rankVec, 0, roundLossMat, 0, 0);
    % Чистовой проход
    [rankVec,~] = insertion(rankVec, 0, roundLossMat, 0, 0);
    % Чистовой при уточнении
    if isFix
        [rankVec,~] = insertion(rankVec, 0, lossMat, 0, 0);
    else
        [rankVec,~] = insertion(rankVec, 0, roundLossMat, 0, 0);
    end
    % Группировка
    [rghLossMat,rghRankVec] = groupLossMatrix( lossMat, rankVec);
    nRank = max(rghRankVec);
    %
    if isFix
        [ newRankVec, ~ ] = insertion(1:nRank, 0, rghLossMat, 0, 0);
    else
        [ newRankVec, ~ ] = insertion(1:nRank, 0, round(rghLossMat), 0, 0);
    end
    newRankPen = getPenalty(newRankVec,rghLossMat);
    newRankVec = newRankVec(rghRankVec);    
    newRankVec = renumber(newRankVec);
    %
    %checkPenalty( newRankPen, newRankVec, lossMat,'INSERTION_MY_FIX')
end