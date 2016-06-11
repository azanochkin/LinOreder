function [ret,sett]=fnc_impl_rat(data_structure,...
                                 ref_agency_id,...
                                 ref_scale_type,...
                                 sc_aggr_type,...
                                 method_type)

% fnc_impl_rat формирует на консенсусном рэнкинге реф. шкалу 
% в терминах рейтингов шкалы реф. агентства. Результат можно интерпретировать как присвоение implied
% рейтингов реф. агентсва - отсюда название функции. 
%
% Входные данные:
%   - data_structure - стандартная структура с этапа III с данными о рейтингах и консенсусным рэнкингом. 
%   - ref_agency_id  - трехбуквенный код агентсва, выбранного в качестве референтного.
%   - ref_scale_type - трехбуквенный код типа шкалы: {Isc-мжд, Nsc-нац}.
%   - method_type - тип метода классификации наблюдений "зоны неопределенности". 
%       1 - распределяет относительно центрального номера в консенсусе (среднее - classify1);
%       2 - распределяет в менее рискованную категорию (оптимистично - classifyl)
%       3 - распределяет в более рискованную категорию (консервативно - classifyu)

   sett.ref_agency=ref_agency_id;
   sett.ref_scale_type=ref_scale_type;
   sett.classify_method=method_type;

% Проверка согласованности входных данных
    if ~isstruct(data_structure)
        error('data_structure не является структурой.')
    end
   
    if ~ismember(data_structure.agNamesVec,ref_agency_id)
       error(['В agNamesVec структуры data_structure отсутствует информация об агентстве ',ref_agency_id,'.'])
    end
   
    ind=ismember(data_structure.agNamesVec,ref_agency_id);
    
    try
    eval(['rr=data_structure.',ref_scale_type,'RankMat(:,ind);']); 
    catch
        error(['В data_structure отсутсвует матрица рейтингов для шкалы ',ref_scale_type,'.'])
    end
    
    if  all(isnan(rr))
        error(['Нет присвоенных рейтингов ',ref_agency_id,' в шкале ',ref_scale_type,'.']);
    end
    
    % Процедура  
    
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
       error('Недопустимый метод классификации.')
   end


   
   
