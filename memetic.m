function [ newRankVec, kemenyDist ]  = memetic( lossMat )
%MEMETIC Summary of this function goes here
%   Detailed explanation goes here
    nAltern = size(lossMat,1);
    nPopulation = 30;
    nCrossover = 30;
    nMutation = 10;
    nPerMut = round(0.05*nAltern);
    nIter = 50;
    %
    popRankMat = zeros(nAltern,nPopulation);
    popKemDistVec = zeros(1,nPopulation);
    for j = 1:nPopulation
        perm = randperm(nAltern);
        [rankVec,popKemDistVec(j)] = bestInsertion(lossMat(perm,perm));
        popRankMat(perm,j) = rankVec;
    end
    %
    offspRankMat = zeros(nAltern,nCrossover+nMutation);
    offspKemDistVec = zeros(1,nCrossover+nMutation);
    for j = 1:nIter
        fprintf('---> step %i \n',j)
        for i = 1:nCrossover
            ind1 = randi(nPopulation);
            ind2 = randi(nPopulation);%????
            mask = rand(nAltern,1) > 0.5;
            offspRankVec = popRankMat(:,ind1);
            offspRankVec(mask) = popRankMat(mask,ind2);
            [offspRankMat(:,i),offspKemDistVec(i)] = insertion(offspRankVec,lossMat);
        end
        for i = 1:nMutation
            ind = randi(nPopulation);
            mutRankVec = popRankMat(:,ind);
            for k = 1:nPerMut
                ind1 = randi(nAltern);
                ind2 = randi(nAltern);
                p = mutRankVec(ind1);
                mutRankVec(ind1) = mutRankVec(ind2);
                mutRankVec(ind2) = p;
            end
            ind = i+nCrossover;
            [offspRankMat(:,ind),offspKemDistVec(ind)] = insertion(mutRankVec,lossMat);
        end      
        [~,ind] = sort([popKemDistVec, offspKemDistVec]);
        ind = ind(1:nPopulation);
        mask = ind <= nPopulation;
        popRankMat(:,mask) = popRankMat(:,ind(mask));
        popKemDistVec(mask) = popKemDistVec(ind(mask));
        popRankMat(:,~mask) = offspRankMat(:,ind(~mask) - nPopulation);
        popKemDistVec(~mask) = offspKemDistVec(ind(~mask) - nPopulation);
        % plotting
        hold on
        %color = [0 1-j/nIter j/nIter];
        x = 2*(j-1)/(nIter-1);
        color = [max(0,1-x),(1-abs(x-1)),max(0,x-1)];
        plot(sort(popKemDistVec),'-+','color',color);
    end
    %newRankVec = popRankMat(:,1);
    newRankVec = popRankMat;
    %kemenyDist = popKemDistVec(1);
    kemenyDist = popKemDistVec;
    realPenalty = getPenalty(newRankVec(:,1),lossMat);
    fprintf('MEMETIC> real: %i , comp: %i \n',realPenalty, kemenyDist(1));            
end

