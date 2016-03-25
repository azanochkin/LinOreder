function prwDistMat = linOrderDist( frstRankMat, scndRankMat)
%LINORDERDIST Find distance between linear ordering sets
%   Detailed explanation goes here
    [nAltern,nFrstExprt] = size(frstRankMat);
    nScndExprt = size(scndRankMat,2);
    prwDistMat = zeros(nFrstExprt,nScndExprt);
    for k = 1:nAltern
        repFrstRankMat = repmat(frstRankMat(k,:),nAltern-k,1);
        frstDiffMat = sign(frstRankMat((k+1):end,:) - repFrstRankMat);
        repScndRankMat = repmat(scndRankMat(k,:),nAltern-k,1);
        scndDiffMat = sign(scndRankMat((k+1):end,:) - repScndRankMat);
        for i = 1:nFrstExprt
            repFrstDiffMat = repmat(frstDiffMat(:,i),1,nScndExprt);
            prwDistMat(i,:) = prwDistMat(i,:) + sum(abs(repFrstDiffMat - scndDiffMat),1);
        end
    end
end

