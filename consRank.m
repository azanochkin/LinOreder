function varargout = consRank(varargin)
% CONSRANK MATLAB code for consRank.fig
%      CONSRANK, by itself, creates a new CONSRANK or raises the existing
%      singleton*.
%
%      H = CONSRANK returns the handle to a new CONSRANK or the handle to
%      the existing singleton*.
%
%      CONSRANK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONSRANK.M with the given input arguments.
%
%      CONSRANK('Property','Value',...) creates a new CONSRANK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before consRank_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to consRank_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help consRank

% Last Modified by GUIDE v2.5 20-May-2016 10:09:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @consRank_OpeningFcn, ...
                   'gui_OutputFcn',  @consRank_OutputFcn, ...
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


% --- Executes just before consRank is made visible.
function consRank_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to consRank (see VARARGIN)

% Choose default command line output for consRank
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

consRankVec = varargin{1};
set(handles.cons_table, 'Data', consRankVec);

% UIWAIT makes consRank wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = consRank_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
