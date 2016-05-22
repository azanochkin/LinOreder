function normRankVec = getMaxScale( scales, indVocab )
%GETMAXSCALE Summary of this function goes here
%   Detailed explanation goes here
    fNamesCVec = fieldnames(scales);
    normRankVec = nan(1,length(fNamesCVec));
    for i = 1:length(fNamesCVec)
        scTable = getfield(scales,fNamesCVec{i});
        scaleVec = scTable{:,2*indVocab};
        normRankVec(i) = max(scaleVec(scaleVec<100));
    end
end

