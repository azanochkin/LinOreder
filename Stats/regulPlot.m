load('ToMaratReg.mat')
scatterRanks(consRegRankMat(:,1:2));
xlabel('����������� �������')
ylabel('�����-����������� �������')
%%
scatterRanks(consRegRankMat(:,[1,3]));
xlabel('����������� �������')
ylabel('������������� �������')
