function varargout = Auto_SZX2(varargin)
% AUTO_SZX2 MATLAB code for Auto_SZX2.fig
%      AUTO_SZX2, by itself, creates a new AUTO_SZX2 or raises the existing
%      singleton*.
%
%      H = AUTO_SZX2 returns the handle to a new AUTO_SZX2 or the handle to
%      the existing singleton*.
%
%      AUTO_SZX2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTO_SZX2.M with the given input arguments.
%
%      AUTO_SZX2('Property','Value',...) creates a new AUTO_SZX2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Auto_SZX2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Auto_SZX2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Auto_SZX2

% Last Modified by GUIDE v2.5 31-May-2018 14:20:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Auto_SZX2_OpeningFcn, ...
                   'gui_OutputFcn',  @Auto_SZX2_OutputFcn, ...
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


% --- Executes just before Auto_SZX2 is made visible.
function Auto_SZX2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Auto_SZX2 (see VARARGIN)

% Choose default command line output for Auto_SZX2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Auto_SZX2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Auto_SZX2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Up.
function Up_Callback(hObject, eventdata, handles)
% hObject    handle to Up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Moter=handles.my.Moter;
if handles.my.Value==11
    handles.my.Value=11;
else
    handles.my.Value= handles.my.Value+1;
    fwrite(Moter,'z');
end
handles.CurrentMag.Value=handles.my.Value;

set(hObject,'Value',0)
guidata(hObject,handles)



% --- Executes on button press in Down.
function Down_Callback(hObject, eventdata, handles)
% hObject    handle to Down (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Moter=handles.my.Moter;
if handles.my.Value==1
    handles.my.Value=1;
else
    handles.my.Value= handles.my.Value-1;
    fwrite(Moter,'a');
end
handles.CurrentMag.Value=handles.my.Value;
set(hObject,'Value',0)
guidata(hObject,handles)




% --- Executes on button press in Manual.
function Manual_Callback(hObject, eventdata, handles)
% hObject    handle to Manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Moter=handles.my.Moter;
fwrite(Moter,'f');
set(hObject,'Value',0)


% --- Executes on button press in Ini.
function Ini_Callback(hObject, eventdata, handles)
% hObject    handle to Ini (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(0,'UserData');
if ~isfield(a,'Mag') 
    Moter=serial('COM25');
    set(Moter,'BaudRate',9600);  
    set(Moter,'DataBits',8);
    set(Moter,'StopBits',1); 
    fopen(Moter);
    a.Mag=Moter;
    set(0,'UserData',a)
elseif strcmp(a.Mag.Status,'closed')==1
    fopen(Moter);
    a.Mag=Moter;
    set(0,'UserData',a)
else
    Moter=a.Mag;
end

handles.my.Moter=Moter;
Value=handles.CurrentMag.Value;
handles.my.Value=Value;
guidata(hObject,handles)


% --- Executes on button press in Close.
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Moter=handles.my.Moter;
% fclose(Moter);
set(hObject,'Value',0)


% --- Executes on selection change in ExpectedMag.
function ExpectedMag_Callback(hObject, eventdata, handles)
% hObject    handle to ExpectedMag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ExpectedMag contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExpectedMag
Moter=handles.my.Moter;

ValueCurrent=handles.CurrentMag.Value;

ValueExpecte=handles.ExpectedMag.Value;
Delta=ValueExpecte-ValueCurrent;
if Delta~=0
    if Delta>0
        for i=1:Delta
            fwrite(Moter,'z');
            pause(0.1);
%             pause(1.2);
        end
    else
        for i=1:abs(Delta)
            fwrite(Moter,'a');
            pause(0.1);
%             pause(1.2);
        end
    end
end
handles.CurrentMag.Value=handles.ExpectedMag.Value;
handles.my.Value=handles.CurrentMag.Value;
guidata(hObject,handles)

    



% --- Executes during object creation, after setting all properties.
function ExpectedMag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExpectedMag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Ini.
function Ini_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Ini (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in CurrentMag.
function CurrentMag_Callback(hObject, eventdata, handles)
% hObject    handle to CurrentMag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns CurrentMag contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CurrentMag
cellstr(get(hObject,'String'))



% --- Executes during object creation, after setting all properties.
function CurrentMag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CurrentMag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
