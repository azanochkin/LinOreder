function [popRankMat,popPnltVec,nNewPop] = popSelection(popRankMat,...
    popPnltVec,offspRankMat,offspPnltVec)
%POPSELECTION Select and add new offsprings to population
%   ToDo: Add population management to improve performance.
    nPopulation = length(popPnltVec);
    [unRankMat,indUniq] = unique([popRankMat, offspRankMat]','stable','rows');
    unRankMat = unRankMat';
    nLacking = nPopulation - length(indUniq); 
    if nLacking > 0
        indUniq = [indUniq(1)*ones(nLacking,1); indUniq];
    end
    %
    unPnltVec = [popPnltVec, offspPnltVec];
    unPnltVec = unPnltVec(indUniq);
    %
    indSortVec = popManagement(unRankMat,-unPnltVec,nPopulation);
%     indSortVec = popManagement2(unRankMat,-unPnltVec);
%     [~,indSortVec] = sort(unPnltVec);
    indSortVec = indSortVec(1:nPopulation);
    popRankMat = unRankMat(:,indSortVec);
    popPnltVec = unPnltVec(indSortVec);
    %
    nNewPop = length(setdiff(indSortVec,1:nPopulation));
end