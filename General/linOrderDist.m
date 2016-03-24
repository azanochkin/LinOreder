function prwDistMat = linOrderDist( frstRankMat, scndRankMat)
%LINORDERDIST Find distance between linear ordering sets
%   Detailed explanation goes here
    [nAltern,nFrstExprt] = size(frstRankMat);
    nScndExprt = size(scndRankMat,2);
    prwDistMat = zeros(nFrstExprt,nScndExprt);
    for k = 1:nAltern
        frstDiffMat = sign(frstRankMat((k+1):end,:)...
            - repmat(frstRankMat(k,:),nAltern-k,1));
        scndDiffMat = sign(scndRankMat((k+1):end,:)...
            - repmat(scndRankMat(k,:),nAltern-k,1));
        for i = 1:nFrstExprt
            frstDiffVec = frstDiffMat(:,i);
            for j = 1:nScndExprt
                prwDistMat(i,j) = prwDistMat(i,j) + sum(abs(frstDiffVec - scndDiffMat(:,j)));
            end
        end
    end
end

