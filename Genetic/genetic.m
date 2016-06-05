function [ medRankMat, medPnltVec ] = genetic(lossMat,nPopulation,nCrossover,...
    nMutation,nMaxIter,alphaMut,fileID)
%GENETIC Summary of this function goes here
%   Detailed explanation goes here
    %
    minIter2Resart = 30;
    minIter2Devers = 10;
    maxMedAmnt = 20;
    minMed2Stop = round(0.1*maxMedAmnt);
    augPopCoef = 0.1;
    %
    isFilePrint = nargin>6;
    nAltern = size(lossMat,1);
    nPerMut = round(alphaMut*nAltern);
    isTerminate = false;
    isPropStop = false;
    cntRestart = 0;
    cntIter = 0;
    unMedRankMat = [];
    unMedPnltVec = [];
    %
    while ~(isTerminate||isPropStop)
        disp('In th eforst while loop');
        [popRankMat, popPnltVec] = popGeneration(lossMat,nPopulation);
        popDistMat = linOrderPrwDist(popRankMat);
        medRankMat = [];
        medPnltVec = [];
        %
        cntDevers = 0;
        isRestart = false;
        isMetrEmpl = false;
        lastRestart = cntIter;
        lastAugMed = cntIter;
        lastAugPop = cntIter;
        lastDevers = cntIter;
        lastMetrEmpl = cntIter;
        while ~(isRestart||isTerminate)
            tic
            cntIter = cntIter + 1;
            [offspRankMat, offspPnltVec] = ...
                getNextGen(lossMat,popRankMat,nCrossover,nMutation,nPerMut,isMetrEmpl);
            [popRankMat, popPnltVec, popDistMat, nNewPop] = ...
                popSelection(popRankMat,popPnltVec,popDistMat,offspRankMat,offspPnltVec);
            [medRankMat, medPnltVec, nNewMed] = ...
                addMedian(medRankMat,medPnltVec,offspRankMat,offspPnltVec,maxMedAmnt);
            %
            if nNewPop >= augPopCoef*nPopulation;
                lastAugPop = cntIter ;
            end
            if nNewMed > 0
                lastAugMed = cntIter;
            end
            isTerminate = (cntIter >= nMaxIter);
            isRestart = (lastAugMed < cntIter - minIter2Resart)&&(cntDevers > 1);
            if isRestart
                lastRestart = cntIter;
            else
            if lastAugPop < cntIter - minIter2Devers
                if isMetrEmpl
                    isMetrEmpl = false;
                    cntDevers = cntDevers + 1;
                    lastDevers = cntIter;
                    lastAugPop = cntIter;
                    [popRankMat, popPnltVec] = popGeneration(lossMat,nPopulation);
                    %
                    indRandMedVec = find(medPnltVec<=quantile(medPnltVec,0.01));
                    indRandMed = indRandMedVec(randi(length(indRandMedVec)));
                    %indRandMed = randi(size(medRankMat,2));
                    popRankMat(:,1) = medRankMat(:,indRandMed);
                    popPnltVec(1) = medPnltVec(indRandMed);
                    popDistMat = linOrderPrwDist(popRankMat);
                else
                    isMetrEmpl = true;
                    lastAugPop = cntIter;
                    lastMetrEmpl = cntIter;
                end
            end
            end
            dispStats(popPnltVec,medPnltVec,nNewPop,nNewMed,cntIter,...
                        lastRestart,lastDevers,lastMetrEmpl,toc)
            if isFilePrint
                printFileStats(fileID,popPnltVec,medPnltVec,nNewPop,nNewMed,...
                           cntIter,lastRestart,lastDevers,cntRestart,cntDevers)
            end
            %save('Results\midRes.mat','medRankMat');
        end
        if isempty(unMedPnltVec)
            isNewMin = true;
        else
            isNewMin = min(unMedPnltVec) > min(medPnltVec);
        end
        [unMedRankMat, unMedPnltVec, nUnNewMed] = ...
            addMedian(unMedRankMat,unMedPnltVec,medRankMat,medPnltVec,maxMedAmnt);
        isPropStop = ~isNewMin && (nUnNewMed < minMed2Stop);
        cntRestart = cntRestart + 1;
    end
end

