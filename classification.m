dateBegin = '2011/07/01';
mainTable = readtable('Bank1YNoAugNoWdr2008Init.csv','delimiter',';');
maskDate = (mainTable.date>=datenum(dateBegin,'yyyy/mm/dd'));
nscRankMat = mainTable{maskDate,[5 7 9 10 11 13 14]};
iscRankMat = nan(size(nscRankMat));
iscRankMat(:,[1 2 3 6]) = mainTable{maskDate,[4 6 8 12]};
fprintf('-- > emitents with 2 or greater ranks: %i\n',size(nscRankMat,1));
%% memetic
lossMat = lossMatrixLin(nscRankMat);
nPopulation = 30;
[rankMatMA, penVecMA] = memetic(lossMat,nPopulation,30,10,0.1,5,50,10);
%% share
nPopulation = 40;
%rankMatMA = taskShareSC(mainTable{maskDate,1}, nscRankMat, iscRankMat, @(lMat)memetic(lMat,nPopulation,40,15,0.1,5,50,10));
rankMatMA = taskShare(initRankMat,@(lMat)memetic(lMat,nPopulation,40,15,0.1,5,50,10));
%%
indProxy = 1;
consRankVec = rifling( nscRankMat(:,indProxy), rankMatMA );
%array2table([nscRankMat consRankVec]);
[mainTable(maskDate,:), array2table(consRankVec)];
