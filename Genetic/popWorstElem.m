function indWorst = popWorstElem(pnltVec, distVec)
%POPWORSTELEM Summary of this function goes here
%   Detailed explanation goes here
    pnltStd = std(pnltVec);
    distStd = std(distVec);
    if pnltStd == 0
        pnltStd = 1;
    end
    if distStd == 0
        distStd = 1;
    end
    utilVec = pnltVec/pnltStd + 0.5*distVec/distStd;
    minSum = min(utilVec);
    indWorst = find(utilVec == minSum);
    minPen = min(pnltVec(indWorst));
    indWorst = indWorst(find(minPen == pnltVec(indWorst),1,'last'));
end

