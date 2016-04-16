function printFileStats(fileID,popPnltVec,medPnltVec,nNewPop,nNewMed,...
                        cntIter,lastRestart,lastDevers,cntRestart,cntDevers)
%PRINTFILESTATS Summary of this function goes here
%   Detailed explanation goes here
    sortPopPnltVec = sort(popPnltVec);
    minMedPnlt = min(medPnltVec);
    fprintf(fileID,'% 5.1i',cntIter);
    fprintf(fileID,'% 20.9f% 6.1i',minMedPnlt,length(medPnltVec));
    fprintf(fileID,'% 17.7f% 17.7f% 17.7f',sortPopPnltVec(1),...
        mean(popPnltVec),sortPopPnltVec(end));
    fprintf(fileID,'% 3.1i% 3.1i',nNewPop,nNewMed);
    fprintf(fileID,'% 4.1i% 4.1i% 4.1i% 4.1i',lastRestart,lastDevers,...
        cntRestart,cntDevers);
    fprintf(fileID,'\n');
end

