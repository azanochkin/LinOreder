function [medRankMat, medPnltVec, nNewMed] = addMedian(medRankMat,...
    medPnltVec,offspRankMat,offspPnltVec,maxMedAmnt)
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
%         unMedOffspRankMat = unique([medPnltVec medOffspPnltVec; ...
%                                     medRankMat medOffspRankMat]','rows');
%         medRankMat = unMedOffspRankMat(:,2:end)';
%         medPnltVec = unMedOffspRankMat(:,1)';
        [unMedOffspRankMat,indUnMedOffspVec] = unique(medOffspRankMat','stable','rows');
        unMedOffspPnltVec = medOffspPnltVec(indUnMedOffspVec);
        if nMed == 0
            isNewMedVec = true(size(unMedOffspPnltVec));
        else
            isNewMedVec = ~ismember(unMedOffspRankMat,medRankMat','rows');
        end
        medRankMat = [medRankMat, unMedOffspRankMat(isNewMedVec,:)'];
        medPnltVec = [medPnltVec, unMedOffspPnltVec(isNewMedVec)];
        if length(medPnltVec)>maxMedAmnt
            [~,indSortVec] = sort(medPnltVec);
            indCutSortVec = indSortVec(1:maxMedAmnt);
            medPnltVec = medPnltVec(indCutSortVec);
            medRankMat = medRankMat(:,indCutSortVec);
            nNewMed = sum(indCutSortVec > nMed);
        else
            nNewMed = size(medRankMat,2) - nMed;
        end
    else
        nNewMed = 0;
    end
end

