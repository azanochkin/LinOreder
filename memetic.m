function [ newRankVec, kemenyDist ]  = memetic( lossMat, nPopulation,...
        nCrossover, nMutation, alphaMut, nMinDiff, nIterMain, nIterPost)
    function mask = fndUnique(rankMat)
        n = size(rankMat,2);
        mask = true(1,n);
        for ii = 1:n
            if mask(ii)
                for jj = ii+1:n
                    if mask(jj)
                        mask(jj) = any(rankMat(:,ii) ~= rankMat(:,jj));
                    end
                end
            end
        end
    end
    function [newKemDistVec, newRankMat, nDiff] = getBest(kemDistVec, rankMat, nBest)
        maskUniq = fndUnique(rankMat);
        newKemDistVec = kemDistVec(maskUniq);
        newRankMat = rankMat(:,maskUniq);
        %
        [~,indSort] = sort(newKemDistVec);
        indSort = indSort(1:nBest);
        newKemDistVec = newKemDistVec(indSort);
        newRankMat = newRankMat(:,indSort);
        %
        nDiff = size(setdiff(indSort,1:nBest));
    end
    function [kemDistVec, rankMat] = diversify(nAltern,nPopulation,lossMat)
        rankMat = zeros(nAltern,nPopulation);
        kemDistVec = zeros(1,nPopulation);
        for jj = 1:nPopulation
            perm = randperm(nAltern);
            [rankVec,kemDistVec(jj)] = bestInsertion(lossMat(perm,perm),false);
            rankMat(perm,jj) = rankVec;
        end
    end
    function [ newRankVec, kemenyDist ] = main(popKemDistVec, popRankMat,...
            lossMat, nPopulation, nCrossover, nMutation, alphaMut,...
            nMinDiff, nIter)
        nAltern = size(lossMat,1);
        nPerMut = round(alphaMut*nAltern);
        newRankVec = [];
        kemenyDist = [];
        offspRankMat = zeros(nAltern,nCrossover);
        offspKemDistVec = zeros(1,nCrossover);
        mutatRankMat = zeros(nAltern,nMutation);
        mutatKemDistVec = zeros(1,nMutation);
        for j = 1:nIter
            fprintf('---> step %i \n',j)
            parfor i = 1:nCrossover
                ind1 = randi(nPopulation);
                ind2 = randi(nPopulation);%????
                mask = rand(nAltern,1) > 0.5;
                offspRankVec = popRankMat(:,ind1);
                offspRankVec(mask) = popRankMat(mask,ind2);
                [offspRankMat(:,i),offspKemDistVec(i)] = insertionMy(offspRankVec,lossMat);
            end
            parfor i = 1:nMutation
                ind = randi(nPopulation);
                mutRankVec = popRankMat(:,ind);
                for k = 1:nPerMut
                    ind1 = randi(nAltern);
                    ind2 = randi(nAltern);%????
                    p = mutRankVec(ind1);
                    mutRankVec(ind1) = mutRankVec(ind2);
                    mutRankVec(ind2) = p;
                end
                [mutatRankMat(:,i),mutatKemDistVec(i)] = insertionMy(mutRankVec,lossMat);
            end      
            unKemDistVec = [popKemDistVec, offspKemDistVec, mutatKemDistVec];
            unRankMat = [popRankMat, offspRankMat, mutatRankMat];
            [popKemDistVec, popRankMat, nDiff] = getBest(unKemDistVec, unRankMat, nPopulation);
            if nDiff < nMinDiff
                fprintf('====== diversification ======\n');
                [kemenyDist, newRankVec, ~] = getBest([kemenyDist, popKemDistVec],[newRankVec, popRankMat], nPopulation);
                [popKemDistVec(2:end), popRankMat(:,2:end)] = diversify(nAltern,nPopulation-1,lossMat);
            end
            % plotting
    %         hold on
    %         x = 2*(j-1)/(nIter-1);
    %         color = [max(0,1-x),(1-abs(x-1)),max(0,x-1)];
    %         plot(sort(popKemDistVec),'-+','color',color);
            % stats
            fprintf('------- best:')
            fprintf('   %i',popKemDistVec(1:5))
            fprintf('\n------- med :   %i\n', round(median(popKemDistVec)))
        end
        [kemenyDist, newRankVec, ~] = getBest([kemenyDist, popKemDistVec],[newRankVec, popRankMat], nPopulation);
    end
    %
    [popKemDistVec, popRankMat] = diversify(size(lossMat,1),nPopulation,lossMat);
    %
    [ newRankVec, kemenyDist ] = main(popKemDistVec, popRankMat,...
            lossMat, nPopulation, nCrossover, nMutation, alphaMut,...
            nMinDiff, nIterMain);
    [ newRankVec, kemenyDist ] = main(kemenyDist, newRankVec,...
            lossMat, nPopulation, nCrossover, nMutation, 0.05,...
            0, nIterPost);    
    
%     realPenalty = getPenalty(newRankVec(:,1),lossMat);
%     fprintf('MEMETIC> real: %i , comp: %i \n',realPenalty, kemenyDist(1));            
end

