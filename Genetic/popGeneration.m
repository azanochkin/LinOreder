function [popRankMat, popPnltVec] = popGeneration(lossMat,nPopulation)
%POPGENERATION Create new population
%   Detailed explanation goes here
    nAltern = size(lossMat,1);
    popRankMat = zeros(nAltern,nPopulation);
    popPnltVec = zeros(1,nPopulation);
    for i = 1:nPopulation
        permVec = randperm(nAltern);
        permLossMat = lossMat(permVec,permVec);
        [popRankMat(permVec,i),popPnltVec(i)] = ...
            bestInsertion(permLossMat, false);
    end
end

