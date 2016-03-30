function [medRankMat, medPnltVec, nNewMed] = addMedian(medRankMat,...
    medPnltVec,offspRankMat,offspPnltVec)
%ADDMEDIAN Refill median set
%   Detailed explanation goes here
    fixOffSpPnlt = fix(offspPnltVec);
    minOffspPnlt = min(fixOffSpPnlt);
    if ~isempty(medPnltVec)
        medPnlt = fix(medPnltVec(1));
        if minOffspPnlt < medPnlt
            medRankMat = [];
            medPnltVec = [];
            medPnlt = minOffspPnlt;
        end
    else
        medPnlt = minOffspPnlt;
    end
    nMed = length(medPnltVec);
    if minOffspPnlt == medPnlt
        isOffspMed = fixOffSpPnlt == minOffspPnlt;
        medOffspRankMat = offspRankMat(:,isOffspMed);
        medOffspPnltVec = offspPnltVec(isOffspMed);
        [unMedOffspRankMat,indUnMedOffspVec] = unique(medOffspRankMat','stable','rows');
        unMedOffspPnltVec = medOffspPnltVec(indUnMedOffspVec);
        if nMed == 0
            isNewMedVec = true(size(unMedOffspPnltVec));
        else
            isNewMedVec = ~ismember(unMedOffspRankMat,medRankMat','rows');
        end
        medRankMat = [medRankMat, unMedOffspRankMat(isNewMedVec,:)'];
        medPnltVec = [medPnltVec, unMedOffspPnltVec(isNewMedVec)];
    end
    nNewMed = size(medRankMat,2) - nMed;
end

