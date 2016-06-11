function results=fnc_get_joint_distrs(data_structure,...
                                      ref_ag_id,...
                                      ref_scale_type,...
                                      ref_sc_aggr_type,...
                                      mapped_ag_id,...
                                      mapped_scale_type,...
                                      mapped_sc_aggr_type,...  
                                      condition_flag,...
                                      ref_sc_method,...
                                      plot_flag)

% fnc_get_joint_distrs ������ ���������� ������������� ���������
% ��������������� �������� � ��������� ���. �����. ��������� ����������� �
% ���� ����������, ����������:
%   - ��������� ����������;
%   - ������� ����������� ������������� ��������� ��������������� �������� �
%     ��������� ���. ����� (��������� �������������)
%   - ������� ��������� ������������� ��������� ��������������� ��������� �
%     ��������� ���. �������� (��������� �������������)
%
%   ������� ������ 
% data_structure - ��������� � ������� �������, �� ������� �������� ���������;
% ref_ag_id - ������������� ��� ������������ ���������, {'MDS','SP','FCH','EXP','NRA','RUS','AKM'}
% ref_scale_type -  ������������� ��� ���� ����� ���. ���������: {Isc-���, Nsc-���}.
% ref_sc_aggr_type - ���� ������ ��������� ����� ������������ ��������, �������� ������� � ������� {1,2,3 � �.�.};
% mapped_ag_id - ������������� ��� ��������������� ���������, {'MDS','SP','FCH','EXP','NRA','RUS','AKM'}
% mapped_scale_type - ������������� ��� ���� ����� ��������������� ���������: {Isc-���, Nsc-���}.
% mapped_sc_aggr_type - ���� ������ ��������� ����� ��������������� ��������, �������� ������� � ������� {1,2,3, � �.�.};
% condition_flag [optional] - ������ ��� ���������� ��������� �������������.
%   0 - All observations.
%   1 - Observations rated by reference agency. If mapped agency is reference one then equivalent to "all observations".
%   2 - Observations rated by reference agency and any third agency.
%   3 - Observations rated only by reference agency and mapped agency.If mapped agency is reference one then equivalent to "observations rated only by mapped agency".
%   4 - Observations unrated by reference agency. If mapped agency is reference one then empty.
%   5 - Observations unrated by reference agency but rated by any third agency.If mapped agency is reference one then empty.
%   6 - Observations rated only by mapped agency. If mapped agency is reference one then empty.
%   7 - Observations rated by more then one agency.
% ref_sc_method [optional] - ��� ������ ������������� ���������� "���� ����������������": 
%       1 - ������������ ������������ ������������ ������ � ���������� (������� - classify1)
%       2 - ������������ � ����� ����������� ��������� (������������ - classifyl)
%       3 - ������������ � ����� ����������� ��������� (������������� - classifyu)
%plot_flag [optional] - ���� ������ ��������, {0,1}={���, ��};


% �������� ��������������� ������� ������
    if ~isstruct(data_structure)
        error('data_structure �� �������� ����������.')
    end
   
    if ~ismember(data_structure.agNamesVec,ref_ag_id)
       error(['� agNamesVec ��������� data_structure ����������� ���������� �� ��������� ',ref_ag_id,'.'])
    end
    rn=ref_ag_id;
    r_ind=ismember(data_structure.agNamesVec,rn);
    
    if ~ismember(data_structure.agNamesVec,mapped_ag_id)
       error(['� agNamesVec ��������� data_structure ����������� ���������� �� ��������� ',mapped_ag_id,'.'])
    end
    an=mapped_ag_id; 
    a_ind=ismember(data_structure.agNamesVec,an);
   
    try
    eval(['rr=data_structure.',ref_scale_type,'RankMat(:,r_ind);']); 
    catch
        error(['� data_structure ���������� ������� ��������� ��� ����� ',ref_scale_type,'.'])
    end 
    rs=ref_scale_type;     
    
    try
    eval(['arr=data_structure.',mapped_scale_type,'RankMat(:,a_ind);']); 
    catch
        error(['� data_structure ���������� ������� ��������� ��� ����� ',mapped_scale_type,'.'])
    end
    as=mapped_scale_type;
    
    if  all(isnan(rr))
        error(['��� ����������� ��������� ��������� ',rn,' � ����� ',rs,'.']);
    end
   
    if  all(isnan(arr))
        error(['��� ����������� ��������� ��������� ',an,' � ����� ',as,'.']);
    end
        
    eval(['r_dick=data_structure.scales.',rn,'_',rs,';']);
    if ~ismember(ref_sc_aggr_type,[1:width(r_dick)/2])  
           warning(['������������ �������� ref_sc_aggr_type. ���c����� �������� �� ���������. �������� �������� ',num2str(width(r_dick)/2),'.'])
           ref_sc_aggr_type=data_structure.scAggr4Cons;
    end
    rf=ref_sc_aggr_type; 
     
    eval(['a_dick=data_structure.scales.',an,'_',as,';']);
    
