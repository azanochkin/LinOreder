function [popRankMat,popPnltVec,popDistMat,nNewPop] = popSelection(...
    popRankMat,popPnltVec,popDistMat,offspRankMat,offspPnltVec)
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
    isOldPop = indUniq <= nPopulation;
    indOldPop = indUniq(isOldPop);
    unDistMat = zeros(length(indUniq));
    unDistMat(isOldPop,isOldPop) = popDistMat(indOldPop ,indOldPop);
    unDistMat(~isOldPop,:) = linOrderDist(unRankMat(:,~isOldPop),unRankMat);
    unDistMat(isOldPop,~isOldPop) = unDistMat(~isOldPop,isOldPop)';
    % 
    indSortVec = popManagement(unRankMat,-unPnltVec,unDistMat,nPopulation);
%     indSortVec = popManagement2(unRankMat,-unPnltVec);
%     [~,indSortVec] = sort(unPnltVec);
    indSortVec = indSortVec(1:nPopulation);
    popRankMat = unRankMat(:,indSortVec);
    popPnltVec = unPnltVec(indSortVec);
    %
    nNewPop = length(setdiff(indSortVec,1:nPopulation));
end