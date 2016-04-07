function checkPenalty( compPen, rankVec, lossMat, fnctStr)
%CHECKPENALTY Summary of this function goes here
%   Detailed explanation goes here
    realPenalty = getPenalty(rankVec,lossMat);
    fprintf('%s> real: %g , comp: %g\n',fnctStr,realPenalty, compPen);
    if abs(realPenalty - compPen) > abs(1e-8*(realPenalty - fix(realPenalty)))
        error('ERROR: %s> real penalty is not equal to computed',fnctStr);
    end
end

