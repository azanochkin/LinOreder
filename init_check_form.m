function varargout = init_check_form(varargin)
% INIT_CHECK_FORM MATLAB code for init_check_form.fig
%      INIT_CHECK_FORM, by itself, creates a new INIT_CHECK_FORM or raises the existing
%      singleton*.
%
%      H = INIT_CHECK_FORM returns the handle to a new INIT_CHECK_FORM or the handle to
%      the existing singleton*.
%
%      INIT_CHECK_FORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INIT_CHECK_FORM.M with the given input arguments.
%
%      INIT_CHECK_FORM('Property','Value',...) creates a new INIT_CHECK_FORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before init_check_form_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to init_check_form_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help init_check_form

% Last Modified by GUIDE v2.5 19-May-2016 18:56:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @init_check_form_OpeningFcn, ...
                   'gui_OutputFcn',  @init_check_form_OutputFcn, ...
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


% --- Executes just before init_check_form is made visible.
function init_check_form_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to init_check_form (see VARARGIN)

% Choose default command line output for init_check_form
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

agName = varargin{1};
disp(handles);
set(handles.agnames_table, 'Data', agName);
% UIWAIT makes init_check_form wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = init_check_form_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
