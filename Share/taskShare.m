function [rankMat,penVec] = taskShare(lossMat, OptimFnc )
    % удалить повторы
    [indEqVec, isFrstUniqVec] = fndEqElLossMatrix(lossMat);
    grpLossMat = groupLossMatrix(lossMat, indEqVec);
    fprintf('Alternatives in lossMat: %i\n',sum(isFrstUniqVec));
    % Рассматриваем возможность разделить задачу
    buzdShare( grpLossMat );
    % Optimization
    [rankMat(isFrstUniqVec,:),penVec] = OptimFnc(grpLossMat);
    rankMat = rankMat(indEqVec,:);
end

