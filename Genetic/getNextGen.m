function [ngRankMat, ngPnltVec] = getNextGen(lossMat, popRankMat,...
    nCrossover, nMutation, nPerMut)
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
        [offspRankMat(:,i),offspPnltVec(i)] = insertionMy(offspRankVec,lossMat);
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
        [mutatRankMat(:,i),mutatPnltVec(i)] = insertionMy(mutRankVec,lossMat);
    end      
    ngPnltVec = [offspPnltVec, mutatPnltVec];
    ngRankMat = [offspRankMat, mutatRankMat];    
end

