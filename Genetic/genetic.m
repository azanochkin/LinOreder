function [ medRankMat, medPnltVec ] = genetic(lossMat,nPopulation,nCrossover,...
    nMutation,alphaMut,fileID)
%GENETIC Summary of this function goes here
%   Detailed explanation goes here
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
    %
    nBest = 0;
    medRankMat = zeros(nAltern,nBest);
    medPnltVec = zeros(1,nBest);
    %
%     meanRankVec = zeros(nAltern,1); % ����� ����� ������� ������� ������ ��� �����
    %
    [popRankMat, popPnltVec] = popGeneration(lossMat,nPopulation);
    popDistMat = linOrderPrwDist(popRankMat);
    while ~isRestart
        tic
        [offspRankMat, offspPnltVec] = ...
            getNextGen(lossMat,popRankMat,nCrossover,nMutation,nPerMut,isQuant);
        [popRankMat, popPnltVec, popDistMat, nNewPop] = ...
            popSelection(popRankMat,popPnltVec,popDistMat,offspRankMat,offspPnltVec);
        [medRankMat, medPnltVec, nNewMed] = ...
            addMedian(medRankMat,medPnltVec,offspRankMat,offspPnltVec);
        %
        %[meanRankVec,devVec] = popMean( medRankMat );
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
        if cntIter > 3000
            fprintf('====== restart ======\n');
            isRestart = true;
            cntRestart = cntRestart + 1;
            lastRestart = cntIter;
            [popRankMat, popPnltVec] = popGeneration(lossMat,nPopulation);
        else
        if lastAugPop < cntIter - 10
            if isQuant
                isQuant = false;
                fprintf('====== diversification ======\n');
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
                fprintf('====== quantile ======\n');
                isQuant = true;
                lastAugPop = cntIter;
            end
        end
        end 
        % stats
        sortPopPnltVec = sort(popPnltVec);
        minMedPnlt = min(medPnltVec);
        fprintf('---> step %i: time %g\n',...
            cntIter,toc)
        fprintf('----- min: %i ------- min_SQ: %g \n',fix(minMedPnlt),...
            1e2*(minMedPnlt-fix(minMedPnlt)));
        fprintf('----- nNewPop = %i, nNewMed = %i \n',nNewPop, nNewMed)
        fprintf('------- best_Pop:')
        tmpVec = sortPopPnltVec(1:5);
        fprintf('   %i',fix(tmpVec))
        fprintf('\n------- best_SQ:')
        fprintf('   %g',1e2*(tmpVec - fix(tmpVec)))
        
%         fprintf('\n------- worst_Pop:')
%         fprintf('   %i',popPnltVec(end-4:end))
        fprintf('\n------- med :   %i\n', fix(median(popPnltVec)))
        %
        fprintf(fileID,'% 5.1i',cntIter);
        fprintf(fileID,'% 20.9f% 6.1i',minMedPnlt,size(medRankMat,2));
        fprintf(fileID,'% 17.7f% 17.7f% 17.7f',sortPopPnltVec(1),...
            mean(popPnltVec),sortPopPnltVec(end));
        fprintf(fileID,'% 3.1i% 3.1i',nNewPop,nNewMed);
        fprintf(fileID,'% 4.1i% 4.1i% 4.1i% 4.1i',lastRestart,lastDevers,...
            cntRestart,cntDevers);
        fprintf(fileID,'\n');
        %
        cntIter = cntIter + 1;
    end
end

