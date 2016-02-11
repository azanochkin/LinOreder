lossMat = lossMatrixLin(initRankMat);
nPopulation = 30;
[rankMatMA, penVecMA] = memetic(lossMat,nPopulation,30,10,0.1,5,50,10);
%rankMatMA = taskShare( initRankMat, @(lMat)memetic(lMat,nPopulation,30,10,0.1,5,20,7));
%%
nPopulation = 40;
rankMatMA = taskShare( initRankMat, @(lMat)memetic(lMat,nPopulation,40,15,0.1,5,50,10));
%%
indProxy = 1;
consRankVec = rifling( initRankMat(:,indProxy), rankMatMA );
array2table([initRankMat consRankVec]);
