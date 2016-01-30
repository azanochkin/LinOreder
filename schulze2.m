function rankVec = schulze2(lossMat)
    %%
    lossMat = -lossMat;
    nAltert = size(lossMat,1);
    minMat = min(lossMat,lossMat');
    schNELossMat = lossMat - minMat;
    %%
    schNELossMat(1:nAltert+1:nAltert^2) = max(schNELossMat,[],2);
    for i = 1:nAltert %??
        for j = 1:nAltert
            tmpRepRow = repmat(schNELossMat(j,:),nAltert,1);
            tmpMat = min(schNELossMat,tmpRepRow');
            schNELossMat(j,:) = max(tmpMat);
        end
    end
    relMat = logical(schNELossMat);
    relMat(1:nAltert+1:nAltert^2) = true;
    if logical(double(relMat)*relMat)~=relMat
        error('not trancitive')
    end
    [~,~,rankVec] = unique(sum(relMat));
end

