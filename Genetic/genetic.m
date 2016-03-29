function [ medRankMat ] = genetic(lossMat,nPopulation,nCrossover,...
    nMutation,alphaMut)
%GENETIC Summary of this function goes here
%   Detailed explanation goes here
    %
    fileID = fopen('stats.txt','w+');
    if fileID == -1
        error('cannot open file')
    end
    %
    nAltern = size(lossMat,1);
    nPerMut = round(alphaMut*nAltern);
    %isTerminate = false;
    isRestart = false;
    cntRestart = 0;
    cntDevers = 0;
    cntIter = 1;
    lastAugMed = 1;
    lastAugPop = 1;
    lastDevers = 1;
    lastRestart = 1;
    %
    nBest = 0;
    medRankMat = zeros(nAltern,nBest);
    medPnlt = 0;
    %
%     meanRankVec = zeros(nAltern,1); % может стоит сделать пробный прогон вне цикла
    %
    [popRankMat, popPnltVec] = popGeneration(lossMat,nPopulation);
    popDistMat = linOrderPrwDist(popRankMat);
    while ~isRestart
        tic
        [offspRankMat, offspPnltVec] = ...
            getNextGen(lossMat,popRankMat,nCrossover,nMutation,nPerMut);
        toc
        [popRankMat, popPnltVec, popDistMat, nNewPop] = ...
            popSelection(popRankMat,popPnltVec,popDistMat,offspRankMat,offspPnltVec);
        toc
        [medRankMat, medPnlt, nNewMed] = ...
            addMedian(medRankMat,medPnlt,offspRankMat,offspPnltVec);
        toc
        %
        [meanRankVec,devVec] = popMean( medRankMat );
        toc
        %
        if nNewPop > 5;
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
        if cntIter > 1000
            fprintf('====== restart ======\n');
            isRestart = true;
            cntRestart = cntRestart + 1;
            lastRestart = cntIter;
            [popRankMat, popPnltVec] = popGeneration(lossMat,nPopulation);
        else
        if lastAugPop < cntIter - 10
            fprintf('====== diversification ======\n');
            cntDevers = cntDevers + 1;
            lastDevers = cntIter;
            [popRankMat, popPnltVec] = popGeneration(lossMat,nPopulation);
            indRandMed = randi(size(medRankMat,2));
            popRankMat(:,1) = medRankMat(:,indRandMed);
            popPnltVec(1) = medPnlt;
        end
        end 
        % stats
        fprintf('---> step %i:\n----- min: %i \n',cntIter,medPnlt)
        fprintf('----- nNewPop = %i, nNewMed = %i \n',nNewPop, nNewMed)
        fprintf('------- best_Pop:')
        fprintf('   %i',popPnltVec(1:5))
%         fprintf('\n------- worst_Pop:')
%         fprintf('   %i',popPnltVec(end-4:end))
        fprintf('\n------- med :   %i\n', round(median(popPnltVec)))
        %
        fprintf(fileID,'% 5.1i',cntIter);
        fprintf(fileID,'% 10.1i% 6.1i',medPnlt,size(medRankMat,2));
        fprintf(fileID,'% 10.1i% 10.1i% 10.1i',popPnltVec(1),...
            round(mean(popPnltVec)),popPnltVec(end));
        fprintf(fileID,'% 3.1i% 3.1i',nNewPop,nNewMed);
        fprintf(fileID,'% 4.1i% 4.1i% 4.1i% 4.1i',lastRestart,lastDevers,...
            cntRestart,cntDevers);
        fprintf(fileID,'\n');
        %
        cntIter = cntIter + 1;
    end
    %try
    %catch
    fclose(fileID);
end

