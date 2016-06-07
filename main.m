function varargout = main(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

%   Block of function signatures and default actions
function fileName_edit_Callback(hObject, eventdata, handles)
function fileName_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function rankings_list_Callback(hObject, eventdata, handles)
function rankings_list_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function min_date_edit_Callback(hObject, eventdata, handles)
function min_date_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function max_date_edit_Callback(hObject, eventdata, handles)
function max_date_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function sector_listbox_Callback(hObject, eventdata, handles)
function sector_listbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function scales_listbox_Callback(hObject, eventdata, handles)
function scales_listbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function openMatfile_edit_CreateFcn(hObject, eventdata, handles)
function openMat_button_CreateFcn(hObject, eventdata, handles)
function nIter_edit_Callback(hObject, eventdata, handles)
function nIter_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function resFile_edit_Callback(hObject, eventdata, handles)
function resFile_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function rank_listbox_Callback(hObject, eventdata, handles)
function rank_listbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function agences4_listbox_Callback(hObject, eventdata, handles)
function agences4_listbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function scale_name_listbox_Callback(hObject, eventdata, handles)
function scale_name_listbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit13_Callback(hObject, eventdata, handles)
function edit13_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit14_Callback(hObject, eventdata, handles)
function edit14_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function clas_type_popup_Callback(hObject, eventdata, handles)
function clas_type_popup_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function cd_index_popup_Callback(hObject, eventdata, handles)
function cd_index_popup_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function aggrtype_popup_Callback(hObject, eventdata, handles)
function aggrtype_popup_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end 
function mapped_aggr_type_popup_Callback(hObject, eventdata, handles)
function mapped_aggr_type_popup_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function quantile_edit_Callback(hObject, eventdata, handles)
function quantile_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function mapping_approach_popup_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function group_start_edit_Callback(hObject, eventdata, handles)
function group_start_edit_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%   End block of function signatures and default actions

function activate_panel(handles, panel)
    %   Resizes main window to panel size,
    %   moves panel to working place
    
    window_size = get(handles.figure1, 'Position');
    panel_size = get(panel, 'Position');
    set(handles.figure1, 'Position', [window_size(1:2), ...
        panel_size(3:4)]); 
    set(panel, 'Position', [0 0 panel_size(3:4)]);
    
function main_OpeningFcn(hObject, eventdata, handles, varargin)
    %   Creates window, 
    %   sets initialization variables
    
    handles.output = hObject;
    handles.dateFormat = 'yyyy/mm/dd';
    guidata(hObject, handles);
    show1panel(handles)
    
function varargout = main_OutputFcn(hObject, eventdata, handles) 
    %   Closes windows
    
    varargout{1} = handles.output;

function show1panel(handles)
    %   Shows first panel block, 
    %   checks if init_data structure is in workspace
    
    set(handles.next1_button, 'Enable', 'Off');
    activate_panel(handles, handles.panel1);
    if evalin('base', 'exist(''init_data'', ''var'')')
        set(handles.openMat_button, 'Enable', 'On');
    else
        set(handles.openMat_button, 'Enable', 'Off');
    end

function fileName_button_Callback(hObject, eventdata, handles)
    % Opens file with rankings
  
    [FileName,PathName] = uigetfile({'*.xls'; '*.csv'}, 'Select file to open');
    
    if FileName
        handles.upload_data.fileName = strcat(PathName, FileName);
        set(handles.fileName_edit, 'String', handles.upload_data.fileName);
        
        handles.data = getDataFromFile(handles.upload_data.fileName);
        handles.data.scales = getScales(handles.data.agNamesVec);
        handles.data.normRankVec = getMaxScale(handles.data.scales, 1);
        handles.data.rankNamesVec = fieldnames(handles.data.scales);
        guidata(gcbo, handles); 
        set(handles.next1_button, 'Enable', 'On');
    end
    
function next1_button_Callback(hObject, eventdata, handles)
    % 	Sends user to second block
    %   sets up all ui elements
    %   checks if ext_data is in workspace
    
    activate_panel(handles, handles.panel2);
    %
    set(handles.panel2, 'Visible', 'On');
    set(handles.panel1, 'Visible', 'Off');
    %
    set(handles.min_date_edit, 'String', datestr(min(handles.data.dateVec), handles.dateFormat));
    set(handles.max_date_edit, 'String', datestr(max(handles.data.dateVec), handles.dateFormat));
    %
    set(handles.sector_listbox, 'String', unique(handles.data.sectorCVec));
    set(handles.sector_listbox, 'Max', numel(unique(handles.data.sectorCVec)));
    %
    set(handles.rank_listbox, 'String', handles.data.rankNamesVec);
    set(handles.rank_listbox, 'Max', numel(handles.data.rankNamesVec));
    %
    handles.data.scales_names = getScalesNames(handles.data.scales);
    %
    set(handles.scales_listbox, 'String', handles.data.scales_names);
    %
    guidata(gcbo, handles);
    %
    if evalin('base', 'exist(''ext_data'', ''var'')')
        set(handles.skip2_button, 'Enable', 'On');
    else
        set(handles.skip2_button, 'Enable', 'Off');
    end
    %
    assignin('base', 'init_data', handles.data);

function ret = getSettingStep2(handles)
    %   Gets all data user sets
    %   rewrite it to main data structure
    
    ret = handles.data;
    %
    ret.min_date_selected = datenum(get(handles.min_date_edit, 'String'));
    ret.max_date_selected = datenum(get(handles.max_date_edit, 'String'));
    %
    index_selected = get(handles.sector_listbox, 'Value');
    ret.sector_selected = handles.data.sectorCVec(index_selected);
    %
    index_selected = get(handles.scales_listbox, 'Value');
    ret.scales_selected = index_selected;
    %
    index_selected = get(handles.rank_listbox, 'Value');
    %
    ret.rank_names_selected = handles.data.rankNamesVec(index_selected);
    ret.Nsc_indeces_selected = [];
    ret.Isc_indeces_selected = [];
    for i=1:numel(ret.rank_names_selected)
        current = ret.rank_names_selected{i};
        if strcmp(current(end-2:end), 'Nsc')
            ret.Nsc_indeces_selected = [ret.Nsc_indeces_selected, ...
                find(strcmp(ret.NscRankMat_header, current(1:end-4)))];
        elseif strcmp(current(end-2:end), 'Isc')
            ret.Isc_indeces_selected = [ret.Isc_indeces_selected, ...
                find(strcmp(ret.IscRankMat_header, current(1:end-4)))];
        end
    end
    
function openMat_button_Callback(hObject, eventdata, handles)  
    %   Loads init_data structure from workspace
    %   throws error in case of not-existing
    
    try 
        handles.data = evalin('base', 'init_data');
        guidata(gcbo, handles);
        next1_button_Callback(handles.next1_button, 0, handles);
    catch 
        error('Data structure is not in workspace!');
    end
          
function save2_button_Callback(hObject, eventdata, handles)
    %   Saves data structure to *.mat file
   
    [FileName,~] = uiputfile({'*.mat'}, 'Select file to save');
    getSettingStep2(handles);
    data = handles.data;
    save(FileName, 'data');
    
function show3step(handles)
    set(handles.panel3, 'Visible', 'On');
    set(handles.panel2, 'Visible', 'Off');
    activate_panel(handles, handles.panel3);

function next2_button_Callback(hObject, eventdata, handles)
    handles.data = getSettingStep2(handles);
    handles.data.scAggrType = 1;
    %
    handles.data.isSectorVec = ...
        strcmpi(handles.data.sector_selected, handles.data.sectorCVec);
    handles.data.isDateVec = ...
        handles.data.dateVec >= handles.data.min_date_selected & ...
        handles.data.dateVec <= handles.data.max_date_selected;
    %
    handles.data.isObsVec = ...
        sum(~(isnan(handles.data.NscRankMat)&isnan(handles.data.IscRankMat)),2)>=1;
    handles.data.isAppropVec = handles.data.isSectorVec & ...
        handles.data.isDateVec & ...
        handles.data.isObsVec;
    %
    fprintf('-- > appropriate observations : %i\n',sum(handles.data.isAppropVec));
    %
    handles.data.normRankVec = getMaxScale(handles.data.scales, ...
        handles.data.scales_selected);
    handles.data.NscNormVec = handles.data.normRankVec;
    % 
    % Leave only date-, sector-selected
    handles.data.NscRankMat = handles.data.NscRankMat(handles.data.isAppropVec,:);
    handles.data.IscRankMat = handles.data.IscRankMat(handles.data.isAppropVec,:);
    handles.data.dateVec = handles.data.dateVec(handles.data.isAppropVec);
    handles.data.entityCVec = handles.data.entityCVec(handles.data.isAppropVec,:);
    handles.data.sectorCVec = handles.data.sectorCVec(handles.data.isAppropVec,:);
    %
    handles.data.timeVec = handles.data.dateVec;
    handles.data.nGeneticIter = 200;
    %
    for i = 1:numel(handles.data.rank_names_selected)
        current = handles.data.rank_names_selected{i};
        current_name = current(1:3);
        current_scale_type = current(5:end);
        
        [scaledRank, ~] = fnc_rescale_rat(handles.data,...
                current_name, current_scale_type,...
                handles.data.scales_selected); %#ok<ASGLU>
        ind=strcmp(handles.data.agNamesVec,current_name); %#ok<NASGU>
        eval(['handles.data.',current_scale_type,'RankMat(:,ind) = scaledRank;']); 
    end
    % Leaves ony selected agences
    % Not selected columns changed to NaN-value.
    handles.data.NscRankMat(:, setdiff(1:end, handles.data.Nsc_indeces_selected)) = NaN;
    handles.data.NscNormVec(setdiff(1:end, handles.data.Nsc_indeces_selected)) = NaN;
    handles.data.IscRankMat(:, setdiff(1:end, handles.data.Isc_indeces_selected)) = NaN;
    
%     Old version -- columns were removed
%
%     handles.data.NscRankMat = handles.data.NscRankMat(:, handles.data.Nsc_indeces_selected);
%     handles.data.NscNormVec = handles.data.NscNormVec(handles.data.Nsc_indeces_selected);
%     handles.data.IscRankMat = handles.data.IscRankMat(:, handles.data.Isc_indeces_selected);
    %
    assignin('base', 'ext_data', handles.data);
    %
    guidata(gcbo, handles);
    show3step(handles);

function skip2_button_Callback(hObject, eventdata, handles)
    try 
        handles.data = evalin('base', 'ext_data');
        guidata(gcbo, handles);
        show3step(handles);
    catch 
        error('Data structure is not in workspace!');
    end

function start_button_Callback(hObject, eventdata, handles)
    try 
        handles.data.nGeneticIter = str2num(get(handles.nIter_edit, 'String'));
    catch 
        msgbox('Number of iterations must be integer value!');
        return;
    end
    
    set(handles.start_button, 'Enable', 'Off');
    set(handles.abort3_button, 'Enable', 'On');
    
    handles.data.isEqConsid = true;
    
    try
        handles.data.logFileName = [handles.data.resFile,'stats', ...
            datestr(now,'dd_mm(HH-MM-SS)'),'.txt'];
        
        fileID = fopen(handles.data.logFileName,'w+');
        if fileID == -1
            error('classification:fopen','cannot open file')
        end
        
        assignin('base', 'isAborted', false);
        
        OptimFnc = @(lMat)genetic(lMat,60,60,15,...
            handles.data.nGeneticIter,0.1,fileID);
        %
        handles.data.normNscRankMat =  handles.data.NscRankMat./...
            repmat(handles.data.NscNormVec(:)',size(handles.data.NscRankMat,1),1);
        %
        handles.data.consRankMat = taskShareSC(handles.data.timeVec,...
            handles.data.normNscRankMat, handles.data.IscRankMat,...
            handles.data.isEqConsid, OptimFnc);
        fclose(fileID);
    catch err
        if ~(strcmp(err.identifier,'classification:fopen'))
             fclose(fileID);
        end
        rethrow(err);
    end
    
    handles.data.consRankVec = nan(size(handles.data.isAppropVec));
    handles.data.consRankVec(handles.data.isAppropVec) = ...
        srenumber(handles.data.consRankMat(:,1));
    tbl = array2table([handles.data.consRankVec, handles.data.NscRankMat, ...
        handles.data.dateVec, handles.data.idVec]);
    tbl.Properties.VariableNames = [{'consRank'}, handles.data.agNamesVec, ...
        {'date'}, {'ent_id'}];
    writetable(tbl,handles.data.resFile);
    %
    set(handles.start_button, 'Enable', 'On');
    set(handles.abort3_button, 'Enable', 'Off');
    %
    handles.data.ConsRanking = struct('consRankVec', {handles.data.consRankVec}, ...
        'nIteration', handles.data.nGeneticIter, ...
        'log', handles.data.logFileName);
    assignin('base', 'cons_data', handles.data);
    assignin('base', 'ConsRanking', handles.data.ConsRanking);
   
    % TODO : save to xls
    % TODO : skip this block
    % TODO : restructure log

    show4step(handles);
    guidata(gcbo, handles);
    
function show4step(handles)
    set(handles.panel4, 'Visible', 'On');
    set(handles.panel3, 'Visible', 'Off');
    activate_panel(handles, handles.panel4);
    %
    handles.data.name_scale_string = handles.data.rank_names_selected;
    %
    set(handles.scale_name_listbox, 'String', handles.data.name_scale_string);
    set(handles.scale_name_listbox, 'Max', numel(handles.data.name_scale_string));
    %
    set(handles.agences4_listbox, 'String', handles.data.rank_names_selected);
    %
    set(handles.cons_aggrtype_text, 'String', ...
        handles.data.scales_names(handles.data.scales_selected));
    %
    set(handles.mapped_aggr_type_popup, 'String', handles.data.scales_names);
    %
    set(handles.aggrtype_popup, 'String', handles.data.scales_names);
    guidata(gcbo, handles);
       
function save3_button_Callback(hObject, eventdata, handles)
    [FileName,PathName] = uiputfile('.xls', 'Select file to open');
    %
    if FileName
        handles.data.resFile = strcat(PathName, FileName);
        set(handles.resFile_edit, 'String', handles.data.resFile);
        guidata(gcbo, handles); 
        set(handles.start_button, 'Enable', 'On');
    end

function abort3_button_Callback(hObject, eventdata, handles)
    assignin('base', 'isAborted', true);
    
function next4_button_Callback(hObject, eventdata, handles)
    handles.data.name_scale_string = handles.data.rankNamesVec;
    %
    handles.data.ref_ag_id = ...
        handles.data.rank_names_selected{get(handles.agences4_listbox, 'Value')}(1:3);
    %
    handles.data.ref_scale_type = ...
        handles.data.rank_names_selected{get(handles.agences4_listbox, 'Value')}(5:end);
    %
    handles.data.ref_sc_aggr_type = get(handles.aggrtype_popup, 'Value');
    %
    handles.data.rankScale_to_compare = ...
        handles.data.name_scale_string(get(handles.scale_name_listbox, 'Value'));
    %
    handles.data.ref_ag = ...
        handles.data.rank_names_selected(get(handles.agences4_listbox, 'Value'));
    %
    handles.data.condition_flag = get(handles.cd_index_popup, 'Value');
    %
    handles.data.ref_sc_method = get(handles.clas_type_popup, 'Value');
    %
    handles.data.mapped_aggr_type = ...
        get(handles.mapped_aggr_type_popup, 'Value');
    %
    handles.data.joint_dists = {};
    %
    for i=1:numel(handles.data.rankScale_to_compare)
        current = handles.data.rankScale_to_compare{i};
        cur_ag = current(1:3);
        cur_scale = current(5:end);
        %
        result = fnc_get_joint_distrs(handles.data, ...
            handles.data.ref_ag_id(1:3), ...
            handles.data.ref_scale_type, ...
            handles.data.ref_sc_aggr_type, ...
            cur_ag, cur_scale, ...
            handles.data.mapped_aggr_type, ...
            handles.data.condition_flag, ...
            handles.data.ref_sc_method, 0);
        %
        handles.data.joint_dists = [handles.data.joint_dists, result];
    end
    
    guidata(gcbo, handles); 
    assignin('base', 'comp_data', handles.data);
    show5step(handles);
    
function skip3_button_Callback(hObject, eventdata, handles)
    try 
        handles.data = evalin('base', 'cons_data');
    catch 
        error('Data structure is not in workspace!');
    end
    guidata(gcbo, handles);
    show4step(handles);

function skip4_button_Callback(hObject, eventdata, handles)
    try 
        handles.data = evalin('base', 'comp_data');
    catch 
        error('Data structure is not in workspace!');
    end
    guidata(gcbo, handles);
    show5step(handles);

 function show5step(handles)
    set(handles.panel5, 'Visible', 'On');
    set(handles.panel4, 'Visible', 'Off');
    activate_panel(handles, handles.panel5);
   
function finish_button_Callback(hObject, eventdata, handles)
    handles.data.mapping_approach = get(handles.mapping_approach_popup, 'Value');
    %
    handles.data.quantile = str2double(get(handles.quantile_edit, 'String'));
    %
    handles.data.group_start = str2num(get(handles.group_start_edit, 'String'));
    
    result = fnc_get_mapping(handles.data.joint_dists, ...
        handles.data.mapping_approach, ...
        handles.data.group_start, ...
        handles.data.quantile);
    
    assignin('base', 'mapping', result);
    guidata(gcbo, handles); 
        
function mapping_approach_popup_Callback(hObject, eventdata, handles)
    if get(hObject, 'Value') == 3
        set(handles.quantile_edit, 'String', '0.9');
    end
