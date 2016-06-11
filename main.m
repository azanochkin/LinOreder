%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           Block of function signatures and default actions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
%
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
%
function fileName_edit_Callback(~, ~, ~) %#ok<*DEFNU>
function fileName_edit_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function rankings_list_Callback(~, ~, ~)
function rankings_list_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function min_date_edit_Callback(~, ~, ~)
function min_date_edit_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function max_date_edit_Callback(~, ~, ~)
function max_date_edit_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function sector_listbox_Callback(~, ~, ~)
function sector_listbox_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function scales_listbox_Callback(~, ~, ~)
function scales_listbox_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function openMatfile_edit_CreateFcn(~, ~, ~)
function openMat_button_CreateFcn(~, ~, ~)
function nIter_edit_Callback(~, ~, ~)
function nIter_edit_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function resFile_edit_Callback(~, ~, ~)
function resFile_edit_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function rank_listbox_Callback(~, ~, ~)
function rank_listbox_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function agences4_listbox_Callback(~, ~, ~)
function agences4_listbox_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function scale_name_listbox_Callback(~, ~, ~)
function scale_name_listbox_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit13_Callback(~, ~, ~)
function edit13_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function edit14_Callback(~, ~, ~)
function edit14_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function clas_type_popup_Callback(~, ~, ~)
function clas_type_popup_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function cd_index_popup_Callback(~, ~, ~)
function cd_index_popup_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function aggrtype_popup_Callback(~, ~, ~)
function aggrtype_popup_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end 
function mapped_aggr_type_popup_Callback(~, ~, ~)
function mapped_aggr_type_popup_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function quantile_edit_Callback(~, ~, ~)
function quantile_edit_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function mapping_approach_popup_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function group_start_edit_Callback(~, ~, ~)
function group_start_edit_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           End block of function signatures and default actions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Block #0 :: Initialization and useful functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function activate_panel(handles, panel)
    %   Resizes main window to panel size,
    %   moves panel to working place
    
    window_size = get(handles.figure1, 'Position');
    panel_size = get(panel, 'Position');
    set(handles.figure1, 'Position', [window_size(1:2), ...
        panel_size(3:4)]); 
    set(panel, 'Position', [0 0 panel_size(3:4)]);
    %
    for i = 1:5
        set(handles.(['panel', num2str(i)]), 'Visible', 'Off');
    end
    set(panel, 'Visible', 'On');
    
function main_OpeningFcn(hObject, ~, handles, varargin)
    %   Creates window, 
    %   sets initialization variables
    
    handles.output = hObject;
    handles.dateFormat = 'dd.mm.yyyy';
    guidata(hObject, handles);
    set(handles.next1_button, 'Enable', 'Off');
    activate_panel(handles, handles.panel1);
    if evalin('base', 'exist(''init_data'', ''var'')')
        set(handles.openMat_button, 'Enable', 'On');
    else
        set(handles.openMat_button, 'Enable', 'Off');
    end
    
function varargout = main_OutputFcn(~, ~, handles) 
    %   Closes windows
    
    varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          End of block #0 :: Initialization and useful functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Block # 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function fileName_button_Callback(~, ~, handles)
    % Opens file with rankings
  
    [FileName,PathName] = uigetfile({'*.xls'; '*.csv'}, 'Select file to open');
    
    if FileName
        handles.upload_data.fileName = strcat(PathName, FileName);
        set(handles.fileName_edit, 'String', handles.upload_data.fileName);
        handles.data = getDataFromFileNew(handles.upload_data.fileName);
        
        [handles.data.scales,handles.data.scaleStatus] = ...
            getScalesNew(handles.data.ratNamesTab);
%       handles.data.consSett.normRankVec = ...
%             getMaxScale(handles.data.scales, 1);
        handles.data.ratNamesVec = fieldnames(handles.data.scales);
        handles.data.fileName = strcat(PathName, FileName);
        guidata(gcbo, handles); 
        set(handles.next1_button, 'Enable', 'On');
    end
    
function next1_button_Callback(~, ~, handles)
    % 	Sends user to second block
    %   sets up all ui elements
    %   checks if sample_data is in workspace
    
    activate_panel(handles, handles.panel2);
    %
    set(handles.panel2, 'Visible', 'On');
    set(handles.panel1, 'Visible', 'Off');
    %
    set(handles.min_date_edit, 'String', ...
        datestr(min(handles.data.dateVec), handles.dateFormat));
    set(handles.max_date_edit, 'String', ...
        datestr(max(handles.data.dateVec), handles.dateFormat));
    %
        try
        set(handles.sector_listbox, 'String', handles.data.classNames);
        set(handles.sector_listbox, 'Max', numel(handles.data.classNames));
        catch
            set(handles.sector_listbox, 'String', 'Нет данных');
