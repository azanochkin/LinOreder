function [indEqVec, isFrstUniqVec] = fndEqElLossMatrix(lossMat)
%FNDEQELLOSSMATRIX Summary of this function goes here
%   Detailed explanation goes here
    nAltern = size(lossMat,1);
    indEqVec = zeros(nAltern,1);
    isFrstUniqVec = true(nAltern,1);
    mask = true(nAltern,1);
    for i = 1:nAltern
        mask(i) = false;
        j = 1;
        mask(j) = false;
        while any(lossMat(i,mask)~=lossMat(j,mask)) || ...
                any(lossMat(mask,i)~=lossMat(mask,j)) || ...
                (lossMat(i,j)>0) || (lossMat(j,i)>0)
            mask(j) = true;
            j = j + 1;
            mask(j) = false;
        end
        mask(j) = true;
        mask(i) = true;
        indEqVec(i) = j;
        isFrstUniqVec(i) = i == j;
    end
end
