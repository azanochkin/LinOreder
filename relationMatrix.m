function relMatArr = relationMatrix(timeVec, prefRankMat, subRankMat)
    function maskLE = uniqRelationMatrix(timeVec, prefRankVec, subRankVec)
        nAltern = size(timeVec,1);
        %
        repPrefRankMat = repmat(prefRankVec,1,nAltern);
        repSubRankMat = repmat(subRankVec,1,nAltern);
        repTimeMat = repmat(timeVec(:),1,nAltern);
        %
        maskTime = repTimeMat == repTimeMat';
        maskPrefLE = repPrefRankMat <= repPrefRankMat';
        maskPrefG = repPrefRankMat > repPrefRankMat';
        maskSubLE = repSubRankMat <= repSubRankMat';
        maskSubG = repSubRankMat > repSubRankMat';
        %
        maskG = (maskSubG & maskTime & ~maskPrefG')| maskPrefG;
        % E
        maskLE = (((maskPrefLE | maskSubLE) & maskTime) | maskG') & ~maskG;
        % NE 
        %maskLE = (((maskPrefG' | maskSubG') & maskTime) | maskG') & ~maskG;
        % transitive closure
        maskLE = maskLE|eye(nAltern);
        maskLE = transClosure(maskLE);
    end
    nAltern = size(prefRankMat,1);
    nExperts = size(prefRankMat,2);
    relMatArr = false(nAltern,nAltern,nExperts);
    for i = 1:nExperts
        relMatArr(:,:,i) = uniqRelationMatrix(timeVec, prefRankMat(:,i), subRankMat(:,i));
    end   
end

