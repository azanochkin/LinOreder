function [ind,isEq,minPen] = bestInsPosRand(nePenVec,eqPenVec,eqPen,shiftPen)
    penVec = [nePenVec,eqPenVec+eqPen];
    minPen = min(penVec);
    indQuantVec = find(penVec <= minPen + shiftPen);
    ind = indQuantVec(randi(length(indQuantVec)));
    minPen = penVec(ind);
    isEq = ind>length(nePenVec);
    if isEq
        ind = ind - length(nePenVec);
        minPen = minPen - eqPen;
    end
end