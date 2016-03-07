function relMatArr = relationMatrix(timeVec, prefRankMat, subRankMat, varargin)
    function maskLE = uniqRelationMatrix(timeVec, prefRankVec,...
            subRankVec, isEqConsid)
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
        if isEqConsid
            maskLE = (((maskPrefLE | maskSubLE) & maskTime) | maskG') & ~maskG;
        else 
            maskLE = (((maskPrefG' | maskSubG') & maskTime) | maskG') & ~maskG;
        end
        % transitive closure
        maskLE = maskLE|eye(nAltern);
        maskLE = transClosure(maskLE);
    end
    %
    if nargin > 3
        isEqConsid = varargin{1};
    else
        isEqConsid = true;
    end
    nAltern = size(prefRankMat,1);
    nExperts = size(prefRankMat,2);
    relMatArr = false(nAltern,nAltern,nExperts);
    for i = 1:nExperts
        relMatArr(:,:,i) = uniqRelationMatrix(timeVec, prefRankMat(:,i),...
            subRankMat(:,i), isEqConsid);
    end   
end

