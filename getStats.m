function [medianKemMat, quantArr ,medianCell] = getStats(rankVecMat, kemRankVec, quantiles)
    function roundVal = roundRank(val, rnRankVec)
        if isnan(val)
            roundVal = nan;
        else
            unRnRankVec = unique(rnRankVec);
            [~,indCl] = min(abs(unRnRankVec - val)) ;
            roundVal = unRnRankVec(indCl);
        end
    end
    function [medianVecCell , quantMat] = getQuant(quantiles, rankVec, kemRankVec)
        uniqRankVec = unique(rankVec(~isnan(rankVec)));
        uniqKemRankVec = unique(kemRankVec(~isnan(kemRankVec)));
        quantMat = NaN(length(uniqKemRankVec),length(quantiles));
        medianVecCell = cell(length(uniqKemRankVec),1);
        isQuantRange = true(length(uniqKemRankVec),length(quantiles));
        for i = 1:length(uniqRankVec)
            % median
            locKemRankVec = kemRankVec(rankVec == uniqRankVec(i));
            medRank = roundRank(median(locKemRankVec),locKemRankVec);
            ind = find(uniqKemRankVec == medRank);
            medianVecCell{ind} = [medianVecCell{ind}, uniqRankVec(i)];
            % quantiles
            for k = 1:length(quantiles)
                quant = quantile(locKemRankVec,1-quantiles(k));
                quant = roundRank(quant,locKemRankVec);
                tmpMask = uniqKemRankVec >= quant;
                isQuantRange(:,k) = isQuantRange(:,k) & tmpMask;
                quantMat(isQuantRange(:,k),k) = uniqRankVec(i);
            end
        end
    end
    function medianKemVec = getMedian(rankVec, kemRankVec)
        uniqKemRankVec = unique(kemRankVec(~isnan(kemRankVec)));
        medianKemVec = zeros(length(uniqKemRankVec),1);
        for i = 1:length(uniqKemRankVec)
            tmpMask = kemRankVec == uniqKemRankVec(i);
            tmp = rankVec(tmpMask & ~isnan(rankVec));
            medianKemVec(i) = roundRank(median(tmp),tmp);
        end
    end
    %
    nAgency = size(rankVecMat,2);
    nKemGrade = length(unique(kemRankVec(~isnan(kemRankVec))));
    medianCell = cell(nKemGrade,nAgency);
    quantArr = zeros(nKemGrade,length(quantiles),nAgency);
    medianKemMat = zeros(nKemGrade,nAgency);
    for j = 1:nAgency
        rankVec = rankVecMat(:,j);
        % fix agency grade and find median in kemeny range + quantiles
        [medianCell(:,j) , quantArr(:,:,j)] = getQuant(quantiles, rankVec, kemRankVec);
        % fix kemeny grade and find median in agency range
        medianKemMat(:,j) = getMedian(rankVec, kemRankVec);
    end
end
