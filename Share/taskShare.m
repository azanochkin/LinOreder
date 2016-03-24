function rankMat = taskShare(lossMat, OptimFnc )
    % ������� �������
    [indEqVec, isFrstUniqVec] = fndEqElLossMatrix(lossMat);
    grpLossMat = groupLossMatrix(lossMat, indEqVec);
    fprintf('Alternatives in lossMat: %i\n',sum(isFrstUniqVec));
    % ������������� ����������� ��������� ������
    buzdShare( grpLossMat );
    % Optimization
    rankMat(isFrstUniqVec,:) = OptimFnc(grpLossMat);
    rankMat = rankMat(indEqVec,:);
end

