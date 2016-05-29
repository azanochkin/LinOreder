function [ medRankMat, medPnltVec ] = genetic(lossMat,nPopulation,nCrossover,...
    nMutation,nMaxIter,alphaMut,fileID)
%GENETIC Summary of this function goes here
%   Detailed explanation goes here
    %
    maxMedAmnt = 20;
    augPopCoef = 0.1;
    %
    isFilePrint = nargin>6;
    if isFilePrint
        printFileStats(fileID);
    end
    nAltern = size(lossMat,1);
    nPerMut = round(alphaMut*nAltern);
    isTerminate = false;
    isMetrEmpl = false;
    cntRestart = 0;
    cntDevers = 0;
    cntIter = 0;
    lastAugMed = 0;
    lastAugPop = 0;
    lastDevers = 0;
    lastRestart = 0;
    lastMetrEmpl = 0;
    %
    nBest = 0;
    medRankMat = zeros(nAltern,nBest);
    medPnltVec = zeros(1,nBest);
    %
    [popRankMat, popPnltVec] = popGeneration(lossMat,nPopulation);
    popDistMat = linOrderPrwDist(popRankMat);
    while ~isTerminate
        tic
        cntIter = cntIter + 1;
        [offspRankMat, offspPnltVec] = ...
            getNextGen(lossMat,popRankMat,nCrossover,nMutation,nPerMut,isMetrEmpl);
        [popRankMat, popPnltVec, popDistMat, nNewPop] = ...
            popSelection(popRankMat,popPnltVec,popDistMat,offspRankMat,offspPnltVec);
        [medRankMat, medPnltVec, nNewMed] = ...
            addMedian(medRankMat,medPnltVec,offspRankMat,offspPnltVec,maxMedAmnt);
        %
        if nNewPop >= augPopCoef*nPopulation
            lastAugPop = cntIter ;
        end
        if nNewMed > 0
            lastAugMed = cntIter;
        end
        isTerminate = cntIter >= nMaxIter;
        if lastAugMed < cntIter - 30
            cntRestart = cntRestart + 1;
            lastRestart = cntIter;
            lastAugMed = cntIter;
            [popRankMat, popPnltVec] = popGeneration(lossMat,nPopulation);
        else
        if lastAugPop < cntIter - 10
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
            else
                isMetrEmpl = true;
                lastAugPop = cntIter;
                lastMetrEmpl = cntIter;
            end
        end
        end 
        dispStats(popPnltVec,medPnltVec,nNewPop,nNewMed,cntIter,...
                    lastRestart,lastDevers,lastMetrEmpl,toc)
        %
        if isFilePrint
            printFileStats(fileID,popPnltVec,medPnltVec,nNewPop,nNewMed,...
                       cntIter,lastRestart,lastDevers,cntRestart,cntDevers)
        end
%         save('./Results/midRes.mat','medRankMat');
    end
end

