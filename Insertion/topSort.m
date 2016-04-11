function [indVec,realTop] = topSort( nsortVec, nTop)
%TOPSORT Summary of this function goes here
%   Detailed explanation goes here
    lBound = 1;
    rBound = length(nsortVec);
    indVec = 1:rBound;
    while lBound < rBound-1
        x = nsortVec(nTop);
        i = lBound;
        j = rBound;
        while i<=j
            while nsortVec(i)<x
                i = i+1;
            end
            while nsortVec(j)>x
                j = j-1;
            end
            if i<=j
                w = nsortVec(i);
                nsortVec(i) = nsortVec(j);
                nsortVec(j) = w;
                %
                w = indVec(i);
                indVec(i) = indVec(j);
                indVec(j) = w;
                %
                i=i+1;
                j=j-1;
            end
        end
        if j<nTop
            lBound = i;
        end
        if i>nTop
            rBound = j;
        end
    end
    realTop = nTop;
end

