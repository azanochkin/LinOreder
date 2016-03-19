function [medRankMat, medPnlt, nNewMed] = addMedian(medRankMat,...
    medPnlt,offspRankMat,offspPnltVec)
%ADDMEDIAN Refill median set
%   Detailed explanation goes here
    minOffspPnlt = min(offspPnltVec);
    if minOffspPnlt < medPnlt
        medRankMat = [];
        medPnlt = minOffspPnlt;
    end
    nMed = size(medRankMat,2);
    if minOffspPnlt == medPnlt
        isOffspMed = offspPnltVec == minOffspPnlt;
        medRankMat = [medRankMat, offspRankMat(:,isOffspMed)];
        medRankMat = unique(medRankMat','stable','rows')';
    end
    nNewMed = size(medRankMat,2) - nMed;
end

