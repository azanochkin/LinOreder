function varargout = genetic_settings(varargin)
% GENETIC_SETTINGS MATLAB code for genetic_settings.fig
%      GENETIC_SETTINGS, by itself, creates a new GENETIC_SETTINGS or raises the existing
%      singleton*.
%
%      H = GENETIC_SETTINGS returns the handle to a new GENETIC_SETTINGS or the handle to
%      the existing singleton*.
%
%      GENETIC_SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GENETIC_SETTINGS.M with the given input arguments.
%
%      GENETIC_SETTINGS('Property','Value',...) creates a new GENETIC_SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before genetic_settings_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to genetic_settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help genetic_settings

% Last Modified by GUIDE v2.5 20-May-2016 16:29:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @genetic_settings_OpeningFcn, ...
                   'gui_OutputFcn',  @genetic_settings_OutputFcn, ...
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


% --- Executes just before genetic_settings is made visible.
function genetic_settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to genetic_settings (see VARARGIN)

% Choose default command line output for genetic_settings
handles.output = hObject;

main_handles = varargin{1};

set(handles.population_number, 'String', main_handles.popNum);
set(handles.nCross, 'String', main_handles.nCross);
set(handles.nMutat, 'String', main_handles.nMutat);
set(handles.alphaMutat, 'String', main_handles.alphaMutat);
set(handles.logfile, 'String', main_handles.logfile);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes genetic_settings wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = genetic_settings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function population_number_Callback(hObject, eventdata, handles)
% hObject    handle to population_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of population_number as text
%        str2double(get(hObject,'String')) returns contents of population_number as a double


% --- Executes during object creation, after setting all properties.
function population_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to population_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nCross_Callback(hObject, eventdata, handles)
% hObject    handle to nCross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nCross as text
%        str2double(get(hObject,'String')) returns contents of nCross as a double


% --- Executes during object creation, after setting all properties.
function nCross_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nCross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nMutat_Callback(hObject, eventdata, handles)
% hObject    handle to nMutat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nMutat as text
%        str2double(get(hObject,'String')) returns contents of nMutat as a double


% --- Executes during object creation, after setting all properties.
function nMutat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nMutat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alphaMutat_Callback(hObject, eventdata, handles)
% hObject    handle to alphaMutat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alphaMutat as text
%        str2double(get(hObject,'String')) returns contents of alphaMutat as a double


% --- Executes during object creation, after setting all properties.
function alphaMutat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alphaMutat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function logfile_Callback(hObject, eventdata, handles)
% hObject    handle to logfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of logfile as text
%        str2double(get(hObject,'String')) returns contents of logfile as a double


% --- Executes during object creation, after setting all properties.
function logfile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to logfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global global_popNum
global global_nCross
global global_nMutat
global global_alphaMutat
global global_logfile

global_popNum = str2num(get(handles.population_number, 'String'));
global_nCross = str2num(get(handles.nCross, 'String'));
global_nMutat = str2num(get(handles.nMutat, 'String'));
global_alphaMutat = str2num(get(handles.alphaMutat, 'String'));
global_logfile = get(handles.logfile, 'String');
% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uiputfile({'*.txt'}, 'Save logfile to');
set(handles.logfile, 'String', strcat(PathName, FileName));