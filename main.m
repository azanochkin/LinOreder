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

function input_file_name_Callback(hObject, eventdata, handles)

function input_file_name_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end

function input_file_name_ButtonDownFcn(hObject, eventdata, handles)
    set(hObject, 'String', '');

function init_button_Callback(hObject, eventdata, handles)
    initDate = '2008/07/01';
    suffix = 'NscQrt';
    sector = 'Bank';
    resFile = 'Results\';
    isRgh = false;
    isNorm = true;
    isEqConsid = true;
    
    input_filename = handles.input_filename;
    
    [timeVec, nscRankMat, iscRankMat, agName] = ...
        getNewData_qrt(initDate, sector, isRgh, isNorm, input_filename);
    
    % нулевые измерения
    iscRankMat = nan(size(nscRankMat));
    maskExRatesVec = sum(~(isnan(nscRankMat)&isnan(iscRankMat)),2)>=1;
    fprintf('-- > observations with 1 or greater ranks: %i\n',sum(maskExRatesVec));
    nscRankMat = nscRankMat(maskExRatesVec,:);
    iscRankMat = iscRankMat(maskExRatesVec,:);
    timeVec = timeVec(maskExRatesVec);
    
    init_check_form(agName);
    
function init_settings_button_Callback(hObject, eventdata, handles)
