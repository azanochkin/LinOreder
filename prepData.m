dateBegin = '2011/07/01';
MainTable = rangeBankInit;
maskDate = (MainTable.date>=datenum(dateBegin,'yyyy/mm/dd'));
range = 5:11;
initRankMat = MainTable(maskDate,range);
maskMinRates = sum(~ismissing(initRankMat),2)>=2;
initRankMat = initRankMat{maskMinRates,:};
%
% sA = subArr;
% sA(isnan(sA)) = -1;
% [~,ia,~] = unique(sA,'rows');
% subArr = subArr(ia,:);
%
fprintf('-- > emitents with 2 or greater ranks: %i\n',size(initRankMat,1));
%% schulze
lossMat = lossMatrixLin(initRankMat);
rankVecSH = schulze2(lossMat);
getPenalty(rankVecSH,lossMat)
%% bestInsertion
lossMat = lossMatrixLin(initRankMat);
tic
rankVecBI = insertionMy(bestInsertion(lossMat),lossMat);
%rankVecBI = bestInsertion1(lossMat);
toc
%% Memetic
lossMat = lossMatrixLin(initRankMat);
tic
[rankVecMA, penVecMA] = memetic(lossMat,30,30,10,0.1,5,30,20);
toc
%%  ChanKoby
lossMat = lossMatrixLin(initRankMat);
tic
rankVecCK = ChanKoby(bestInsertion(lossMat), lossMat, @insertion, 10);
toc
%% Multistart
lossMat = lossMatrixLin(initRankMat);
tic
[rankVecMS,kemDistVecI] = multistart(@(lMat)insertionMy(bestInsertion(lMat),lMat),...
                                lossMat, 100);
toc
%
[~,ind] = sort(kemDistVecI);
array2table([initRankMat,rankVecMS(:,ind)]);
%% best Insertion with sort NaNs_ old
[ans,ind] = sort(sum(~isnan(initRankMat),2));
[NE,E] = lossMatrixLin(initRankMat(ind,:));
rankVecBI2 = heuristAlgrthmLin2(NE, E , 100);
getPenalty(rankVecBI2,NE,E)
rankVecBI2(ind) = rankVecBI2;
[~,ind] = sort(rankVecBI2);
ans = [initRankMat,rankVecBI2];
array2table(ans(ind,:));

        