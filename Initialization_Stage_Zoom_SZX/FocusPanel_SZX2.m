function varargout = FocusPanel_SZX2(varargin)
% FOCUSPANEL_SZX2 MATLAB code for FocusPanel_SZX2.fig
%      FOCUSPANEL_SZX2, by its elf, creates a new FOCUSPANEL_SZX2 or raises the existing
%      singleton*.
%
%      H = FOCUSPANEL_SZX2 returns the handle to a new FOCUSPANEL_SZX2 or the handle to
%      the existing singleton*.
%
%      FOCUSPANEL_SZX2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOCUSPANEL_SZX2.M with the given input arguments.
%
%      FOCUSPANEL_SZX2('Property','Value',...) creates a new FOCUSPANEL_SZX2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FocusPanel_SZX2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FocusPanel_SZX2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FocusPanel_SZX2

% Last Modified by GUIDE v2.5 05-Jun-2018 15:29:44

%	We have signed a confidentiality agreement with Olympus China regarding the realization of automatic zoom. 
%	SDK information and control instructions for SZX2-FOA, SZX2-MDCU and SZX-MDHSW will not be disclosed for the time being. 
%	Therefore, the control instruction codes are replaced with "XXX" in the scripts. For more information, please contact Olympus China. 

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FocusPanel_SZX2_OpeningFcn, ...
                   'gui_OutputFcn',  @FocusPanel_SZX2_OutputFcn, ...
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


% --- Executes just before FocusPanel_SZX2 is made visible.
function FocusPanel_SZX2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FocusPanel_SZX2 (see VARARGIN)

% Choose default command line output for FocusPanel_SZX2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FocusPanel_SZX2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FocusPanel_SZX2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Init.
function Init_Callback(hObject, eventdata, handles)
% hObject    handle to Init (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% port = 'COM2';
% SZX2 = serial(port,'BaudRate', 19200,'Parity', 'even','StopBits', 2.0);
% fopen(SZX2);
a=get(0,'UserData');
if ~isfield(a,'Focus') 
    SZX2 = serial("XXX");
    fopen(SZX2);
    a.Focus=SZX2;
    try
        fprintf(SZX2, '%s\r\n', 'XXX'); %Zoom Unit initialization
    catch
        fprintf(SZX2, '%s\r\n', 'XXX');
        fprintf(SZX2, '%s\r\n', 'XXX');
    end
    set(0,'UserData',a)
else
    SZX2=a.Focus;
end

handles.my.SZX2=SZX2;
guidata(hObject,handles)


% --- Executes on button press in Local.
function Local_Callback(hObject, eventdata, handles)
% hObject    handle to Local (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SZX2=handles.my.SZX2;
fprintf(SZX2, '%s\r\n', 'XXX'); %Focus control unit local mode
set(hObject,'Value',0)
guidata(hObject,handles)

% --- Executes on button press in up.
function up_Callback(hObject, eventdata, handles)
% hObject    handle to up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SZX2=handles.my.SZX2;
fprintf(SZX2, '%s\r\n', 'XXX'); %Focus plane goes up
set(hObject,'Value',0)
guidata(hObject,handles)


% --- Executes on button press in down.
function down_Callback(hObject, eventdata, handles)
% hObject    handle to down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SZX2=handles.my.SZX2;
fprintf(SZX2, '%s\r\n', 'XXX'); %Focus plane goes down
set(hObject,'Value',0)
guidata(hObject,handles)


% --- Executes on button press in remote.
function remote_Callback(hObject, eventdata, handles)
% hObject    handle to remote (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SZX2=handles.my.SZX2;
fprintf(SZX2, '%s\r\n', 'XXX'); %Focus control unit remote (automatic) mode
set(hObject,'Value',0)
guidata(hObject,handles)


% --- Executes on button press in Close.
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SZX2=handles.my.SZX2;
fclose(SZX2);
set(hObject,'Value',0)
guidata(hObject,handles)
