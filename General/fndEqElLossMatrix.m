function [indEqVec, isFrstUniqVec] = fndEqElLossMatrix(lossMat)
%FNDEQELLOSSMATRIX Summary of this function goes here
%   Detailed explanation goes here
    nAltern = size(lossMat,1);
    indEqVec = zeros(nAltern,1);
    isFrstUniqVec = true(nAltern,1);
    for i = 1:nAltern
        isObsVec = (lossMat(i,1:i)<=0) & (lossMat(1:i,i)<=0)';
        indVec = find(isObsVec);
        for j = indVec
            isEqVec = (lossMat(i,:)==lossMat(j,:)) & ...
                (lossMat(:,i)==lossMat(:,j))';
            isEqVec([i,j]) = true;
            if all(isEqVec)
                break
            end
        end
        indEqVec(i) = j;
        isFrstUniqVec(i) = i == j;
    end
end
