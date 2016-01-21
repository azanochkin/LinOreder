function rankVec = schulze(summRelMat)
    nAltert = size(summRelMat,1);
    maskMat = summRelMat>=summRelMat';
    tmpSummRelMat = summRelMat;
    tmpSummRelMat(~maskMat) = 0;
    tmpSummRelMat(1:nAltert+1:nAltert^2) = max(tmpSummRelMat,[],2);
    for i = 1:nAltert
        for j =1:nAltert
            tmpMask = maskMat(j,:);
            tmpRepRow = repmat(tmpSummRelMat(j,tmpMask),nAltert,1);
            tmpMat = min(tmpSummRelMat(tmpMask,:),tmpRepRow');
            tmpSummRelMat(j,:) = max(tmpMat);
        end
    end
    [~,~,rankVec] = unique(-sum(tmpSummRelMat));
end

