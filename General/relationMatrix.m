function relMatArr = relationMatrix(timeVec, prefRankMat, subRankMat, varargin)
    function maskLE = uniqRelationMatrix(timeVec, prefRankVec,...
            subRankVec, isEqConsid)
        nAltern = size(timeVec,1);
        %
        repPrefRankMat = repmat(prefRankVec,1,nAltern);
        maskPrefLE = repPrefRankMat <= repPrefRankMat';
        if all(isnan(subRankVec))
            if isEqConsid
                maskLE = maskPrefLE;
            else
                %maskLE = repPrefRankMat < repPrefRankMat';
                maskLE = maskPrefLE & ~maskPrefLE';
            end
            maskLE = maskLE|eye(nAltern);
        else
            maskPrefG = repPrefRankMat > repPrefRankMat';
            %
            repTimeMat = repmat(timeVec(:),1,nAltern);
            maskTime = repTimeMat == repTimeMat';
            %
            repSubRankMat = repmat(subRankVec,1,nAltern);
            maskSubLE = repSubRankMat <= repSubRankMat';
            maskSubLE = maskSubLE & maskTime;
            maskSubG = repSubRankMat > repSubRankMat';
            maskSubG = maskSubG & maskTime;
            %
            maskG = (maskSubG & ~maskPrefG')| maskPrefG;
            if isEqConsid
                maskLE = ((maskPrefLE | maskSubLE ) | maskG') & ~maskG;
            else 
                maskLE = ((maskPrefG' | maskSubG' ) | maskG') & ~maskG;
            end
            % transitive closure
            maskLE = maskLE|eye(nAltern);
            maskLE = transClosure(maskLE);
        end
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

