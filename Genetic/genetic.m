function [ medRankMat, medPnltVec ] = genetic(lossMat,nPopulation,nCrossover,...
    nMutation,nIter,alphaMut,varargin)
%GENETIC Summary of this function goes here
%   Detailed explanation goes here
    isFilePrint = nargin>6;
    if isFilePrint
        fileID = varargin{1};
    end
    nAltern = size(lossMat,1);
    nPerMut = round(alphaMut*nAltern);
    %isTerminate = false;
    isRestart = false;
    isQuant = false;
    cntRestart = 0;
    cntDevers = 0;
    cntIter = 1;
    lastAugMed = 1;
    lastAugPop = 1;
    lastDevers = 1;
    lastRestart = 1;
    maxMedAmnt = 20;
    %
    nBest = 0;
    medRankMat = zeros(nAltern,nBest);
    medPnltVec = zeros(1,nBest);
    %
%     meanRankVec = zeros(nAltern,1); % может стоит сделать пробный прогон вне цикла
    %
    [popRankMat, popPnltVec] = popGeneration(lossMat,nPopulation);
    popDistMat = linOrderPrwDist(popRankMat);
    
    global isAborted
    
    while (~isRestart) && (~isAborted)
        pause(0.01);
        tic
        [offspRankMat, offspPnltVec] = ...
            getNextGen(lossMat,popRankMat,nCrossover,nMutation,nPerMut,isQuant);
        [popRankMat, popPnltVec, popDistMat, nNewPop] = ...
            popSelection(popRankMat,popPnltVec,popDistMat,offspRankMat,offspPnltVec);
        [medRankMat, medPnltVec, nNewMed] = ...
            addMedian(medRankMat,medPnltVec,offspRankMat,offspPnltVec,maxMedAmnt);
        %
        %[meanRankVec,devVec] = popMean( medRankMat );
        %
        if nNewPop >= nPopulation/10;
            lastAugPop = cntIter ;
        end
        if nNewMed > 1
            lastAugMed = cntIter;
        end
%         newMeanRankVec = meanRank(medRankMat);
%         distMeans(cntTotalIter) = dist(newMeanRankVec,meanRankVec);        
%         if (nCloseMeans > 100) && (nRestarts > 10)
%             isRestart = true;
%         else
        %if lastAugMed < cntIter - 40
        if cntIter > nIter
            fprintf('====== restart ======\n');
            isRestart = true;
            cntRestart = cntRestart + 1;
            lastRestart = cntIter;
            [popRankMat, popPnltVec] = popGeneration(lossMat,nPopulation);
        else
        if lastAugPop < cntIter - 10
            if isQuant
                isQuant = false;
                fprintf('\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                fprintf(' diversification ');
                fprintf('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n');
                cntDevers = cntDevers + 1;
                lastDevers = cntIter;
                [popRankMat, popPnltVec] = popGeneration(lossMat,nPopulation);
                %
                indRandMedVec = find(medPnltVec<=quantile(medPnltVec,0.01));
                indRandMed = indRandMedVec(randi(length(indRandMedVec)));
                %
                %indRandMed = randi(size(medRankMat,2));
                popRankMat(:,1) = medRankMat(:,indRandMed);
                popPnltVec(1) = medPnltVec(indRandMed);
            else
                fprintf('\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
                fprintf('  update  ');
                fprintf('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n');
                isQuant = true;
                lastAugPop = cntIter;
            end
        end
        end 
        dispStats(popPnltVec,medPnltVec,nNewPop,nNewMed,cntIter,toc)
        %
        if isFilePrint
            printFileStats(fileID,popPnltVec,medPnltVec,nNewPop,nNewMed,...
                       cntIter,lastRestart,lastDevers,cntRestart,cntDevers)
        end
%         save('Results\midRes.mat','medRankMat');
        %
        cntIter = cntIter + 1;
    end
end

