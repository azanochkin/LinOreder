function varargout = init_settings(varargin)
% INIT_SETTINGS MATLAB code for init_settings.fig
%      INIT_SETTINGS, by itself, creates a new INIT_SETTINGS or raises the existing
%      singleton*.
%
%      H = INIT_SETTINGS returns the handle to a new INIT_SETTINGS or the handle to
%      the existing singleton*.
%
%      INIT_SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INIT_SETTINGS.M with the given input arguments.
%
%      INIT_SETTINGS('Property','Value',...) creates a new INIT_SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before init_settings_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to init_settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help init_settings

% Last Modified by GUIDE v2.5 20-May-2016 14:45:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @init_settings_OpeningFcn, ...
                   'gui_OutputFcn',  @init_settings_OutputFcn, ...
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


% --- Executes just before init_settings is made visible.
function init_settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to init_settings (see VARARGIN)

% Choose default command line output for init_settings
handles.output = hObject;

main_handles = varargin{1};

set(handles.date_edit, 'String', main_handles.initDate);
set(handles.popupmenu1, 'String', main_handles.sector);
set(handles.isRgh_checkbox, 'Value', main_handles.isRgh);
% set(handles.checkbox2isNorm_checkbox, 'Value', main_handles.isNorm);
set(handles.isEqCors_checkbox, 'Value', main_handles.isEqConsid);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes init_settings wait for user response (see UIRESUME)
% uiwait(handles.init_fig);


% --- Outputs from this function are returned to the command line.
function varargout = init_settings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function date_edit_Callback(hObject, eventdata, handles)
% hObject    handle to date_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of date_edit as text
%        str2double(get(hObject,'String')) returns contents of date_edit as a double


% --- Executes during object creation, after setting all properties.
function date_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to date_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in isRgh_checkbox.
function isRgh_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to isRgh_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of isRgh_checkbox


% --- Executes on button press in checkbox2isNorm_checkbox.
function checkbox2isNorm_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2isNorm_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2isNorm_checkbox


% --- Executes on button press in isEqCors_checkbox.
function isEqCors_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to isEqCors_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of isEqCors_checkbox


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close init_fig.
function init_fig_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to init_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global global_initDate
global global_sector
global global_isRgh
global global_isEqConsid

global_initDate = get(handles.date_edit, 'String');
global_isEqConsid = get(handles.isEqCors_checkbox, 'Value');
global_isRgh = get(handles.isRgh_checkbox, 'Value');
global_sector = get(handles.popupmenu1, 'String');

% Hint: delete(hObject) closes the figure
delete(hObject);
