function [rankMat,penVec] = taskShare(lossMat, OptimFnc )
    % удалить повторы
    [indEqVec, isFrstUniqVec] = fndEqElLossMatrix(round(lossMat)); % пересмотреть!!!!!!!!!
    grpLossMat = groupLossMatrix(lossMat, indEqVec);
    fprintf('Unique alternatives in lossMat: %i\n',sum(isFrstUniqVec));
    % Рассматриваем возможность разделить задачу
    %buzdShare( round(grpLossMat) );
    % Optimization
    [rankMat(isFrstUniqVec,:),penVec] = OptimFnc(grpLossMat);
    rankMat = rankMat(indEqVec,:);
    % sort 
    [penVec,indSortPen] = sort(penVec);
    rankMat = rankMat(:,indSortPen);
end

