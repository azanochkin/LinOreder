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

function main_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
set(handles.next1_button, 'Enable', 'Off');
handles.dateFormat = 'yyyy/mm/dd';


if evalin('base', 'exist(''init_data'', ''var'')')
    set(handles.openMat_button, 'Enable', 'On');
else
    set(handles.openMat_button, 'Enable', 'Off');
end
guidata(hObject, handles);

function varargout = main_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function fileName_button_Callback(hObject, eventdata, handles)
    % Open file with rankings
  
    [FileName,PathName] = uigetfile({'*.xls'; '*.csv'}, 'Select file to open');
    
    if FileName
        handles.upload_data.fileName = strcat(PathName, FileName);
        set(handles.fileName_edit, 'String', handles.upload_data.fileName);
        
        handles.data = getDataFromFile(handles.upload_data.fileName);
        handles.data.scales = getScales(handles.data.agNamesVec);
        
        handles.data.rankNamesVec = fieldnames(handles.data.scales);
        guidata(gcbo, handles); 
        set(handles.next1_button, 'Enable', 'On');
    end
    
function next1_button_Callback(hObject, eventdata, handles)
    % Move action to new panel
    set(handles.panel2, 'Visible', 'On');
    set(handles.panel1, 'Visible', 'Off');
    
    set(handles.min_date_edit, 'String', datestr(min(handles.data.dateVec), handles.dateFormat));
    set(handles.max_date_edit, 'String', datestr(max(handles.data.dateVec), handles.dateFormat));
    
    set(handles.sector_listbox, 'String', unique(handles.data.sectorCVec));
    set(handles.sector_listbox, 'Max', numel(unique(handles.data.sectorCVec)));
    
    set(handles.rank_listbox, 'String', handles.data.rankNamesVec);
    
    set(handles.rank_listbox, 'Max', numel(handles.data.rankNamesVec));
    
    handles.data.scales_names = getScalesNames(handles.data.scales);
    
    set(handles.scales_listbox, 'String', handles.data.scales_names);
    
    guidata(gcbo, handles);

    assignin('base', 'init_data', handles.data);

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

function ret = getSettingStep2(handles)
    ret = handles.data;
    
    ret.min_date_selected = datenum(get(handles.min_date_edit, 'String'));
    ret.max_date_selected = datenum(get(handles.max_date_edit, 'String'));
    
    index_selected = get(handles.sector_listbox, 'Value');
    ret.sector_selected = handles.data.sectorCVec(index_selected);
    
    index_selected = get(handles.scales_listbox, 'Value');
    ret.scales_selected = index_selected;
    
    index_selected = get(handles.rank_listbox, 'Value');
    
    ret.rank_names_selected = handles.data.rankNamesVec(index_selected);
    
function openMat_button_Callback(hObject, eventdata, handles)  
    try 
        handles.data = evalin('base', 'init_data');
        guidata(gcbo, handles);
        next1_button_Callback(handles.next1_button, 0, handles);
    catch 
        error('Data structure is not in workspace!');
    end
          
function save2_button_Callback(hObject, eventdata, handles)
    % Button saves data structure to *.mat file
    [FileName,~] = uiputfile({'*.mat'}, 'Select file to save');
    getSettingStep2(handles);
    data = handles.data;
    save(FileName, 'data');

function next2_button_Callback(hObject, eventdata, handles)
    handles.data = getSettingStep2(handles);

    set(handles.panel2, 'Visible', 'Off');

    handles.data.scAggrType = 1;
    
    % ????
    % handles.data.iscRankMat = nan(size(handles.data.iscRankMat));
    
    handles.data.isSectorVec = ...
        strcmpi(handles.data.sector_selected, handles.data.sectorCVec);
    handles.data.isDateVec = ...
        handles.data.dateVec >= handles.data.min_date_selected & ...
        handles.data.dateVec <= handles.data.max_date_selected;
    
    handles.data.isObsVec = ...
        sum(~(isnan(handles.data.NscRankMat)&isnan(handles.data.IscRankMat)),2)>=1;
    handles.data.isAppropVec = handles.data.isSectorVec & ...
        handles.data.isDateVec & ...
        handles.data.isObsVec;
    
    fprintf('-- > appropriate observations : %i\n',sum(handles.data.isAppropVec));
    
    handles.data.normRankVec = getMaxScale(handles.data.scales, ...
        handles.data.scales_selected);
    handles.data.NscNormVec = handles.data.normRankVec;
    handles.data.NscRankMat = handles.data.NscRankMat(handles.data.isAppropVec,:);
    handles.data.IscRankMat = handles.data.IscRankMat(handles.data.isAppropVec,:);
    handles.data.timeVec = handles.data.dateVec(handles.data.isAppropVec);
    handles.data.nGeneticIter = 500;
    
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
    assignin('base', 'ext_data', handles.data);
    
    disp('All done');
    guidata(gcbo, handles);
    
function rank_listbox_Callback(hObject, eventdata, handles)

function rank_listbox_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
