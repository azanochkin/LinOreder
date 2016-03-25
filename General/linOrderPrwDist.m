function prwDistMat = linOrderPrwDist( rankMat)
%LINORDERPRWDIST Find distance between linear orderings
%   Detailed explanation goes here
    [nAltern,nExprt] = size(rankMat);
    prwDistMat = zeros(nExprt);
    for k = 1:nAltern
        repRankMat = repmat(rankMat(k,:),nAltern-k,1);
        diffMat = sign(rankMat((k+1):end,:) - repRankMat);
        for i = 1:nExprt
            repDiffMat = repmat(diffMat(:,i),1,nExprt-i);
            prwDistMat(i,i+1:end) = prwDistMat(i,i+1:end) + ...
                sum(abs(repDiffMat - diffMat(:,i+1:end)),1);
        end
    end
    prwDistMat = prwDistMat + prwDistMat';
end

