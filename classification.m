%% Входные параметры
initDate = '2008/07/01';
sector = 'Банки';
% директория для сохранения результатов
resFile = 'Results\';
% считаем ли наблюдения с одним рейтингом эквивалентными(лучше не трогать)
isEqConsid = true;
% нарезка осуществляется по наблюдениям с больше чем двумя рейтингами?
isObs2Vec = true;
% Список агентств(можно менять)
agNamesCVec = {'MDS','SP','FCH','EXP','NRA','RUS','AKM'};
% Референтное агентство
regAgName = 'MDS';
% файл с исходными данными
fileName = 'dataFile_18042016.xls';
% номер пары словарей
indVocab = 1;
%% Подготовка данных
data = getRankData( fileName, agNamesCVec, indVocab);
% Отбрасываем междунарожную шкалу
data.iscRankMat = nan(size(data.iscRankMat));
% Принадлежности к заданному сектору
isSectorVec = strcmpi(sector,data.sectorCVec);
% Принадлежность к временным ограничениям
isDateVec = data.dateVec>=datenum(initDate,'yyyy/mm/dd');
% Наличие не менее одного наблюдения
isObsVec = sum(~(isnan(data.nscRankMat)&isnan(data.iscRankMat)),2)>=1;
% Набор наблюдений, удовлетворяющих всем признакам
isAppropVec = isSectorVec & isDateVec & isObsVec;
fprintf('-- > appropriate observations : %i\n',sum(isAppropVec));
%%
nscNormVec = data.normRankVec;
nscRankMat = data.nscRankMat(isAppropVec,:);
iscRankMat = data.iscRankMat(isAppropVec,:);
timeVec = data.dateVec(isAppropVec);
%% Построение консенсусного ранжирования
try
    logFileName = [resFile,'stats',initDate(1:4),sector,datestr(now,'dd_mm(HH-MM-SS)'),'.txt'];
    fileID = fopen(logFileName,'w+');
    if fileID == -1
        error('classification:fopen','cannot open file')
    end
    %open(logFileName)
    %
    OptimFnc = @(lMat)genetic(lMat,100,100,30,5,0.1,fileID);
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
%% Построение консенсусного рейтинга по референтному агентству
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
%% запись резйльтатов
resMat = nan(length(isAppropVec),2);
resMat(isAppropVec,1) = consRankVec;
resMat(isAppropVec,2) = kemRankVec;
tbl = array2table(resMat);
tbl.Properties.VariableNames = [{'consRank'} {'rifConsRank'}];
writetable(tbl,strcat(resFile,'consRank.csv'));
%% save results
quantiles = [0.5 0.4 0.3 0.2 0.1];
[medianKemMat, quantArr ,medianNumCell] = getStats(nscRankMat, kemRankVec, quantiles );
%
load('agGradeName.mat')
logFileName = [resFile,'result',sector,initDate(1:4),agName{indProxy},'.xls'];
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
    writetable(tbl,logFileName,'Sheet',agName{i},'WriteRowNames',true);
end
tbl = cell2table(medianCell);
tbl.Properties.RowNames = proxyGrades;
tbl.Properties.VariableNames = agName;
writetable(tbl,logFileName,'Sheet','Median_ag','WriteRowNames',true);