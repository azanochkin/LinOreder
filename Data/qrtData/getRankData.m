function data = getRankData( fileName, agNamesCVec, indVocab)
%GETRANKDATA Summary of this function goes here
%   Detailed explanation goes here
scales = getScales(agNamesCVec);
dataTbl = readtable(fileName,'ReadVariableNames',true);
varNameCVec = dataTbl.Properties.VariableNames;
nAltern = height(dataTbl);
nVariab = width(dataTbl);
nAgenc = length(agNamesCVec);
%
isNscVec = false(1,nVariab);
isIscVec = false(1,nVariab);
for i = 1:nVariab
    varNameStr = varNameCVec{i};
    isNscVec(i) = strcmp(varNameStr(end-2:end),'Nsc');
    isIscVec(i) = strcmp(varNameStr(end-2:end),'Isc');
end
%% pull Nsc and Isc rankings 
iscRankMat = nan(nAltern,nAgenc );
nscRankMat = nan(nAltern,nAgenc );
for i = 1:nAgenc
    agName = agNamesCVec{i};
    scTable = getfield(scales,strcat(agName,'_Nsc'));
    for j = 1:nVariab
        varNameStr = varNameCVec{j};
        if strcmp(agName,varNameStr(1:length(agName)))
            if isNscVec(j)
                nscRankMat(:,i) = convRank2Num(dataTbl{:,j}, scTable, indVocab );
            end
            if isIscVec(j)
                iscRankMat(:,i) = convRank2Num(dataTbl{:,j}, scTable, indVocab );
            end
        end
    end
end
%% accompanying data
normRankVec = getMaxScale( scales, indVocab );
dateVec = dataTbl{:,'date'};
idVec = dataTbl{:,'ent_id'};
entityCVec = dataTbl{:,'entity'};
sectorCVec = dataTbl{:,'sector'};
data = struct('iscRankMat',{iscRankMat},'nscRankMat',{nscRankMat},...
              'normRankVec',{normRankVec},'scales',scales,...
              'dateVec',{dateVec},'idVec',{idVec},...
              'entityCVec',{entityCVec},'sectorCVec',{sectorCVec});
end

