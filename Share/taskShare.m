function [rankMat,penVec] = taskShare(lossMat, OptimFnc )
    % ������� �������
    [indEqVec, isFrstUniqVec] = fndEqElLossMatrix(round(lossMat));
    grpLossMat = groupLossMatrix(lossMat, indEqVec);
    fprintf('Alternatives in lossMat: %i\n',sum(isFrstUniqVec));
    % ������������� ����������� ��������� ������
    buzdShare( round(grpLossMat) );
    % Optimization
    [rankMat(isFrstUniqVec,:),penVec] = OptimFnc(grpLossMat);
    rankMat = rankMat(indEqVec,:);
end

