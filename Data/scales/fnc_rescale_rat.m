function [ret,sett]=fnc_rescale_rat(data_structure,...
                                    agency_id,...
                                    scale_type,...
                                    sc_aggr_type)
    
%SUMMARY goes here.
%
%

    sett.agency_id=agency_id;
    sett.sc_aggr=sc_aggr_type;
    
% Проверка согласованности входных данных
    if ~isstruct(data_structure)
        error('data_structure не является структурой.')
    end
   
    disp(data_structure.agNamesVec);
    
    if ~ismember(data_structure.agNamesVec,agency_id)
       error(['В agNamesVec структуры data_structure отсутствует информация об агентстве ',agency_id,'.'])
    end
    
    ind=strcmp(data_structure.agNamesVec,agency_id);
    
    try 
       eval(['ret=data_structure.',scale_type,'RankMat(:,ind);']);
    catch
        error(['В data_structure отсутсвует матрица рейтингов для шкалы ',scale_type,'.'])
    end

    if all(isnan(ret))
       error(['Нет присвоенных рейтингов ',agency_id,' в шкале ',scale_type,'.']);
    end
 
% Процедура

    eval(['dick=data_structure.scales.',agency_id,'_',scale_type,';']);
    scAggrType=data_structure.scAggrType;
    
    if scAggrType~=sc_aggr_type
        for i=1:height(dick)
            ret(ret==table2array(dick(i,2*scAggrType)))...
                           = table2array(dick(i,2*sc_aggr_type));
        end

        if scAggrType>2 
             warning('Уровень агрегации данных о рейтингах не является базовым. Убедитесь, что агрегирование осуществлено корректно.')
        end
    end
end