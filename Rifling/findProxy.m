function indProxy = findProxy( relMatrixArr,agNames )
    [rMat,~,distMat,volMat] = relDist(relMatrixArr);
    volVec = sum(volMat,2)-diag(volMat);
    sumVec = sum(rMat,2)./ volVec ;
    [~,indProxy] = min(sumVec);
    fprintf('-- > best agency: %s \n',agNames{indProxy});
    resTbl = array2table([sumVec volVec],'VariableNames',{'Summ_dist', 'Volume'},'RowNames',agNames)
    distTbl = array2table(distMat,'VariableNames',agNames,'RowNames',agNames)
    volTbl = array2table(volMat,'VariableNames',agNames,'RowNames',agNames)
end

