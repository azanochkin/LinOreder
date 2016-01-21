function rankVec = heuristAlgrthMy(begRankVec,lossNEMat,lossEMat)
    function s = sumMask(mat,mask)
%        n = size(mat,1);
%        s = zeros(n,1);
%        for i = 1:n
%            s(i) = sum(mat(i,mask(i,:)));
%        end 
        tmpMat = mat;
        tmpMat(~mask) = 0;
        s = sum(tmpMat,2);
    end
    function pen = getPenalty(rankVec)
        tmp = repmat(rankVec,1,nAltern);
        tmpNE = tmp<tmp';
        pen = sum(lossNEMat(tmpNE));
        tmpE = tmp == tmp';
        pen = pen + sum(lossEMat(tmpE))/2;
    end
    begRankVec = int16(begRankVec);
    lossNEMat = int16(lossNEMat);
    lossEMat = int16(lossEMat);
    nAltern = size(lossEMat,1);
    flag = true;
    rankVec = begRankVec(:);
    while flag
        tmpPen = getPenalty(rankVec);
        repRankMat = repmat(rankVec,1,nAltern);
        % new rank
        mask = repRankMat == repRankMat';
        penaltEVec = sumMask(lossEMat,mask);
        penaltNEVec = sumMask(lossNEMat,mask);
        penaltVec1 = penaltNEVec - penaltEVec;
        % up rank
        mask = (repRankMat-1) == repRankMat';
        penaltEVec = sumMask(lossEMat,mask);
        penaltNEVec = sumMask(lossNEMat',mask);
        penaltVec2 = penaltVec1 + (penaltEVec - penaltNEVec);
        %
        flag = any(penaltVec1<0)||any(penaltVec2<0);
        if flag
            [min1,ind1] = min(penaltVec1);
            [min2,ind2] = min(penaltVec2);
            if min1<=min2
                mask = rankVec >= rankVec(ind1);
                rankVec(mask) = rankVec(mask)+1;
                rankVec(ind1) = rankVec(ind1)-1;
            else
                rankVec(ind2) = rankVec(ind2)-1;
            end
            fprintf(' %i %i = \n %i\n==========\n',tmpPen,min(min1,min2),tmpPen+min(min1,min2))
        end
    end
    disp(getPenalty(rankVec));
end