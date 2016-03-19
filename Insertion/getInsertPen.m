function [nePenVec,eqPenVec] = getInsertPen(lVec, gVec, maskEq)
    lastRow = [0 cumsum(gVec(end:-1:1))];
    lastRow = lastRow(end:-1:1);
    rghtRow = [0 cumsum(lVec)];
    %
    maskEq = [maskEq; false];
    lastRow = lastRow(~maskEq);
    rghtRow = rghtRow(~maskEq);
    nePenVec = lastRow+rghtRow;
    eqPenVec = lastRow(1:end-1)+rghtRow(2:end);
end

