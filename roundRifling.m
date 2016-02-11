function consRankVec = roundRifling( proxRankVec, kemRankMat )
    pMask = ~isnan(proxRankVec);
    consRankMat = zeros(size(kemRankMat));
    for i = 1:size(kemRankMat,2)
        rankVec = kemRankMat(:,i);
        consRankMat(:,i) = classify1(rankVec,rankVec(pMask),proxRankVec(pMask),false);
    end
    consRankVec = round(median(consRankMat,2));
end

