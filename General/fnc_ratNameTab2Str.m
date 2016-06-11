function nameVec=fnc_ratNameTab2Str(Tab)

nVar=width(Tab);
nRow=height(Tab);

VarName=Tab.Properties.VariableNames;
RowName=Tab.Properties.RowNames;

nameVec={};
for i=1:nRow
   for j=1:nVar
       if Tab{i,j}==1
           nameVec{1,nVar*(i-1)+j}=strcat(VarName{j},'_',RowName{i});
       else
           nameVec{1,nVar*(i-1)+j}='ZZZ';
       end 
   end
end
nameVec=nameVec(1,~strcmp(nameVec,'ZZZ'));

end