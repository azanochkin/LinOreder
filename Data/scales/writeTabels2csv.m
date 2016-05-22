load('scales.mat')
agNames = {'MDS','SPI','FCH','EXP','NRA','RUS','AKM'};
for i = 1:length(agNames)
    tblName = strcat('scales_',agNames{i},'_Nsc');
    fileName = strcat(tblName,'.csv');
    tbl = eval(tblName);
    writetable(tbl,fileName,'Delimiter',';');
end
