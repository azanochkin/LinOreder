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
        medOffspRankMat = offspRankMat(:,isOffspMed);
        unMedOffspRankMat = unique(medOffspRankMat','stable','rows')';
        if nMed == 0
            isNewMedVec = true(size(unMedOffspRankMat,2),1);
        else
            isNewMedVec = ~ismember(unMedOffspRankMat',medRankMat','rows');
        end
        medRankMat = [medRankMat, unMedOffspRankMat(:,isNewMedVec)];
    end
    nNewMed = size(medRankMat,2) - nMed;
end

