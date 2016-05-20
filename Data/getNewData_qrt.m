function [ timeVec,nscRankMat,iscRankMat,normVec,agName] = getNewData_qrt( initDate,sector,isRgh, filename)
%GETDATA Summary of this function goes here
%   Detailed explanation goes here
    load(filename)
    switch sector
        case 'Bank'
            mainTable = rat_mat_bank_qrt;
        otherwise
            error('Have no Corp Data')
    end
    
    nameAgVec = {'MDS','MDS','SPC','SPC','FCH','FCH','EXP','NRA','RUS','RUS','AKM'};
    normVec = zeros(1,11);
    for i=1:11
        maskVec = ~isnan(mainTable{:,i});
        dictMat = eval(['scales_',nameAgVec{i},'_Nsc(:,2:3)']);
        if isRgh
            mainTable(maskVec,i) = dictMat(mainTable{maskVec,i}+1,2);
            normconst = max(dictMat{dictMat{:,2}<100,2});
        else
            normconst = max(dictMat{dictMat{:,1}<100,1});
        end
        normVec(i) = normconst;
    end
    maskDate = (mainTable.date>=datenum(initDate,'yyyy/mm/dd'));
    nscRankMat = mainTable{maskDate,[2 4 6 7 8 10 11]};
    iscRankMat = nan(size(nscRankMat));
    iscRankMat(:,[1 2 3 6]) = mainTable{maskDate,[1 3 5 9]};
    agName = mainTable.Properties.VariableNames([2 4 6 7 8 10 11]);
    timeVec = mainTable{maskDate,'date'};
    normVec = normVec([2 4 6 7 8 10 11]);
end
