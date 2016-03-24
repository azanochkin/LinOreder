function indSortVec = popManagement2( rankMat, pnltVec)
%POPMANAGEMENT Summary of this function goes here
%   Detailed explanation goes here
    distMat = linOrderDist(rankMat,rankMat);
    distVec = sum(distMat);
    pnltStd = std(pnltVec);
    distStd = std(distVec);
    if pnltStd == 0
        pnltStd = 1;
    end
    if distStd == 0
        distStd = 1;
    end
    [~,indSortVec] = sort(pnltVec/pnltStd + 0.2*distVec/distStd,'descend');
    figure(1);
    cla
    hold on;plot(pnltVec,distVec,'+')
    plot(pnltVec(indSortVec(1:60)),distVec(indSortVec(1:60)),'or')
end

