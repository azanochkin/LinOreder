function dispStats(popPnltVec,medPnltVec,nNewPop,nNewMed,cntIter,...
                    lastRestart,lastDevers,lastMetrEmpl,time)
%DISPSTATS Summary of this function goes here
%   Detailed explanation goes here
    sortPopPnltVec = sort(popPnltVec);
    minMedPnlt = min(medPnltVec);
    fprintf('8===========================> ')
    fprintf('step %5.1i: time %4.3f ',cntIter,time)
    fprintf('<==========================8\n')
    fprintf('-- min: %20.8f ; ---------   med: %20.5f \n',minMedPnlt,median(popPnltVec));
    %
    tmpVec = sortPopPnltVec(1:6);
    fprintf('--- best_Pop:   %i',fix(tmpVec(1)))
    fprintf('   %+i',fix(tmpVec(2:end)) - fix(tmpVec(1)))
    fprintf('   --------------   nPop %3.1i; nMed = %3.1i;',nNewPop, nNewMed)
    tmpVec = 1e2*(tmpVec - fix(tmpVec));
    fprintf('\n--- best_SQ:   %10.6f',tmpVec(1) )
    fprintf('   %+9.6f',tmpVec(2:end) - tmpVec(1))
    fprintf('\n')
%         fprintf('\n------- worst_Pop:')
%         fprintf('   %i',popPnltVec(end-4:end))
    %
    switch cntIter
        case lastRestart
            fprintf('\n{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{');
            fprintf(' restart ');
            fprintf('}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}\n\n');
        case lastDevers
            fprintf('\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
            fprintf(' diversification ');
            fprintf('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n');
        case lastMetrEmpl
            fprintf('\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
            fprintf('  update  ');
            fprintf('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n');
    end
end

