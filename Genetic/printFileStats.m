function printFileStats(fileID,popPnltVec,medPnltVec,nNewPop,nNewMed,...
                        cntIter,lastRestart,lastDevers,cntRestart,cntDevers)
%PRINTFILESTATS Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 2
        fprintf(fileID,'% 6s','Iter');
        fprintf(fileID,'% 20s% 6s','minMedPnlt','sizeM');
        fprintf(fileID,'% 20s% 20s% 20s','best(PopPnlt)',...
            'mean(PopPnlt)','worst(PopPnlt)');
        fprintf(fileID,'% 6s% 6s','nwPop','nwMed');
        fprintf(fileID,'% 6s% 6s% 6s% 6s','iRstr','iDvrs','nRstr','nDvrs');
    else
        sortPopPnltVec = sort(popPnltVec);
        minMedPnlt = min(medPnltVec);
        fprintf(fileID,'% 6.1i',cntIter);
        fprintf(fileID,'% 20.8f% 6.1i',minMedPnlt,length(medPnltVec));
        fprintf(fileID,'% 20.8f% 20.8f% 20.8f',sortPopPnltVec(1),...
            mean(popPnltVec),sortPopPnltVec(end));
        fprintf(fileID,'% 6.1i% 6.1i',nNewPop,nNewMed);
        fprintf(fileID,'% 6.1i% 6.1i% 6.1i% 6.1i',lastRestart,lastDevers,...
            cntRestart,cntDevers);
    end
    fprintf(fileID,'\n');
end

