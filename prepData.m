dateBegin = '2011/07/01';
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
lossMat = lossMatrixLin(subArr);
rankVecSH = schulze2(lossMat);
getPenalty(rankVecSH,lossMat)
%% bestInsertion
lossMat = lossMatrixLin(subArr);
tic
rankVecBI = insertionRnd(bestInsertion(lossMat),lossMat);
toc
%% Memetic
lossMat = lossMatrixLin(subArr);
tic
rankVecMA = memetic(lossMat);
toc
%%  ChanKoby
lossMat = lossMatrixLin(subArr);
tic
rankVecCK = ChanKoby(bestInsertion(lossMat), lossMat, @insertion, 10);
toc
%% Multistart
lossMat = lossMatrixLin(subArr);
tic
[rankVecMS,kemDistVecI] = multistart(@(lMat)insertion(bestInsertion(lMat),lMat),...
                                lossMat, 10);
toc
%
[~,ind] = sort(kemDistVecI);
array2table([subArr,rankVecMS(:,ind)]);
%% best Insertion with sort NaNs_ old
[ans,ind] = sort(sum(~isnan(subArr),2));
[NE,E] = lossMatrixLin(subArr(ind,:));
rankVecBI2 = heuristAlgrthmLin2(NE, E , 100);
getPenalty(rankVecBI2,NE,E)
rankVecBI2(ind) = rankVecBI2;
[~,ind] = sort(rankVecBI2);
ans = [subArr,rankVecBI2];
array2table(ans(ind,:));

        