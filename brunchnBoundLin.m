function  [rankVec,kemDist,varargout] = brunchnBoundLin(rankVecMat,varargin)
    function [bestRankVec,bestKemDist] = recurs(lossMat,heurRankVec,maxKemDist,recDep)
        bestKemDist = maxKemDist;
        nAltern = length(heurRankVec);
        heurPosVec(heurRankVec) = (1:nAltern)';
        bestRankVec = heurRankVec;
        if recDep<7
            fprintf([repmat('=',1,2*recDep),'> %i\n'],length(heurRankVec))
        end
        if isTimeBreak
            if toc>maxTime
                flagBreak = true;
                return;
            end
        end
        for i = 1:nAltern
            firstInd = heurPosVec(i);
            frstRankVec = zeros(nAltern,1);
            frstRankVec(firstInd) = 1;%первым элементом выбран heurPosVec(i)
            maskInd = true(nAltern,1);
            maskInd(firstInd) = false;
            frstKemDist = sum(lossMat(firstInd,:));
            %чистка по остаткам
            [clRankVec,clKemDist,ntop] = clLossMatric(lossMat(maskInd,maskInd));
            tmpMask = maskInd;
            tmpMask(maskInd) = clRankVec>0;
            frstRankVec(tmpMask) = clRankVec(clRankVec>0)+1;
            maskInd(maskInd) = clRankVec==0;
            if any(maskInd) %если непусто, то построить оценку снизу
                tmpLossMat = lossMat(maskInd,maskInd);
                lowBound = sum(sum(min(tmpLossMat,tmpLossMat')))/2;
                if (lowBound+clKemDist+frstKemDist)<bestKemDist
                    %если оцена снизу выше bestKemDist, то готовим сл. итерацию
                    %Cтоим эвристическую оценку
                    [scndHeurRankVec,scndHeurKemDist] = heuristAlgrthm2(tmpLossMat);
                    %[scndHeurRankVec,scndHeurKemDist] = heuristAlgrthm(tmpLossMat);
                    if scndHeurKemDist==lowBound
                        scndRankVec = scndHeurRankVec;
                        scndKemDist = scndHeurKemDist;
                    else
                        [scndRankVec,scndKemDist] = recurs(tmpLossMat,scndHeurRankVec,scndHeurKemDist,recDep+1);
                    end
                    if (scndKemDist+clKemDist+frstKemDist)<bestKemDist
                        %к полученному результату приписываем чистку и первый элемент
                        frstRankVec(maskInd) = scndRankVec+1+ntop;
                        bestRankVec = frstRankVec;
                        %Oбновляем maxKemDist(с помощью построенной оценки)
                        bestKemDist = scndKemDist+clKemDist+frstKemDist;
                    end
                end
            elseif (frstKemDist+clKemDist)<bestKemDist
                %если пусто - считаем значение дистанции и если проходит -
                %считаем эту оценку как лучшую
                bestRankVec = frstRankVec;
                bestKemDist = clKemDist+frstKemDist;
            end
        end
    end
    isTimeBreak = nargin>1;
    if isTimeBreak
        tic;
        maxTime = varargin{1};
        flagBreak = false;
    end
    lossMat = lossMatrix1(rankVecMat);
    [rankVec,kemDistCl,nTop] = clLossMatric(lossMat);
    ind = rankVec==0;
    [rankVecHeur,kemDistHeur] = heuristAlgrthm2(lossMat(ind,ind));
    % добавить проверку на совпадение оценки и востроенного порядка
    [bestPosVec,bestKemDist] = recurs(lossMat(ind,ind),rankVecHeur,kemDistHeur,1);
    kemDist = kemDistCl+bestKemDist;
    rankVec(ind) = bestPosVec+nTop;
    numGrid = 1:size(lossMat,1);
    altOrder(rankVec) = numGrid;
    fprintf('BB> real: %i , comp: %i \n',sum(sum(triu(lossMat(altOrder,altOrder)))), kemDist);
    if isTimeBreak
        if nargout>2
            varargout{1} = flagBreak;
        end
    end
end

