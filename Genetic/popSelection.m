function [popRankMat,popPnltVec,nNewPop] = popSelection(popRankMat,...
    popPnltVec,offspRankMat,offspPnltVec)
%POPSELECTION Select and add new offsprings to population
%   ToDo: Add population management to improve performance.
    nPopulation = length(popPnltVec);
    [unRankMat,indUniq] = unique([popRankMat, offspRankMat]','stable','rows');
    nLacking = nPopulation - length(indUniq); 
    if nLacking > 0
        indUniq = [indUniq(1)*ones(nLacking,1); indUniq];
    end
    %
    unPnltVec = [popPnltVec, offspPnltVec];
    unPnltVec = unPnltVec(indUniq);
    %
    [~,indSort] = sort(unPnltVec);
    indSort = indSort(1:nPopulation);
    popRankMat = unRankMat(indSort,:)';
    popPnltVec = unPnltVec(indSort);
    %
    nNewPop = length(setdiff(indSort,1:nPopulation));
end

