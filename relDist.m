function [R,NR,D,Vol] = relDist(relMatrixArr)
% R - violation matrix
% NR - uncomparable matrix
% D - distance matrix
% Vol - matrix of comparable elements volume
    nExperts = size(relMatrixArr,3);
    R = zeros(nExperts);
    NR = zeros(nExperts);
    isNonmetrized = relMatrixArr(1) == 1;
    if isNonmetrized
        deg = 1;
    else
        deg = 2;
    end
    for i = 1:nExperts-1
        rel1 = relMatrixArr(:,:,i);
        for j = i+1:nExperts
            rel2 = relMatrixArr(:,:,j);
            if isNonmetrized
                isEmpt1 = (~rel1)&((~rel1'));
                isEmpt2 = (~rel2)&((~rel2'));
            else
                isEmpt1 = isnan(rel1);
                isEmpt2 = isnan(rel2);
            end
            isEmpt = isEmpt1|isEmpt2;
            %NR(i,j) = sum(sum(xor(isEmpt1,isEmpt2)));
            NR(i,j) = sum(sum(or(isEmpt1,isEmpt2)));
            %R(i,j) = sum(sum(abs(rel1(~isEmpt)-rel2(~isEmpt))));
            R(i,j) = sum(sum(abs(rel1(~isEmpt)-rel2(~isEmpt)).^deg));
        end
    end
    R = R'+R;
    NR = NR'+NR;
    nAltern = size(relMatrixArr,1);
    Vol = nAltern*(nAltern-1) - NR;
    D = R./Vol;
    %altVol = 0.5+sqrt(0.25+Vol);
end

