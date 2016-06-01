function [ret,sett]=fnc_rescale_rat(data_structure,...
                                    agency_id,...
                                    scale_type,...
                                    sc_aggr_type)
    
%SUMMARY goes here.
%
%

    sett.agency_id=agency_id;
    sett.sc_aggr=sc_aggr_type;
    
% �������� ��������������� ������� ������
    if ~isstruct(data_structure)
        error('data_structure �� �������� ����������.')
    end
   
    disp(data_structure.agNamesVec);
    
    if ~ismember(data_structure.agNamesVec,agency_id)
       error(['� agNamesVec ��������� data_structure ����������� ���������� �� ��������� ',agency_id,'.'])
    end
    
    ind=strcmp(data_structure.agNamesVec,agency_id);
    
    try 
       eval(['ret=data_structure.',scale_type,'RankMat(:,ind);']);
    catch
        error(['� data_structure ���������� ������� ��������� ��� ����� ',scale_type,'.'])
    end

    if all(isnan(ret))
       error(['��� ����������� ��������� ',agency_id,' � ����� ',scale_type,'.']);
    end
 
% ���������

    eval(['dick=data_structure.scales.',agency_id,'_',scale_type,';']);
    scAggrType=data_structure.scAggrType;
    
    if scAggrType~=sc_aggr_type
        for i=1:height(dick)
            ret(ret==table2array(dick(i,2*scAggrType)))...
                           = table2array(dick(i,2*sc_aggr_type));
        end

        if scAggrType>2 
             warning('������� ��������� ������ � ��������� �� �������� �������. ���������, ��� ������������� ������������ ���������.')
        end
    end
end