%     disp(mapped_sc_aggr_type);
%     disp([1:width(a_dick)/2]);
    
    if ~ismember(mapped_sc_aggr_type,[1:width(a_dick)/2])  
           warning(['������������ �������� mapped_sc_aggr_type. ���c����� �������� �� ���������. �������� �������� ',num2str(width(a_dick)/2),'.'])
           mapped_sc_aggr_type=data_structure.scAggr4Cons;
    end
    af=mapped_sc_aggr_type; 
    
display(['ref=',rn,', mapped=',an,'.'])
    
switch nargin
    case 7
    condition_flag=0;
    ref_sc_method=3;
    plot_flag=0; 
    case 8
    ref_sc_method=3;
    plot_flag=0;
    case 9
    plot_flag=0;
end

if ~ismember(condition_flag,[0:7])
    warning('������������ �������� condition_flag. ���c����� �������� �� ���������.')
    condition_flag=0;
end

if ~ismember(ref_sc_method,[1:3])
    warning('������������ �������� ref_sc_method. ���c����� �������� �� ���������.')
    ref_sc_method=3;
end
rm=ref_sc_method;

if ~ismember(plot_flag,[0:1])
    warning('������������ �������� plot_flag. ���c����� �������� �� ���������.')
    plot_flag=0;
end

% ���������    
tic

master=fnc_impl_rat(data_structure,rn,rs,rf,rm);
rr=fnc_rescale_rat(data_structure,rn,rs,rf);
arr=fnc_rescale_rat(data_structure,an,as,af);
 
r_scale=sortrows(unique(r_dick(1:end-2,2*rf-1:2*rf),'rows'),2);
a_scale=sortrows(unique(a_dick(1:end-2,2*rf-1:2*rf),'rows'),2);

rat_mat=[master,rr,arr,...
        data_structure.IscRankMat,...
        data_structure.NscRankMat];
rat_mat = sortrows(rat_mat(~isnan(master),:),1);
nn_rr_ind=~isnan(rat_mat(:,2));
nn_rat_ind=~isnan(rat_mat(:,4:end)); 
rat_mat=rat_mat(:,1:3);

dsply={'��� ����������.',...    
       '���������� ���������������� ����������� ����������. If reference agency is mapped agency then equivalent to all observations.',...
       'Observations rated by reference agency and some third agency.',...
       'Observations rated only by reference agency and mapped agency.If reference agency is mapped agency then equivalent to observations rated only by mapped agency.',...
       'Observations unrated by reference agency. If reference agency is mapped agency then empty.',...
       'Observations unrated by reference agency but rated some third agency.If reference agency is mapped agency then empty.',...
       'Observations rated only by mapped agency. If reference agency is mapped agency then empty.',...
       'Observations rated by more then one agency.'};

 ind_frame1=double(repmat(nn_rr_ind,1,size(nn_rat_ind,2)).*double(nn_rat_ind));
 ind_frame2=double(repmat(~nn_rr_ind,1,size(nn_rat_ind,2)).*double(nn_rat_ind));
   
   
switch condition_flag
    case 0
        obs_ind=true(size(rat_mat(:,1)));
    case 1
        obs_ind=nn_rr_ind;
    case 2
        if strcmp(rn,an)
        obs_ind=sum(ind_frame1,2)>1;
        else
        obs_ind=sum(ind_frame1,2)>2; 
        end 
    case 3
        if strcmp(rn,an)
        obs_ind=sum(ind_frame1,2)==1; 
        else
        obs_ind=sum(ind_frame1,2)==2;  
        end
    case 4
        obs_ind=~nn_rr_ind;
    case 5
        obs_ind=sum(ind_frame2,2)>1; 
    case 6
        obs_ind=sum(ind_frame2,2)==1;  
    case 7
        obs_ind=sum(ind_frame2,2)>1;      
end
rat_mat=rat_mat(obs_ind,:);
display(dsply{condition_flag+1})

mrat=rat_mat(:,1);
rrat=rat_mat(:,2);
arat=rat_mat(:,3);

a_sc_num=table2array(a_scale(:,2));
a_sc_txt=table2array(a_scale(:,1));

color={'r','b','g','m','c','k','y','r','b','g','m','c','k','y'};

%Tabling and ploting results

% I waste 2 hours to find it D:
% Never use it!
% close all

if plot_flag==1
figure
title({['�������������� ���������=',an,'; ������������� ������. �����=',num2str(af)],...
    ['���. ���������=',rn,'; ������������� ���. �����=',num2str(rf),';']},...
    'FontName','Arial')
    hold on
