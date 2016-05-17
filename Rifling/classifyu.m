function classRange = classifyu( sampleRange,kemRange,bestAgRank,isPlotted )
    classRange = zeros(size(sampleRange));
    uniqRank = unique(bestAgRank);
    bounds = zeros(size(uniqRank));
    if isPlotted
        figure(3);
        hold on
        set(gca,'YGrid','on')
        set(gca,'YMinorGrid','on')
    end    
    for i = 2:length(uniqRank)
        ind0 = uniqRank(i-1);
        ind1 = uniqRank(i);
        kr0 = kemRange(bestAgRank<=ind0);
        kr1 = kemRange(bestAgRank>=ind1);
        un = union(kr0,kr1);
        un = un(:);
        %
        fun = zeros(size(un));
        [~,locb] = ismember(kr1,un);
        for j = 1:length(locb)
            fun(locb(j)) = fun(locb(j)) - 1;%/length(kr1);%length(kr0)/length(kr1)^2;
        end
        [~,locb] = ismember(kr0,un);
        for j = 1:length(locb)
            fun(locb(j)) = fun(locb(j)) + 1;%/length(kr0);
        end
        %fun = abs(cumsum(fun));
        fun = cumsum(fun);
        fun = (ind1 - ind0)*fun/max((fun));
        
        ind = find(fun == max(fun),1,'first');
        bounds(i) = un(ind);
        classRange((bounds(i-1)<sampleRange)&(sampleRange<=bounds(i))) = ind0;
        
        if isPlotted
            X = [un un]';
            F = [[0; fun(1:end-1)] fun(1:end)]';
            plot(X(:),F(:)+ind0,'Color',[0 1-i/length(uniqRank) i/length(uniqRank)]);
            %
            [f1,x1] = ecdf(kr1);
            X = [x1(2:end) x1(2:end)]';
            F = [f1(1:end-1),f1(2:end)]';
            %plot(X(:),F(:)+ind0,'Color','r')
            [f0,x0] = ecdf(kr0);
            X = [x0(2:end) x0(2:end)]';
            F = [f0(1:end-1),f0(2:end)]';
            %plot(X(:),F(:)+ind0,'Color',[(i-1)/max(ic) 0 1-(i-1)/max(ic)])
            plot(bounds(i),ind0,'r*')
            plot([bounds(i) bounds(i)],[ind1 ind0],'k-.')
        end
    end
    classRange(sampleRange>=bounds(i)) = ind1;
end