%             warning('Классификатор не задан.')
        end
    %
    set(handles.rank_listbox, 'String', handles.data.ratNamesVec);
    set(handles.rank_listbox, 'Max', numel(handles.data.ratNamesVec));
    %
    handles.data.scAggrVec = getScalesNames(handles.data.scales);
    handles.data.scAggrVec=sort(handles.data.scAggrVec);
    %
    set(handles.scales_listbox, 'String', handles.data.scAggrVec);
    %
    guidata(gcbo, handles);
    %
    if evalin('base', 'exist(''sample_data'', ''var'')')
        set(handles.skip2_button, 'Enable', 'On');
    else
        set(handles.skip2_button, 'Enable', 'Off');
    end
    %
    assignin('base', 'init_data', handles.data);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           End of Block # 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Block # 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ret = getSettingStep2(handles)
    %   Gets all data user sets
    %   rewrite it to main data structure
    
    ret = handles.data;
    %
    ret.minDateSelected = get(handles.min_date_edit, 'String');
    ret.maxDateSelected = get(handles.max_date_edit, 'String');
    %
    try
    index_selected = get(handles.sector_listbox, 'Value');
    ret.classSelectedVec = handles.data.ClassVec(index_selected);
    catch
    end
    %
    index_selected = get(handles.scales_listbox, 'Value');
    ret.scAggrCons = index_selected;
    %
    index_selected = get(handles.rank_listbox, 'Value');
    %
    handles.rank_names_selected = handles.data.ratNamesVec(index_selected);
    %
    ratSelected=zeros(length(ret.scNamesVec),length(ret.agNamesVec));
    for i=1:length(ret.scNamesVec)
        for j=1:length(ret.agNamesVec)
            if ismember([ret.agNamesVec{j},'_',ret.scNamesVec{i}],...
                    handles.rank_names_selected)
                ratSelected(i,j)=1;
            end
        end    
    end
    ratSelected=array2table(ratSelected);
    ratSelected.Properties.VariableNames=ret.agNamesVec;
    ratSelected.Properties.RowNames=ret.scNamesVec;
    ret.ratSelected=ratSelected;
    
function openMat_button_Callback(~, ~, handles)  
    %   Loads init_data structure from workspace
    %   throws error in case of not-existing
    
    try 
        handles.data = evalin('base', 'init_data');
        guidata(gcbo, handles);
        next1_button_Callback(handles.next1_button, 0, handles);
    catch 
        error('Data structure is not in workspace!');
    end
          
function save2_button_Callback(~, ~, handles)
    %   Saves data structure to *.mat file
   
    [FileName,~] = uiputfile({'*.mat'}, 'Select file to save');
    getSettingStep2(handles);
    data = handles.data; %#ok<NASGU>
    save(FileName, 'data');

function next2_button_Callback(~, ~, handles)
    %   Main action of block 2
    
    handles.data = getSettingStep2(handles);
    %
    %Keeps original Nsc(Isc)RankMat as Nsc(Isc)Rank2Tal
%     for i=1:length(handles.data.scNamesVec)
%     eval(['handles.data.',handles.data.scNamesVec{i},...
%        'Rank2Tab = handles.data.',handles.data.scNamesVec{i},'RankMat;'])
%     end

    % Leaves only selected agences ()
    % Not selected columns changed to NaN-value.
    for i=1:length(handles.data.scNamesVec)
        eval(['handles.data.',handles.data.scNamesVec{i},...
            'RankMat(:,~logical(handles.data.ratSelected{i,:})) = NaN;'])
    end
    %
    handles.data.ratSelectedNameVec = ...
        sort(fnc_ratNameTab2Str(handles.data.ratSelected));
    %
    try
    handles.data.isClassVec = ...
        strcmpi(handles.data.classSelectedVec, handles.data.ClassVec);
    catch
        handles.data.isClassVec=true(size(handles.data.entIdVec));
    end
    
    handles.data.isDateVec = ...
        handles.data.dateVec >= datenum(handles.data.minDateSelected,handles.dateFormat) & ...
        handles.data.dateVec <= datenum(handles.data.maxDateSelected,handles.dateFormat);
    %
    handles.data.isObsVec=false(size(handles.data.dateVec));
    for i=1:length(handles.data.scNamesVec)
        eval(['handles.data.isObsVec = ',...
            'handles.data.isObsVec | ~all(isnan(handles.data.',...
            handles.data.scNamesVec{i},'RankMat),2);']);
    end
    handles.data.isAppropVec = handles.data.isClassVec & ...
        handles.data.isDateVec & ...
        handles.data.isObsVec;
    %
    fprintf('-- > Number of appropriate observations : %i\n',...
        sum(handles.data.isAppropVec));
    %
