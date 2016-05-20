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
    % End initialization code - DO NOT EDIT

function main_OpeningFcn(hObject, eventdata, handles, varargin)
    % This function has no output args, see OutputFcn.
    % hObject    handle to figure
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % varargin   command line arguments to main (see VARARGIN)

    % Choose default command line output for main
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

function varargout = main_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;


function input_file_button_Callback(hObject, eventdata, handles)
    [FileName,PathName] = uigetfile({'*.mat'}, 'Select file to open');
    set(handles.input_file_name, 'String', FileName);
    handles.input_filename = strcat(PathName, FileName);
    guidata(gcbo, handles);

function input_file_name_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
    
function init_button_Callback(hObject, eventdata, handles)
    handles.initDate = '2008/07/01';
    handles.suffix = 'NscQrt';
    handles.sector = 'Bank';
    handles.resFile = 'Results\';
    handles.isRgh = false;
    handles.isNorm = true;
    handles.isEqConsid = true;
    guidata(gcbo, handles);
    
    [timeVec, nscRankMat, iscRankMat, agName] = ...
        getNewData_qrt(handles.initDate, handles.sector, ...
            handles.isRgh, handles.isNorm, handles.input_filename);
    
    % нулевые измерения
    iscRankMat = nan(size(nscRankMat));
    maskExRatesVec = sum(~(isnan(nscRankMat)&isnan(iscRankMat)),2)>=1;
    fprintf('-- > observations with 1 or greater ranks: %i\n',sum(maskExRatesVec));
    nscRankMat = nscRankMat(maskExRatesVec,:);
    iscRankMat = iscRankMat(maskExRatesVec,:);
    timeVec = timeVec(maskExRatesVec);
    
    handles.nscRankMat = nscRankMat;
    handles.iscRankMat = iscRankMat;
    handles.timeVec = timeVec;
    guidata(gcbo, handles);
    
    init_check_form(agName);
    set(handles.aglist, 'String', agName);
    set(handles.genetic_panel, 'Visible', 'On');
    
function nIter_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function nIter_slider_Callback(hObject, eventdata, handles)
    value = get(hObject, 'Value');
    set(handles.nIter, 'String', num2str(round(value)));

function nIter_slider_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function start_abort_Callback(hObject, eventdata, handles)
    global isAborted
    isAborted = false;
    set(handles.abort_button, 'Enable', 'On');
    set(hObject, 'Enable', 'Off');
    drawnow update;
    
    try
        filename = 'loglog2005.txt'; %[resFile,'stats',initDate(1:4),suffix,sector,datestr(now,'dd_mm(HH-MM-SS)'),'.txt'];
        fileID = fopen(filename,'w+');
        if fileID == -1
            error('classification:fopen','cannot open file')
        end
%             open(filename)
        %
        OptimFnc = @(lMat)genetic(lMat,100,100,30,10,0.1,fileID);
        consRankMat = taskShareSC(...
                handles.timeVec, ...
                handles.nscRankMat, ...
                handles.iscRankMat, ...
                handles.isEqConsid, ...
                OptimFnc);

        fclose(fileID);
    catch err
        if ~(strcmp(err.identifier,'classification:fopen'))
            fclose(fileID);
        end
        rethrow(err);
    end
    
    handles.consRankVec = srenumber(consRankMat(:,1));
    guidata(gcbo, handles);
    
    set(handles.start_abort, 'Enable', 'On');
    set(handles.rifling_panel, 'Visible', 'On');
    
    consRank(consRankMat);

function abort_button_Callback(hObject, eventdata, handles)
    global isAborted
    isAborted = true;
    set(hObject, 'Enable', 'Off');
    drawnow update;

function genetic_settings_Callback(hObject, eventdata, handles)


% --- Executes on selection change in aglist.
function aglist_Callback(hObject, eventdata, handles)
% hObject    handle to aglist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns aglist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from aglist


% --- Executes during object creation, after setting all properties.
function aglist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aglist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rifling_button.
function rifling_button_Callback(hObject, eventdata, handles)
% hObject    handle to rifling_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in rifling_settings.
function rifling_settings_Callback(hObject, eventdata, handles)
% hObject    handle to rifling_settings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
