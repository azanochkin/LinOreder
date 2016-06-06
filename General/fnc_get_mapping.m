function [ret,sett]=fnc_get_mapping(joint_dist_results,...
                             mapping_approach,...
                             group_start,...
                             quantile)
% fnc_get_mapping строит таблицу сопоставления рейтинговых шкал по данным таблиц совметсного
% распределение рейтингов агентств и категорий референтной шкалы.
%
% Входные данные
%   joint_dist_results - структура с таблицами распределения рейтингов.
%   mapping_approach - метод сопоставления; (1,2,3)={Median, Rev. Median, Conservative quantile}
%   group_start - пороговый грейд реф. шкалы, после которого все наблюдения
%   объединяются;
%   quantile - квантиль, используемый в расчетах. Для mapping_approach=3,
%   значение по умолчанию 0.9. Иначе, значение по умолчанию 0.5.
   
% Проверка согласованности входных данных

if ~ismember(mapping_approach,[1:3])
    warning('Недопустимое значение mapping_approach. Приcвоено значение по умолчанию.')
    mapping_approach=3;
end

if quantile>1 || quantile<0 
    warning('Недопустимое значение mapping_approach. Приcвоено значение по умолчанию.')
    if mapping_approach==3
        quantile=0.9;
    else
        quantile=0.5;
    end
end

obs_min=10;

% Процедура 
   
for j=1:length(joint_dist_results)

    if isstruct(joint_dist_results)   
        str=joint_dist_results;
    else
        str=joint_dist_results{1,j};
    end
    
    res_num=str.res_num;
    if ~ismember(group_start,[1:size(res_num(2:end-1,1),1)-1])
        warning(['Недопустимое значение group_start для шкалы ',str.ref_scale_type,' агентства ',...
            str.ref_agency,'. Приcвоено значение по умолчанию.'])
        group_start=size(res_num(2:end-1,1),1);
    end
    mat=cell2mat(res_num(2:end-1,3:end-1));
    mat=[mat(1:group_start-1,:);sum(mat(group_start:end,:),1)];
    headers=res_num(1,3:end-1);

    z=cell(size(mat,1),1);

    if j==1
        ret=res_num(1:group_start+1,1:2);
        ret{end,2}=[ret{end,2},' и ниже'];       
    end

switch mapping_approach
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    case 1 % Median

row_cnt=sum(mat,2);
for i=1:length(row_cnt)
    if row_cnt(i)>obs_min
       mat(i,:)= mat(i,:)/row_cnt(i);
       mat(i,:)=cumsum(mat(i,:));   
       ind=mat(i,:)>=quantile;   
       z{i,1}=headers{find(ind,1)};
    else
        z{i,1}='UnDef';
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
     case 2  % Rev Median

    clm_cnt=sum(mat,1);
   for i=1:length(clm_cnt)
        if clm_cnt(i)>obs_min
           mat(:,i)= mat(:,i)/clm_cnt(i);
           mat(:,i)=cumsum(mat(:,i));   
           ind=mat(:,i)>=quantile;
           
           if isempty(z{find(ind,1),1})
           z{find(ind,1),1}=headers{i};
           else
           z{find(ind,1),1}=[z{find(ind,1),1},';',headers{i}];    
           end
        end
    end
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    case 3 % Conservative quantile
    
    row_cnt=sum(mat,1);
    for n=1:length(row_cnt)
        if row_cnt(n)>obs_min
            mat(:,n)= mat(:,n)/row_cnt(n);
            mat(:,n)=cumsum(mat(:,n)); 
        else
            mat(:,n)=zeros(size(mat(:,n)));    
        end
    end
    
    nemp_ind=~all(mat==0);
    mat_nemp=mat(:,nemp_ind);
    headers_nemp=headers(nemp_ind);
    headers_emp=headers(~nemp_ind);
    
    ind=[];
    for i=1:size(mat_nemp,1)-1
           ind(i,1)=0;
           while ind(i,1)+1<=size(mat_nemp,2) && mat_nemp(i,ind(i,1)+1)>=quantile
           ind(i,1)=ind(i,1)+1;
           end
           
           if ind(i,1)~=0
           ind(i,2)=find(strcmp(headers,headers_nemp{ind(i,1)}));    
           if isempty(z{i,1})
           z{i,1}=headers_nemp{ind(i,1)};
           else
           z{i,1}=[z{i,1},';',headers_nemp{ind(i,1)}];    
           end
           end
    end
    
    insrt=1:1:length(headers);
    insrt=insrt(~ismember(insrt,ind(:,2))); 
    mapped=unique(ind(ind(:,2)~=0,2));
    num_emp=find(nemp_ind);
    num_nemp=find(~nemp_ind);
     
     for i=0:length(insrt)-1
        huy=mapped(find(mapped>insrt(end-i),1));
        if isempty(huy)
           if isempty(z{end,1})
           z{end,1}=headers{insrt(end-i)};
           else
            z{end,1}=[headers{insrt(end-i)},';',z{end,1}];    
           end 
        else
         z{find(ind(:,2)==huy,1),1}=[headers{insrt(end-i)},';',z{find(ind(:,2)==huy,1),1}];    
        end
     end
end
ret(:,end+1)=[str.mapped_agency;z];

sett.mapping_approach=mapping_approach;
sett.group_start=group_start;
sett.quantile=quantile;
end