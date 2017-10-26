function dispStats(popPnltVec,medPnltVec,nNewPop,nNewMed,cntIter,time)
%DISPSTATS Summary of this function goes here
%   Detailed explanation goes here
    sortPopPnltVec = sort(popPnltVec);
    sortMedPnlt = sort(medPnltVec);
    fprintf('8===========================> ')
    fprintf('step %5.1i: time %4.3f ',cntIter,time)
    fprintf('<==========================8\n')
    fprintf('-- min: %20.8f ; ------   med: %20.8f',sortMedPnlt(1),median(popPnltVec));
    fprintf('   ------   nPop %3.1i; nMed = %3.1i;',nNewPop, nNewMed)
    %
    tmpVec = sortPopPnltVec(1:6);
    [~,posVec] = ismember(tmpVec,sortMedPnlt);
    fprintf('\n--- best_Pop:   % 8i(% 2i)',fix(tmpVec(1)),posVec(1))
    fprintf('% +8i(% 2i)',[fix(tmpVec(2:end)) - fix(tmpVec(1)); posVec(2:end)])
    tmpVec = 1e2*(tmpVec - fix(tmpVec));
    fprintf('\n--- best_SQ :   % 12.6f',tmpVec(1) )
    fprintf('% +12.6f',tmpVec(2:end) - tmpVec(1))
    
    fprintf('\n')
%         fprintf('\n------- worst_Pop:')
%         fprintf('   %i',popPnltVec(end-4:end))
end

