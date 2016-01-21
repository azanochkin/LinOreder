dateBegin = '2014/07/01';
MainTable = rangeBankInit;
maskDate = (MainTable.date>=datenum(dateBegin,'yyyy/mm/dd'));
range = 5:11;
subArr = MainTable(maskDate,range);
maskMinRates = sum(~ismissing(subArr),2)>=2;
subArr = subArr{maskMinRates,:};
%
% sA = subArr;
% sA(isnan(sA)) = -1;
% [~,ia,~] = unique(sA,'rows');
% subArr = subArr(ia,:);
%
fprintf('-- > emitents with 2 or greater ranks: %i\n',size(subArr,1));
%% schulze
[NE,E] = lossMatrixLin(subArr);
rankVecSH = schulze(NE);
getPenalty(rankVecSH,NE,E)
%% best Insertion
[NE,E] = lossMatrixLin(subArr);
tic
%rankVecBI1 = multistart(@bestInsertionNew, NE, E , 0);
[rankVecBI1,kemDistVec] = multistart(@(n,e)insertion(bestInsertion2(n,e),n,e), NE, E , 1000);
toc
%getPenalty(rankVecBI1,NE,E)
[~,ind] = sort(rankVecBI1);
ans = [subArr,rankVecBI1];
array2table(ans(ind,:));
%% optimization
rankVecI = insertion(rankVecBI1, NE, E);
%getPenalty(rankVecI,NE,E)
[~,ind] = sort(rankVecI);
ans = [subArr,rankVecI];
array2table(ans(ind,:));
%% best Insertion with sort NaNs
[ans,ind] = sort(sum(~isnan(subArr),2));
[NE,E] = lossMatrixLin(subArr(ind,:));
rankVecBI2 = heuristAlgrthmLin2(NE, E , 100);
getPenalty(rankVecBI2,NE,E)
rankVecBI2(ind) = rankVecBI2;
[~,ind] = sort(rankVecBI2);
ans = [subArr,rankVecBI2];
array2table(ans(ind,:));

        