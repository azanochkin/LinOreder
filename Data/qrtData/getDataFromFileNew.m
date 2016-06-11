function data = getDataFromFileNew(fileName)
    dataTbl = readtable(fileName,'ReadVariableNames',true);
    varNameCVec = dataTbl.Properties.VariableNames;
    
    RankTab=dataTbl(:,~ismember(varNameCVec,{'date','ent_id','entity','sector'})); % Edit if necessary

    nAltern = height(RankTab);
    nVariab = width(RankTab);
    
    agNamesParse={};
    scNamesParse={};
    for i = 1:nVariab
        agNamesParse{1,i}=varNameCVec{1,i}(1:3);
        scNamesParse{1,i}=varNameCVec{1,i}(end-2:end);
    end
     
    [agNamesUn,~,agUnPlace]=unique(agNamesParse);
    [scNamesUn,~,scUnPlace]=unique(scNamesParse);
    nAgenc = length(agNamesUn);
    nScal  = length(scNamesUn);
    
    RankNameMat=zeros(length(scNamesUn),length(agNamesUn));
    for i=1:nVariab
        RankNameMat(scUnPlace(i),agUnPlace(i))=1;
    end
    
    RankNameTab=array2table(RankNameMat);
    RankNameTab.Properties.VariableNames=agNamesUn;
    RankNameTab.Properties.RowNames=scNamesUn;

% Form output structure
    %Agency and scale fields
    data.agNamesVec=agNamesUn;
    data.scNamesVec=scNamesUn;
    data.ratNamesTab=RankNameTab;

    %Rating fields
    for i=1:nScal
        X=nan(nAltern,nAgenc);
        SubRankTab=RankTab(:,scUnPlace==i);
        [~,SortInd]=sort(agUnPlace(scUnPlace==i));
        X(:,logical(RankNameMat(i,:)))=table2array(SubRankTab(:,SortInd));
        eval(['data.',scNamesUn{i},'RankMat=X;'])
    end
    
    data.scAggrId = 1;    
    
    %Date fields
    data.dateVec = datenum(dataTbl{:,'date'}, 'dd.mm.yyyy');
    
    %Entity fields
    if ismember('entity',varNameCVec)
    data.entNames=unique(dataTbl(:,{'ent_id','entity'}),'rows');
    end
    data.entIdVec = dataTbl{:,'ent_id'};
    
    %Classificator fields
    if ismember('sector',varNameCVec)
    data.classNames=unique(dataTbl{:,'sector'});
    data.ClassVec = dataTbl{:,'sector'};
    end
    
end