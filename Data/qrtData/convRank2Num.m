function rankVec = convRank2Num( rankVec, scTable, indVocab )
%CONVRANK2NUM Summary of this function goes here
%   Detailed explanation goes here
    isNum = isnumeric(rankVec);
    isStr = iscellstr(rankVec);
    if ~isNum && ~isStr
        error('loadData:convRank2num','data in table is not correct')
    end
    if isStr
        convRankVec = nan(size(rankVec));
        for i=1:height(scTable)
            isiRankVec = strcmpi(scTable{i,1},rankVec);
            convRankVec(isiRankVec) = scTable{i,2};
        end
        rankVec = convRankVec;
    end
    if indVocab > 1
        convRankVec = nan(size(rankVec));
        for i=1:height(scTable)
            isiRankVec = scTable{i,2} == rankVec;
            convRankVec(isiRankVec) = scTable{i,2*indVocab};
        end
        rankVec = convRankVec;
    end 
end

