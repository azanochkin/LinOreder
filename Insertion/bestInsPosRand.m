function [ind,isEq,minPen] = bestInsPosRand(nePenVec,eqPenVec,eqPen,shiftPen)
    penVec = [nePenVec,eqPenVec-eqPen];
    minPen = min(penVec) + shiftPen;
%     minPen = floor(min(penVec));
%     if shift>0
%         minPen = minPen + shift;
%     else
%         minPen = quantile(penVec(penVec<=minPen+1),0.95);
%     end
    indQuantVec = find(penVec <= minPen);
    ind = indQuantVec(randi(length(indQuantVec)));
    minPen = penVec(ind);
    isEq = ind>length(nePenVec);
    if isEq
        ind = ind - length(nePenVec);
        minPen = minPen + eqPen;
    end
end