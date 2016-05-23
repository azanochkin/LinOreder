%% Settings
% Add directories to path 
addpath(genpath(pwd))

% Starting date. Earlier data will be removed
initDate = '2008/07/01';

% Switch sector between 'Bank' and 'Corp'.
% sector = '�����';
sector = 'Банки';

% Directory for results
if ispc
    resFile = 'Results\';
elseif isunix
    resFile = './Results/';
end

% Flag set up the equivalence of issuers with the same ratings
isEqConsid = true;

% Cutting is performed on observations with more than two ratings
isObs2Vec = true;

% List of agencies
agNamesCVec = {'MDS','SP','FCH','EXP','NRA','RUS','AKM'};
% Reference agency
regAgName = 'MDS';
% Source file
fileName = 'dataFile_18042016.xls';
% Dictionary number:(1,2,3)
indVocab = 1;
%% Data preparation
data = getRankData( fileName, agNamesCVec, indVocab);
% Reject international scale
data.iscRankMat = nan(size(data.iscRankMat));
% Reject another sector
isSectorVec = strcmpi(sector,data.sectorCVec);
% Reject earlier data
isDateVec = data.dateVec>=datenum(initDate,'yyyy/mm/dd');
% At least two observations
isObsVec = sum(~(isnan(data.nscRankMat)&isnan(data.iscRankMat)),2)>=1;
% Observations satisfying all features
isAppropVec = isSectorVec & isDateVec & isObsVec;
fprintf('-- > appropriate observations : %i\n',sum(isAppropVec));
% Useful observations
nscNormVec = data.normRankVec;
nscRankMat = data.nscRankMat(isAppropVec,:);
iscRankMat = data.iscRankMat(isAppropVec,:);
timeVec = data.dateVec(isAppropVec);
%% Building consensus rankings
nGeneticIter = 10;
try
    logFileName = [resFile,'stats',initDate(1:4),sector,datestr(now,'dd_mm(HH-MM-SS)'),'.txt'];
    fileID = fopen(logFileName,'w+');
    if fileID == -1
        error('classification:fopen','cannot open file')
    end
    open(logFileName)
    OptimFnc = @(lMat)genetic(lMat,100,100,30,nGeneticIter,0.1,fileID);
    normNscRankMat =  nscRankMat./repmat(nscNormVec(:)',size(nscRankMat,1),1);
    consRankMat = taskShareSC(timeVec , normNscRankMat , iscRankMat,...
        isEqConsid, OptimFnc);
    fclose(fileID);
catch err
    if ~(strcmp(err.identifier,'classification:fopen'))
        fclose(fileID);
    end
    rethrow(err);
end
%%
consRankVec = nan(size(isAppropVec));
consRankVec(isAppropVec) = srenumber(consRankMat(:,1));
tbl = array2table([consRankVec, data.nscRankMat, data.dateVec, data.idVec]);
tbl.Properties.VariableNames = [{'consRank'}, agNamesCVec, {'date'}, {'ent_id'}];
writetable(tbl,strcat(resFile,'result.xls'));
%% Building a consensus rating on a reference agency
consRankVec = srenumber(consRankMat(:,1));
indProxy = find(strcmpi(regAgName,agNamesCVec));
proxRankVec = nscRankMat(:,indProxy);
isNanProxVec = ~isnan(proxRankVec);
if isObs2Vec
    isMinRatVec = sum(~(isnan(nscRankMat)&isnan(iscRankMat)),2)>=2;
    isClassVec = isNanProxVec & isMinRatVec;
else
    isClassVec = isNanProxVec;
end
kemRankVec = classifyu(consRankVec,consRankVec(isClassVec),proxRankVec(isClassVec),false);
%% Save results
resMat = nan(length(isAppropVec),2);
resMat(isAppropVec,1) = consRankVec;
resMat(isAppropVec,2) = kemRankVec;
tbl = array2table(resMat,'VariableNames',{'consRank','rifConsRank'});
writetable(tbl,strcat(resFile,'consRank.csv'));
%% Save stats
quantiles = [0.5 0.4 0.3 0.2 0.1];
[medianKemMat, quantArr ,medianNumCell] = getStats(nscRankMat, kemRankVec, quantiles );
%
load('agGradeName.mat')
logFileName = [resFile,'result',sector,initDate(1:4),agNamesCVec{indProxy},'.xls'];
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
    writetable(tbl,logFileName,'Sheet',agNamesCVec{i},'WriteRowNames',true);
end
tbl = cell2table(medianCell);
tbl.Properties.RowNames = proxyGrades;
tbl.Properties.VariableNames = agNamesCVec;
writetable(tbl,logFileName,'Sheet','Median_ag','WriteRowNames',true);