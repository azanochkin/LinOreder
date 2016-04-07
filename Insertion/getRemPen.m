function pen = getRemPen(curPos,nePenVec,eqPenVec,maskEq)
%REMOVEPEN Summary of this function goes here
%   Detailed explanation goes here
    iskEq = maskEq(curPos);
    if curPos < length(maskEq)
        iskEq = iskEq || maskEq(curPos+1);
    end
    r = sum(~maskEq(1:curPos));
    if iskEq
        pen = eqPenVec(r);
    else
        pen = nePenVec(r);
    end
end