%     handles.data.consSett.normRankVec = getMaxScale(handles.data.scales, ...
%         handles.data.scAggrId);
%     handles.data.NscNormVec = handles.data.consSett.normRankVec; 
    
    % Leave only date-, sector-selected
    TabRatNonEmp=[];
    for i=1:length(handles.data.scNamesVec)
        eval(['handles.data.',handles.data.scNamesVec{i},...
            'RankMat = handles.data.', handles.data.scNamesVec{i}, ...
            'RankMat(handles.data.isAppropVec,:);']);
        eval(['TabRatNonEmp=[TabRatNonEmp;~all(isnan(handles.data.', ...
            handles.data.scNamesVec{i},'RankMat))];']);
    end
    %
    handles.data.ratAppropNonEmpty=array2table(TabRatNonEmp);
    handles.data.ratAppropNonEmpty.Properties.VariableNames=...
        handles.data.agNamesVec;
    handles.data.ratAppropNonEmpty.Properties.RowNames=...
        handles.data.scNamesVec;
    %
%     handles.data.NscRankMat = ...
%         handles.data.NscRankMat(handles.data.isAppropVec,:);
%     handles.data.IscRankMat = ...
%         handles.data.IscRankMat(handles.data.isAppropVec,:);
    %
    handles.data.ratAppropNonEmptyNamesVec=...
        sort(fnc_ratNameTab2Str(handles.data.ratAppropNonEmpty));
    %
    handles.data.dateVec = handles.data.dateVec(handles.data.isAppropVec);
    handles.data.entIdVec = ...
        handles.data.entIdVec(handles.data.isAppropVec);
    try
    handles.data.entityCVec = ...
        handles.data.entityCVec(handles.data.isAppropVec,:);
    catch
    end
    %
    try
    handles.data.ClassVec = ...
        handles.data.ClassVec(handles.data.isAppropVec,:);
    catch
    end
    %
%     handles.data.timeVec = handles.data.dateVec;
%     handles.data.consSett.nGeneticIter = 200;
    %
    for i=1:length(handles.data.scNamesVec)
        for j=1:length(handles.data.agNamesVec)
            if handles.data.ratSelected{i,j}==1
                current_name = handles.data.agNamesVec{j};
                current_scale_type = handles.data.scNamesVec{i};

                [scaledRank, ~] = fnc_rescale_rat(handles.data,...
                        current_name, current_scale_type,...
                        handles.data.scAggrCons); %#ok<ASGLU>
                ind=strcmp(handles.data.agNamesVec,current_name); %#ok<NASGU>
                eval(['handles.data.',current_scale_type,...
                    'RankMat(:,ind) = scaledRank;']);
            end
        end
    end
    %
    handles.data.scAggrId=handles.data.scAggrCons;
    %
    rmFiledInd = handles.data.ratNamesVec(...
        ~ismember(handles.data.ratNamesVec,...
            handles.data.ratAppropNonEmptyNamesVec));
    handles.data.scales=rmfield(handles.data.scales,rmFiledInd);
    %
    handles.data=rmfield(handles.data,...
        {'ratNamesTab','scaleStatus','ratNamesVec','scAggrCons'});
    %
    assignin('base', 'sample_data', handles.data);
    %
    guidata(gcbo, handles);
    activate_panel(handles, handles.panel3);

