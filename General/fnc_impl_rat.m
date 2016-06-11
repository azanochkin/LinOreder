function [ret,sett]=fnc_impl_rat(data_structure,...
                                 ref_agency_id,...
                                 ref_scale_type,...
                                 sc_aggr_type,...
                                 method_type)

% fnc_impl_rat ��������� �� ������������ �������� ���. ����� 
% � �������� ��������� ����� ���. ���������. ��������� ����� ���������������� ��� ���������� implied
% ��������� ���. �������� - ������ �������� �������. 
%
% ������� ������:
%   - data_structure - ����������� ��������� � ����� III � ������� � ��������� � ������������ ���������. 
%   - ref_agency_id  - ������������� ��� ��������, ���������� � �������� ������������.
%   - ref_scale_type - ������������� ��� ���� �����: {Isc-���, Nsc-���}.
%   - method_type - ��� ������ ������������� ���������� "���� ����������������". 
%       1 - ������������ ������������ ������������ ������ � ���������� (������� - classify1);
%       2 - ������������ � ����� ����������� ��������� (������������ - classifyl)
%       3 - ������������ � ����� ����������� ��������� (������������� - classifyu)

   sett.ref_agency=ref_agency_id;
   sett.ref_scale_type=ref_scale_type;
   sett.classify_method=method_type;

% �������� ��������������� ������� ������
    if ~isstruct(data_structure)
        error('data_structure �� �������� ����������.')
    end
   
    if ~ismember(data_structure.agNamesVec,ref_agency_id)
       error(['� agNamesVec ��������� data_structure ����������� ���������� �� ��������� ',ref_agency_id,'.'])
    end
   
    ind=ismember(data_structure.agNamesVec,ref_agency_id);
    
    try
    eval(['rr=data_structure.',ref_scale_type,'RankMat(:,ind);']); 
    catch
        error(['� data_structure ���������� ������� ��������� ��� ����� ',ref_scale_type,'.'])
    end
    
    if  all(isnan(rr))
        error(['��� ����������� ��������� ',ref_agency_id,' � ����� ',ref_scale_type,'.']);
    end
    
    % ���������  
    
    rr=fnc_rescale_rat(data_structure,...
                       ref_agency_id,...
                       ref_scale_type,...
                       sc_aggr_type);
    
   r_ind=~isnan(rr);
     
   switch method_type
       case 1
   ret=classify1(data_structure.consRanking,data_structure.consRanking(r_ind),rr(r_ind),false);
       case 2
   ret=classifyl(data_structure.consRanking,data_structure.consRanking(r_ind),rr(r_ind),false);
       case 3
   ret=classifyu(data_structure.consRanking,data_structure.consRanking(r_ind),rr(r_ind),false);
  
   otherwise
       error('������������ ����� �������������.')
   end


   
   
