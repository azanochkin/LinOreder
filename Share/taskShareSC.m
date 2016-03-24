function rankMat = taskShareSC(timeVec, nscRankMat, iscRankMat, isEqConsid, OptimFnc )
    % ����������� ������
    rng(3);
    % loss matrix
    fullLossMat = lossMatrix(timeVec,nscRankMat,iscRankMat,isEqConsid);
    % ������ ��������� ����������
    maskMinRatesVec = sum(~(isnan(nscRankMat)&isnan(iscRankMat)),2)>=2;
    lossMat = fullLossMat(maskMinRatesVec,maskMinRatesVec);
    % ���������� �������
    tmpRankMat = taskShare(lossMat, OptimFnc );
    % ����������� ��������� ����������
    rankMat = zeros(size(nscRankMat,1),size(tmpRankMat,2));
    for i = 1:size(tmpRankMat,2)
        ind = [find(maskMinRatesVec);find(~maskMinRatesVec)];
        [rankMat(ind,i), ~] = bestInsertion(fullLossMat(ind,ind),true,tmpRankMat(:,i));
    end
end