function skip2_button_Callback(~, ~, handles)
    %   Checks if sample_data structure is in workspace
    %   Loads it and skips to third block if true
    
    try 
        handles.data = evalin('base', 'sample_data');
        guidata(gcbo, handles);
        activate_panel(handles, handles.panel3);
    catch 
        error('Data structure is not in workspace!');
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           End of Block # 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Block # 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function start_button_Callback(~, ~, handles)
    %   Main action of third block
    %   Constructing the consensus
    
    try 
        handles.data.consSett.nGeneticIter = ...
            str2num(get(handles.nIter_edit, 'String')); %#ok<*ST2NM>
    catch 
        msgbox('Number of iterations must be integer value!');
        return;
    end
    %
    set(handles.start_button, 'Enable', 'Off');
    set(handles.abort3_button, 'Enable', 'On');
    %
    handles.data.consSett.isEqConsid = true;
    %
    try
        handles.data.consSett.logFileName = ...
            [handles.data.resFile,'stats', ...
            datestr(now,'dd_mm(HH-MM-SS)'),'.txt'];
        %
        fileID = fopen(handles.data.consSett.logFileName,'w+');
        if fileID == -1
            error('classification:fopen','cannot open file')
        end
        assignin('base', 'isAborted', false);
        handles.data.consSett.isAborted= false;
        %
        OptimFnc = @(lMat)genetic(lMat,60,60,15,...
            handles.data.consSett.nGeneticIter,0.1,fileID);
        %
        handles.data.consSett.normRankVec = ...
            getMaxScaleNew(handles.data.scales, ...
            handles.data.ratAppropNonEmpty, handles.data.scAggrId);
        %
        %   (Костыль начинается: загоняет все шкалы в normRankMat, 
        %       что позволяет сопоставляеть Nsc и Isc)
        %   (Предполагается, что пользователь достаточно компетентен, 
        %       чтобы не сопоставлять Nsc и Isc 
        %       за пределами отдельного момента времени)
        %
        handles.RankMat=[];
        for i=1:length(handles.data.scNamesVec) 
            eval(['handles.RankMat=[handles.RankMat,handles.data.',...
                handles.data.scNamesVec{i},'RankMat];'])
        end
        %
        handles.normRankMat =  handles.RankMat./...
            repmat(handles.data.consSett.normRankVec(:)',...
            size(handles.RankMat,1),1);
        %
        handles.SubRankMat=nan(size(handles.normRankMat));
        %
        handles.consRankMat = taskShareSC(handles.data.dateVec,...
            handles.normRankMat, handles.SubRankMat,...
            handles.data.consSett.isEqConsid, OptimFnc);
        %
        %   (Костыль заканчивается)
        %
        fclose(fileID);
    catch err
        if ~(strcmp(err.identifier,'classification:fopen'))
             fclose(fileID);
        end
        rethrow(err);
    end
    %
    handles.data.consRanking = ...
        srenumber(handles.consRankMat(:,1));
    %   
    % Saves consensus ranking results to xls-file
    ratNonEmptyInd=handles.data.ratAppropNonEmpty{:,:}';
    ratNonEmptyNames=fnc_ratNameTab2Str(handles.data.ratAppropNonEmpty);
    tbl = array2table([handles.data.consRanking, ...
        handles.RankMat(:,logical(ratNonEmptyInd(:))), ...
        handles.data.dateVec, handles.data.entIdVec]);
    tbl.Properties.VariableNames = [{'consRank'}, ratNonEmptyNames, ...
        {'date'}, {'ent_id'}];
    tbl.date=cellstr(datestr(handles.data.dateVec,handles.dateFormat));
    writetable(tbl,handles.data.resFile);
    %
    set(handles.start_button, 'Enable', 'On');
    set(handles.abort3_button, 'Enable', 'Off');
    %
%     handles.data.ConsRanking = struct('consRanking', ...
%         {handles.data.consRanking}, ...
%         'nIteration', handles.data.consSett.nGeneticIter, ...
%         'log', handles.data.consSett.logFileName);
    %
    assignin('base', 'sample_data', handles.data);
%     assignin('base', 'ConsRanking', handles.data.ConsRanking);
    display(['8========> Поздравляем! ',...
        'Вы построили консенсусный рэнкинг!<========8']);
    show4step(handles);
    guidata(gcbo, handles);
    
function show4step(handles)
    %   Shows the 4th block
    
    activate_panel(handles, handles.panel4);
    %
%   handles.data.name_scale_string = handles.rank_names_selected;
    handles.rank_names_selected=sort(fnc_ratNameTab2Str(handles.data.ratAppropNonEmpty));
    %
    set(handles.scale_name_listbox, 'String', handles.rank_names_selected);
    set(handles.scale_name_listbox, 'Max', numel(handles.rank_names_selected));
    %
    set(handles.agences4_listbox, 'String', handles.rank_names_selected);
    %
    set(handles.cons_aggrtype_text, 'String', ...
        handles.data.scAggrVec(handles.data.scAggrId));
    %
    set(handles.mapped_aggr_type_popup, 'String', handles.data.scAggrVec);
    %
    set(handles.aggrtype_popup, 'String', handles.data.scAggrVec);
    guidata(gcbo, handles);
       