end

ind=[];
r_sc_num=table2array(r_scale(:,2));
r_sc_txt=table2array(r_scale(:,1));

tmp_mat=[];
tmp_mat2=[];

for i=1:length(r_sc_num)
    tmp_a=find(mrat==r_sc_num(i) & ~isnan(arat));
    tmp_b=arat(mrat==r_sc_num(i) & ~isnan(arat));
    tmp_c=arat(rrat==r_sc_num(i) & ~isnan(arat));
 
    if plot_flag==1
    if ~isempty(tmp_b)
        ind(i)=1;
        plot(tmp_a,tmp_b,'*')
    else
        ind(i)=0;
    end
    end
%     pause
%     
if size(histc(tmp_b,a_sc_num),2)<2
        tmp_mat=[tmp_mat;histc(tmp_b,a_sc_num)'];
      else
        tmp_mat=[tmp_mat;histc(tmp_b,a_sc_num)];
end

if i<length(r_sc_num)
    tmp_mat(end,end)=sum(mrat==r_sc_num(i) &...
                        arat==a_sc_num(end)&...
                        sum(nn_rat_ind(obs_ind,:),2)>1);
end

if size(histc(tmp_c,a_sc_num),2)<2
        tmp_mat2=[tmp_mat2;histc(tmp_c,a_sc_num)'];
      else
        tmp_mat2=[tmp_mat2;histc(tmp_c,a_sc_num)];
end

end

        if plot_flag==1
        % Ploting settings
        set(gca,'YTick',a_sc_num,'YTickLabel',a_sc_txt)
        set(gcf,'position',[600 250 1300 650])
        set(gcf,'PaperPositionMode','auto')
        legend(r_sc_txt(r_sc_num(logical(ind))+1),'location','best')
        xlabel('������������ �������','FontName','Arial');
        ylabel('����� ��������������� ���������','FontName','Arial');
        hold off
        pause
        end

tmp_mat_pr=tmp_mat./repmat(sum(tmp_mat),size(tmp_mat,1),1);
tmp_mat=[tmp_mat,sum(tmp_mat,2);sum(tmp_mat),sum(tmp_mat(:))];

tmp_mat2=[tmp_mat2,sum(tmp_mat2,2);sum(tmp_mat2),sum(tmp_mat2(:))];
tmp_mat2=[tmp_mat2, [histc(rrat,r_sc_num);sum(histc(rrat,r_sc_num))];...
         [histc(arat,a_sc_num)',sum(histc(arat,a_sc_num))],NaN];
tmp_mat_pr2=tmp_mat2(1:end-2,1:end-2)./repmat(tmp_mat2(end-1,1:end-2),size(tmp_mat2(1:end-2,1:end-2),1),1);
tmp_mat_pr2=[tmp_mat_pr2;tmp_mat2(end-1,1:end-2)./tmp_mat2(end,1:end-2)];

tmp_mat_cum=cumsum(tmp_mat_pr);
 
results.ref_agency=rn;
results.ref_scale_type=rs;
results.ref_scale_aggr=rf;
results.ref_scale=r_scale;
results.mapped_agency=an;
results.mapped_type=as;
results.mapped_scale_aggr=af;
results.mapped_scale=a_scale;
results.condition_flag=condition_flag;
results.ref_sc_method=ref_sc_method;

results.res_num=[{'��������� ���. ����� ','����� ���. ��������'},a_sc_txt',{'�����'};...
         [num2cell(r_sc_num+1);{''}],[r_sc_txt(r_sc_num+1);'�����'],num2cell(tmp_mat)];
     
results.res_init_num=[{'��������� ���. ����� ','����� ���. ��������'},a_sc_txt',{'����. ����������'},{'�����'};...
              [num2cell(r_sc_num+1);{''};{''}],[r_sc_txt(r_sc_num+1);{'����. ����������'};'�����'],num2cell(tmp_mat2)];
          
results.res_pr=[{'��������� ���. ����� ','����� ���. ��������'},a_sc_txt';...
             num2cell(r_sc_num+1),r_sc_txt(r_sc_num+1),num2cell(tmp_mat_pr*100)];
         
results.res_init_pr=[{'��������� ���. ����� ','����� ���. ��������'},a_sc_txt';...
                  [num2cell(r_sc_num+1);{''}],[r_sc_txt(r_sc_num+1);'������� ����. ����������'],num2cell(tmp_mat_pr2*100)];
              
results.res_pr_cum=[{'��������� ���. ����� ','����� ���. ��������'},a_sc_txt';...
             num2cell(r_sc_num+1),r_sc_txt(r_sc_num+1),num2cell(tmp_mat_cum*100)];
         
toc 
     
