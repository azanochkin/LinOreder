isEqConsid = true;
initDate = '2008/07/01';
%suffix = '1YNoAugNoWdr2008Init';
suffix = 'NscQrt';
sector = 'Bank';
resFile = 'Results\';
isRgh = false;
%[ timeVec,nscRankMat,iscRankMat,agName] = getData( initDate,suffix,sector);
%[timeVec,nscRankMat,iscRankMat,agName] = getNewData( initDate,suffix,sector,isRgh);
[timeVec,nscRankMat,iscRankMat,agName] = getNewData_qrt( initDate,suffix,sector,isRgh);
% нулевые измерения
iscRankMat = nan(size(nscRankMat));
maskExRatesVec = sum(~(isnan(nscRankMat)&isnan(iscRankMat)),2)>=1;
fprintf('-- > observations with 1 or greater ranks: %i\n',sum(maskExRatesVec));
nscRankMat = nscRankMat(maskExRatesVec,:);
iscRankMat = iscRankMat(maskExRatesVec,:);
timeVec = timeVec(maskExRatesVec);
%% using genetic
try
    filename = [resFile,'stats',initDate(1:4),suffix,sector,datestr(now,'dd_mm(HH-MM-SS)'),'.txt'];
    fileID = fopen(filename,'w+');
    if fileID == -1
        error('classification:fopen','cannot open file')
    end
    open(filename)
    %
    OptimFnc = @(lMat)genetic(lMat,100,100,30,800,0.1,fileID);
    consRankMat = taskShareSC(timeVec , nscRankMat, iscRankMat,...
        isEqConsid, OptimFnc);
    fclose(fileID);
catch err
    if ~(strcmp(err.identifier,'classification:fopen'))
        fclose(fileID);
    end
    rethrow(err);
end
%% best agency
consRankVec = srenumber(consRankMat(:,1));
% relMatrixArr = relationMatrix(timeVec, nscRankMat, iscRankMat, isEqConsid);
% indProxy = findProxy( relMatrixArr,agName);
indProxy = 7;
proxRankVec = nscRankMat(:,indProxy);
isNanProxVec = ~isnan(proxRankVec);
kemRankVec = classify1(consRankVec,consRankVec(isNanProxVec),proxRankVec(isNanProxVec),true);
%kemRankVec = roundRifling(proxRankVec , consRankVec );
%consRankVec = rifling( nscRankMat(:,indProxy), consRankVec );
plot(consRankVec,kemRankVec,'+')
plot(consRankVec(isNanProxVec),proxRankVec(isNanProxVec),'^g')
%% save results
quantiles = [0.5 0.4 0.3 0.2 0.1];
[medianKemMat, quantArr ,medianNumCell] = getStats(nscRankMat, kemRankVec, quantiles );
%%
load('agGradeName.mat')
filename = [resFile,'result',sector,suffix,initDate(1:4),agName{indProxy},'.xls'];
[medianKemCell,quantCell,medianCell] = ...
    convertStat(medianKemMat,quantArr,medianNumCell,agGradeName);
dict = agGradeName{indProxy};
% for j=1:10
%             dict{j} = num2str(j);
%         end
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