function save3_button_Callback(~, ~, handles)
    %   Saves data to *.xls file
    
    [FileName,PathName] = uiputfile('.xls', 'Select file to open');
    %
    if FileName
        handles.data.resFile = strcat(PathName, FileName);
        set(handles.resFile_edit, 'String', handles.data.resFile);
        guidata(gcbo, handles); 
        set(handles.start_button, 'Enable', 'On');
    end

function abort3_button_Callback(~, ~, handles)
    %   Set abort flag to true, 
    %   Abort the genetic function
    
    handles.data.consSett.isAborted= true;
    assignin('base', 'isAborted', true);
    
function skip3_button_Callback(~, ~, handles)
    %   Checks if sample_data structure is in workspace
    %   Loads it and skips to next block if true
    try 
        handles.data = evalin('base', 'sample_data');
    catch 
        error('Data structure is not in workspace!');
    end
    guidata(gcbo, handles);
    show4step(handles);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           End of Block # 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Block # 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function next4_button_Callback(~, ~, handles)
    %   Getting all settings and send to next block
    
    handles.rank_names_selected=...
        sort(fnc_ratNameTab2Str(handles.data.ratAppropNonEmpty));
    %
    handles.data.jDistSett.refScVec = ...
        handles.rank_names_selected(...
        get(handles.agences4_listbox, 'Value'));
    %
    handles.refAgId = ...
        handles.rank_names_selected{...
        get(handles.agences4_listbox, 'Value')}(1:3);
    %
    handles.refScType = ...
        handles.rank_names_selected{...
        get(handles.agences4_listbox, 'Value')}(5:end);
    %   
    handles.data.jDistSett.refAggrId = ...
        get(handles.aggrtype_popup, 'Value');
    %
    handles.data.jDistSett.mappedScVec = ...
        handles.rank_names_selected(...
        get(handles.scale_name_listbox, 'Value'));
    %
    handles.data.jDistSett.mappedAggrType = ...
        get(handles.mapped_aggr_type_popup, 'Value');
    %
    handles.data.jDistSett.conditionFlag = ...
        get(handles.cd_index_popup, 'Value')-1;
    %
    handles.data.jDistSett.refScMethod = ...
        get(handles.clas_type_popup, 'Value');
    %
    handles.data.jointDistVec = {};
    %
    for i=1:numel(handles.data.jDistSett.mappedScVec)
        current = handles.data.jDistSett.mappedScVec{i};
        cur_ag = current(1:3);
        cur_scale = current(5:end);
        %
        result = fnc_get_joint_distrs(handles.data, ...
            handles.refAgId, ...
            handles.refScType, ...
            handles.data.jDistSett.refAggrId, ...
            cur_ag, cur_scale, ...
            handles.data.jDistSett.mappedAggrType, ...
            handles.data.jDistSett.conditionFlag, ...
            handles.data.jDistSett.refScMethod, 0);
        %
        handles.data.jointDistVec = [handles.data.jointDistVec, result];
    end
    %
    guidata(gcbo, handles); 
    assignin('base', 'sample_data', handles.data);
    activate_panel(handles, handles.panel5);

function skip4_button_Callback(~, ~, handles)
    %   Checks if sample_data structure is in workspace
    %   Loads it and skips to third block if true
    try 
        handles.data = evalin('base', 'sample_data');
    catch 
        error('Data structure is not in workspace!');
    end
    guidata(gcbo, handles);
    activate_panel(handles, handles.panel5);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           End of Block # 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Block # 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function finish_button_Callback(~, ~, handles)
    %   Finishing
    handles.data.mappingSett.mappingApproach = ...
        get(handles.mapping_approach_popup, 'Value');
    %
    handles.data.mappingSett.quantile = ...
        str2double(get(handles.quantile_edit, 'String'));
    %
    handles.data.mappingSett.groupStart = ...
        str2num(get(handles.group_start_edit, 'String'));
    
    handles.data.mappingTab = ...
        fnc_get_mapping(handles.data.jointDistVec, ...
            handles.data.mappingSett.mappingApproach, ...
            handles.data.mappingSett.groupStart, ...
            handles.data.mappingSett.quantile);
    
    assignin('base', 'sample_data', handles.data);
    display(['8========> Поздравляем! ', ...
        'Вы построили таблицу сопоставления рейтинговых шкал!<========8']);
    guidata(gcbo, handles); 
        
function mapping_approach_popup_Callback(hObject, ~, handles)
    if get(hObject, 'Value') == 3
        set(handles.quantile_edit, 'String', '0.9');
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            End of block # 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
