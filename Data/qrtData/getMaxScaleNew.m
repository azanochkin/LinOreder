function normRankVec = getMaxScaleNew( scales, RankNamesTab, idVoc )
%GETMAXSCALE Summary of this function goes here
%   Detailed explanation goes here
    
    scName=RankNamesTab.Properties.RowNames;
    agName=RankNamesTab.Properties.VariableNames;
    nSc=height(RankNamesTab);
    nAg=width(RankNamesTab);
    
    normRankVec = nan(1,nSc*nAg);

    for i=1:nSc
        for j=1:nAg
           if RankNamesTab{i,j}==1
            scTable = getfield(scales,[agName{j},'_',scName{i}]);
            scaleVec = scTable{:,2*idVoc};
            normRankVec(nAg*(i-1)+j) = max(scaleVec(scaleVec<100));
           end
        end
    end
end

