function rankVec = buzdShare( lossMat )
%BUZDSHARE Ranking on the majority principle
%   Applying majority principle to lossMat and find non-transitive closure
%   of the resulting ranking.
    ntransRelMat = (lossMat < 0) | eye(size(lossMat));
    clRelMat = transClosure(ntransRelMat);
    isComp = clRelMat | transpose(clRelMat); 
    if any(any(~isComp))
        disp('non closed');
        clRelMat = transClosure(clRelMat | ~isComp);
    end
    if any(any(~(clRelMat | transpose(clRelMat))))
        error('pff');
    end
    [~,~,rankVec] = unique(sum(clRelMat));
    %
    tmpVec = zeros(1,max(rankVec));
    for i = rankVec'
        tmpVec(i) = tmpVec(i)+1;
    end
    disp(tmpVec);
end

