isEqConsid = false;
initDate = '2012/07/01';
suffix = '1YNoAugNoWdr2008Init';
sector = 'Bank';
folder = 'Data\';
statFile = 'Stats\stats';
switch sector
    case 'Union'
            bankTable = readtable([folder,'Bank',suffix,'.csv'],'delimiter',';');
            corpTable = readtable([folder,'Corp',suffix,'.csv'],'delimiter',';');
            corpTable.Properties.VariableNames = bankTable.Properties.VariableNames; 
            mainTable = vertcat(bankTable,corpTable);
    otherwise
            mainTable = readtable([folder,sector,suffix,'.csv'],'delimiter',';');
end
maskDate = (mainTable.date>=datenum(initDate,'yyyy/mm/dd'));
nscRankMat = mainTable{maskDate,[5 7 9 10 11 13 14]};
iscRankMat = nan(size(nscRankMat));
%iscRankMat(:,[1 2 3 6]) = mainTable{maskDate,[4 6 8 12]};
agName = mainTable.Properties.VariableNames([5 7 9 10 11 13 14]);
timeVec = mainTable{maskDate,1};
% ������� ���������
maskExRatesVec = sum(~(isnan(nscRankMat)&isnan(iscRankMat)),2)>=1;
nscRankMat = nscRankMat(maskExRatesVec,:);
iscRankMat = iscRankMat(maskExRatesVec,:);
timeVec = timeVec(maskExRatesVec);
%% using genetic
try
    filename = [statFile,initDate(1:4),suffix,sector,datestr(now,'(HH-MM-SS)dd_mm'),'.txt'];
    fileID = fopen(filename,'w+');
    if fileID == -1
        error('classification:fopen','cannot open file')
    end
    open(filename)
    %
    OptimFnc = @(lMat)genetic(lMat,60,40,15,0.1,fileID);
    consRankVec = taskShareSC(timeVec , nscRankMat, iscRankMat,...
        isEqConsid, OptimFnc);
catch err
    if ~(strcmp(err.identifier,'classification:fopen'))
        fclose(fileID);
    end
    rethrow(err);
end
%% best agency
relMatrixArr = relationMatrix(timeVec, nscRankMat, iscRankMat, isEqConsid);
indProxy = findProxy( relMatrixArr,agName);
proxRankVec = nscRankMat(:,indProxy);
kemRankVec = roundRifling(proxRankVec , consRankVec );
%consRankVec = rifling( nscRankMat(:,indProxy), consRankVec );
%[mainTable(maskDate,:), array2table(kemRankVec)];
plot(consRankVec,kemRankVec,'+')
pMask = ~isnan(proxRankVec);
plot(consRankVec(pMask),proxRankVec(pMask),'^g')
%% save results
quantiles = [0.5 0.4 0.3 0.2 0.1];
[medianKemMat, quantArr ,medianNumCell] = getStats(nscRankMat, kemRankVec, quantiles );
%%
load('agGradeName.mat')
filename = ['result',sector,suffix,initDate(1:4),'.xls'];
[medianKemCell,quantCell,medianCell] = ...
    convertStat(medianKemMat,quantArr,medianNumCell,agGradeName);
dict = agGradeName{indProxy};
proxyGrades = dict(1+unique(kemRankVec));
%
qNames = cell(size(quantiles));
for k = 1:length(quantiles)
    qNames{k} = ['Quan_',num2str(100*quantiles(k)),'pr'];
end
%
for i = 1:length(agGradeName)
    tbl = cell2table(quantCell(:,:,i));
    tbl = [medianKemCell(:,i) tbl];
    tbl = [medianCell(:,i) tbl];   
    tbl.Properties.VariableNames = ['Median_ag' 'Median_Cons' qNames];
    %
    tbl.Properties.RowNames = proxyGrades;
    writetable(tbl,filename,'Sheet',agName{i},'WriteRowNames',true);
end
tbl = cell2table(medianCell);
tbl.Properties.RowNames = proxyGrades;
tbl.Properties.VariableNames = agName;
writetable(tbl,filename,'Sheet','Median_ag','WriteRowNames',true);