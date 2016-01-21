function [rankVec,kemenyDist] = bestInsertion(lossMatNE, lossMatE)
    nAltern = size(lossMatNE,1);
    altOrder = zeros(nAltern,1);
    altOrder(1) = 1;
    kemenyDist = 0;
    maskEq = false(nAltern,1);
    %numGrid = 1:nAltern;
    for l = 2:nAltern
        %disp(l)
        lastRow = lossMatNE(l,altOrder(l-1:-1:1));
        lastRow = [0 cumsum(lastRow)];
        lastRow = lastRow(end:-1:1);
        rghtRow = lossMatNE(altOrder(1:l-1),l)';
        rghtRow = [0 cumsum(rghtRow)];
        R1 = lastRow+rghtRow;
        R2 = zeros(1,l-1);
        for t = 1:l-1
            R2(t) = rghtRow(t) + lossMatE(l,altOrder(t));
            q = 1;
            while maskEq(t+q)
                R2(t) = R2(t) + lossMatE(l,altOrder(t+q));
                q = q + 1;
            end
            R2(t) = R2(t) + lastRow(t+q);
        end
        numGrid = 1:l;
        numGrid = numGrid(~maskEq(1:l));
        [kemAdd,ind] = min([R2(~maskEq(1:l-1)),R1(~maskEq(1:l))]);
        %ind = numGrid(ind);
        if ind>sum(~maskEq(1:l-1))
            ind = ind-sum(~maskEq(1:l-1));
            ind = numGrid(ind);
        else
            ind = numGrid(ind);
            maskEq(ind) = true;
        end

%             [kemAdd,ind] = min([R1(~maskEq(1:l)),R2(~maskEq(1:l-1))]);
%             %ind = numGrid(ind);
%             if ind>sum(~maskEq(1:l))
%                 ind = ind-sum(~maskEq(1:l));
%                 ind = numGrid(ind);
%                 maskEq(ind) = true;
%             else
%                 ind = numGrid(ind);
%             end
        maskEq(ind+1:l) = maskEq(ind:l-1);
        maskEq(ind) = false;
        altOrder(ind+1:l) = altOrder(ind:l-1);
        altOrder(ind) = l;
        kemenyDist = kemenyDist + kemAdd;
    end
    rankVec = zeros(nAltern,1);
    rankVec(altOrder) = 1:nAltern;
    for l = 2:nAltern
        if maskEq(l)
            rankVec(altOrder(l)) = rankVec(altOrder(l-1));
        end
    end
    realPenalty = getPenalty(rankVec,lossMatNE, lossMatE);
    fprintf('BEST_INSERTION> real: %i , comp: %i \n',realPenalty, kemenyDist);
end