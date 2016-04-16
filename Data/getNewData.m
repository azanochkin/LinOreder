function [ timeVec,nscRankMat,iscRankMat,agName] = getNewData( initDate,suffix,sector,isRgh)
%GETDATA Summary of this function goes here
%   Detailed explanation goes here
    load('SnapBanks_11042016.mat')
    switch sector
        case 'Bank'
            mainTable = rat_mat_banks;
        otherwise
            error('Have no Corp Data')
    end
    if isRgh
        nameAgVec = {'MDS','MDS','SPC','SPC','FCH','FCH','EXP','NRA','RUS','RUS','AKM'};
        for i=1:11
            maskVec = ~isnan(mainTable{:,i});
            dictVec = eval(['scales_',nameAgVec{i},'_Nsc(:,3)']);
            mainTable(maskVec,i) = dictVec(mainTable{maskVec,i}+1,1);
        end
    end
    maskDate = (mainTable.date>=datenum(initDate,'yyyy/mm/dd'));
    nscRankMat = mainTable{maskDate,[2 4 5 7 8 10 11]};
    iscRankMat = nan(size(nscRankMat));
    iscRankMat(:,[1 2 3 6]) = mainTable{maskDate,[1 3 6 9]};
    agName = mainTable.Properties.VariableNames([2 4 6 7 8 10 11]);
    timeVec = mainTable{maskDate,'date'};
end

