function scales = getScales( agNames )
%GETSCALES Summary of this function goes here
%   Detailed explanation goes here
scales = [];
for i = 1:length(agNames)
    tblName = strcat(agNames{i},'_Nsc');
    fileName = strcat('scales_',tblName,'.csv');
    tbl = readtable(fileName,'Delimiter',';','readRowNames',false);
    scales = setfield(scales,tblName,tbl);
end
end

