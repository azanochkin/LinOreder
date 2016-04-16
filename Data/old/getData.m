function [ timeVec,nscRankMat,iscRankMat,agName] = getData( initDate,suffix,sector)
%GETDATA Summary of this function goes here
%   Detailed explanation goes here
    folder = 'Data\old\';
    switch sector
    case 'Union'
            bankTable = readtable([folder,'Bank',suffix,'.csv'],'delimiter',';');
            corpTable = readtable([folder,'Corp',suffix,'.csv'],'delimiter',';');
            corpTable.Properties.VariableNames = bankTable.Properties.VariableNames; 
            mainTable = vertcat(bankTable,corpTable);
    otherwise
            mainTable = readtable([folder,sector,suffix,'.csv'],'delimiter',';');
    end
    maskDate = (mainTable.date>=datenum(initDate,'yyyy/mm/dd'));
    nscRankMat = mainTable{maskDate,[5 7 9 10 11 13 14]};
    iscRankMat = nan(size(nscRankMat));
    iscRankMat(:,[1 2 3 6]) = mainTable{maskDate,[4 6 8 12]};
    agName = mainTable.Properties.VariableNames([5 7 9 10 11 13 14]);
    timeVec = mainTable{maskDate,1};
end

