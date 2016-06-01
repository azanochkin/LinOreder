function data = getDataFromFile(fileName)
    dataTbl = readtable(fileName,'ReadVariableNames',true);
    varNameCVec = dataTbl.Properties.VariableNames;
    nAltern = height(dataTbl);
    nVariab = width(dataTbl);

    isNscVec = false(1,nVariab);
    isIscVec = false(1,nVariab);
    agNamesCVec = {};
    
    for i = 1:nVariab
        varNameStr = varNameCVec{i};
        isNscVec(i) = strcmp(varNameStr(end-2:end),'Nsc');
        isIscVec(i) = strcmp(varNameStr(end-2:end),'Isc');
        if isNscVec(i) || isIscVec(i)
            agNamesCVec = [agNamesCVec, varNameStr(1:end-4)];
        end
    end
    
    agNamesCVec = unique(agNamesCVec);
    nAgenc = length(agNamesCVec);
    
    % pull Nsc and Isc rankings 
    iscRankMat = nan(nAltern,nAgenc);
    nscRankMat = nan(nAltern,nAgenc);
    
    rankNamesCVec = {};
    
    for i = 1:nAgenc
        agName = agNamesCVec{i};
        for j = 1:nVariab
            varNameStr = varNameCVec{j};
            if strcmp(agName,varNameStr(1:length(agName)))
                if isNscVec(j)
                    nscRankMat(:,i) = dataTbl{:,j};
                    rankNamesCVec = [rankNamesCVec, {strcat(agName, ' National')}];
                end
                if isIscVec(j)
                    iscRankMat(:,i) = dataTbl{:,j};
                    rankNamesCVec = [rankNamesCVec, {strcat(agName, ' International')}];
                end
            end
        end    
    end
    
    dateVec = datenum(dataTbl{:,'date'}, 'dd.mm.yyyy');
    idVec = dataTbl{:,'ent_id'};
    entityCVec = dataTbl{:,'entity'};
    sectorCVec = dataTbl{:,'sector'};
    data = struct('agNamesVec',{agNamesCVec},'rankNamesVec',{rankNamesCVec},...
              'IscRankMat',{iscRankMat},'NscRankMat',{nscRankMat},...   
              'dateVec',{dateVec},'idVec',{idVec},...
              'entityCVec',{entityCVec},'sectorCVec',{sectorCVec});
end