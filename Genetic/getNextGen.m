function [ngRankMat, ngPnltVec] = getNextGen(lossMat, popRankMat,...
    nCrossover, nMutation, nPerMut,isQuant)
%GETNEXTGEN Summary of this function goes here
%   Detailed explanation goes here
    [nAltern, nPopulation] = size(popRankMat);
    offspRankMat = zeros(nAltern,nCrossover);
    offspPnltVec = zeros(1,nCrossover);
    mutatRankMat = zeros(nAltern,nMutation);
    mutatPnltVec = zeros(1,nMutation);
    parfor i = 1:nCrossover
        % indPerVec = randperm(nAltern,2);
        indPer1 = randi(nPopulation);
        indPer2 = randi(nPopulation);        
        maskVec = rand(nAltern,1) > 0.5;
        offspRankVec = popRankMat(:,indPer1);
        offspRankVec(maskVec) = popRankMat(maskVec,indPer2);
        offspPnlt = getPenalty(offspRankVec,lossMat);
        [offspRankMat(:,i),offspPnltVec(i)] = ...
            ...%insertionMy1(offspRankVec,offspPnlt,lossMat,isQuant);
            ...%insertionMy(offspRankVec,offspPnlt,lossMat);
            insertionMyFix(offspRankVec,offspPnlt,lossMat,isQuant);
    end
    parfor i = 1:nMutation
        indPer = randi(nPopulation);
        mutRankVec = popRankMat(:,indPer);
        for k = 1:nPerMut
            % indPerVec = randperm(nAltern,2);
            indPer1 = randi(nAltern);
            indPer2 = randi(nAltern);
            mutRankVec([indPer1,indPer2]) = mutRankVec([indPer2,indPer1]);
        end
        mutPnlt = getPenalty(mutRankVec,lossMat);
        [mutatRankMat(:,i),mutatPnltVec(i)] = ...
            ...%insertionMy1(mutRankVec,mutPnlt,lossMat,isQuant);
            ...%insertionMy(mutRankVec,mutPnlt,lossMat);
            insertionMyFix(mutRankVec,mutPnlt,lossMat,isQuant);
        
    end      
    ngPnltVec = [offspPnltVec, mutatPnltVec];
    ngRankMat = [offspRankMat, mutatRankMat];    
end

