function [ind,isEq,minPen] = bestInsPos(nePenVec,eqPenVec,isEqPrior)
    [minNePen,indNePen] = min(nePenVec);
    [minEqPen,indEqPen] = min(eqPenVec);
    isEq = minEqPen < minNePen;
    if minEqPen == minNePen
        isEq = isEqPrior;
    end 
    if isEq
        minPen = minEqPen;
        %ind = indEqPen;
        ind = find(eqPenVec == minEqPen);
        ind = ind(randi(length(ind)));
    else
        minPen = minNePen;
        %ind = indNePen;
        ind = find(nePenVec == minNePen);
        ind = ind(randi(length(ind)));
    end
end


