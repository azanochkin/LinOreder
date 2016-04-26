load('ToMaratReg.mat')
scatterRanks(consRegRankMat(:,1:2));
xlabel('Оптимальная медиана')
ylabel('Около-оптимальная медиана')
%%
scatterRanks(consRegRankMat(:,[1,3]));
xlabel('Оптимальная медиана')
ylabel('Неоптимальная медиана')
