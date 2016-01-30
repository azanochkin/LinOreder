function [ newRankVec, kemenyDist ] = ChanKoby(rankVec, lossMat, optimFnc, nIter)
    newRankVec = rankVec;
    for i = 1:nIter
        [newRankVec,kemenyDist] = optimFnc(newRankVec(end:-1:1),lossMat);
    end
end

