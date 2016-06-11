function [scales,dicStatus] = getScalesNew( RankNameTab )
%GETSCALES Summary of this function goes here
%   Detailed explanation goes here
scales = [];
agName=RankNameTab.Properties.VariableNames;
scName=RankNameTab.Properties.RowNames;
idMat=table2array(RankNameTab);
    
dicStatus=ones(size(idMat));

for i = 1:length(agName)
    for j=1:length(scName)
        if idMat(j,i)
            try
                fileName = strcat('scale_',agName{i},'_',scName{j},'.csv');
                tbl = readtable(fileName,'Delimiter',';','readRowNames',false);
                fieldName=strcat(agName{i},'_',scName{j});
                scales = setfield(scales,fieldName,tbl);
            catch
                fieldName=strcat(agName{i},'_',scName{j});
                warning(['Отсутствует словарь для шкалы ',fieldName,' .'])
                dicStatus (j,i)=-1;
            end
        else
           dicStatus (j,i)=0;
        end
    end
end

dicStatus=array2table(dicStatus);
dicStatus.Properties.VariableNames=agName;
dicStatus.Properties.RowNames=scName;
end