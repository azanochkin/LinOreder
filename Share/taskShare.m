function [rankMat,penVec] = taskShare(lossMat, OptimFnc )
    % ������� �������
    [indEqVec, isFrstUniqVec] = fndEqElLossMatrix(lossMat);
    grpLossMat = groupLossMatrix(lossMat, indEqVec);
    fprintf('Alternatives in lossMat: %i\n',sum(isFrstUniqVec));
    % ������������� ����������� ��������� ������
    buzdShare( grpLossMat );
    % Optimization
    [rankMat(isFrstUniqVec,:),penVec] = OptimFnc(grpLossMat);
    rankMat = rankMat(indEqVec,:);
end

