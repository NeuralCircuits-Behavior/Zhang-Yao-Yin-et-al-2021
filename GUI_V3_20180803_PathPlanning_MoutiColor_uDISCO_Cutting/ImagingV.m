function varargout = ImagingV(varargin)
% IMAGINGV MATLAB code for ImagingV.fig
%      IMAGINGV, by itself, creates a new IMAGINGV or raises the existing
%      singleton*.
%
%      H = IMAGINGV returns the handle to a new IMAGINGV or the handle to
%      the existing singleton*.
%
%      IMAGINGV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGINGV.M with the given input arguments.
%
%      IMAGINGV('Property','Value',...) creates a new IMAGINGV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImagingV_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImagingV_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImagingV

% Last Modified by GUIDE v2.5 03-Aug-2018 14:35:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImagingV_OpeningFcn, ...
                   'gui_OutputFcn',  @ImagingV_OutputFcn, ...
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


% --- Executes just before ImagingV is made visible.
function ImagingV_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImagingV (see VARARGIN)

% Choose default command line output for ImagingV
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImagingV wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImagingV_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in SaveConfig.
function SaveConfig_Callback(hObject, eventdata, handles)
% hObject    handle to SaveConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SaveConfig


% --- Executes on button press in StartImaging.
function StartImaging_Callback(hObject, eventdata, handles)
% hObject    handle to StartImaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of StartImaging
 if ~isfield(handles.my,'ImagingStartTag') | handles.my.ImagingStartTag~=handles.my.CleanN
  handles.my.ImagingStartTag=handles.my.CleanN;
  guidata(hObject,handles);
  if handles.Planning.Value==1
      StartImaging_Planning(hObject,eventdata,handles)
  else
      StartImagingZ(hObject,eventdata,handles)
  end
 end



% --- Executes on button press in Update.
function Update_Callback(hObject, eventdata, handles)
% hObject    handle to Update (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Update


% --- Executes on button press in Snap.
function Snap_Callback(hObject, eventdata, handles)
% hObject    handle to Snap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Snap

get(hObject,'Value');
[mmc,gui,commandTerminator,port]=GetValueNormal(handles);
mmc.setExposure(str2num(handles.ExposureEdit.String));
gui.sleep(10);
if handles.Snap.Value==1
     mmc.snapImage();
     img = mmc.getImage();
     img=TransferImage(img);
     figure;imshow(img,[]);
end
handles.Snap.Value=0;

% --- Executes on slider movement.
function MoveXSlider_Callback(hObject, eventdata, handles)
% hObject    handle to MoveXSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Value=get(hObject,'Value');
ValueUm=(Value-0)/1*(10000*2)-10000;
ValueUm=fix(ValueUm/10)*10;
set(handles.MoveXEdit,'String',ValueUm);

% --- Executes during object creation, after setting all properties.
function MoveXSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MoveXSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function MoveYSlider_Callback(hObject, eventdata, handles)
% hObject    handle to MoveYSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Value=get(hObject,'Value');
ValueUm=(Value-0)/1*(10000*2)-10000;
ValueUm=fix(ValueUm/10)*10;
set(handles.MoveYEdit,'String',ValueUm);

% --- Executes during object creation, after setting all properties.
function MoveYSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MoveYSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function MoveZSlider_Callback(hObject, eventdata, handles)
% hObject    handle to MoveZSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
Value=get(hObject,'Value');
ValueUm=(Value-0)/1*(10000*2)-10000;
ValueUm=fix(ValueUm/10)*10;
set(handles.MoveZEdit,'String',ValueUm);

% --- Executes during object creation, after setting all properties.
function MoveZSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MoveZSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function MoveXEdit_Callback(hObject, eventdata, handles)
% hObject    handle to MoveXEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MoveXEdit as text
%        str2double(get(hObject,'String')) returns contents of MoveXEdit as a double
Value=str2double(get(hObject,'String'));
ValueUm=(Value+10000)/(10000*2)*1-0;
set(handles.MoveXSlider,'Value',ValueUm);

% --- Executes during object creation, after setting all properties.
function MoveXEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MoveXEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MoveYEdit_Callback(hObject, eventdata, handles)
% hObject    handle to MoveYEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MoveYEdit as text
%        str2double(get(hObject,'String')) returns contents of MoveYEdit as a double
Value=str2double(get(hObject,'String'));
ValueUm=(Value+10000)/(10000*2)*1-0;
set(handles.MoveYSlider,'Value',ValueUm);


% --- Executes during object creation, after setting all properties.
function MoveYEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MoveYEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MoveZEdit_Callback(hObject, eventdata, handles)
% hObject    handle to MoveZEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MoveZEdit as text
%        str2double(get(hObject,'String')) returns contents of MoveZEdit as a double
 Value=str2double(get(hObject,'String'));
 ValueUm=(Value+10000)/(10000*2)*1-0;
 set(handles.MoveZSlider,'Value',ValueUm);

% --- Executes during object creation, after setting all properties.
function MoveZEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MoveZEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MoveX.
function MoveX_Callback(hObject, eventdata, handles)
% hObject    handle to MoveX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MoveX
[classObj]=GetValueNormal(handles);
StagePort=handles.my.StagePort;
[SleepTime8 ,SleepTime1 ,SleepTime10 ,SleepTime11 ,SleepTime12 ,SleepTime2X,SleepTime2Y,SleepTime2Z,SleepTime3X,SleepTime3Y,SleepTime4,SleepTime5,SleepTime6,SleepTime7,SleepTime9,SleepTimeCut2]=GetValueSleepTime(handles);
StringMove=get(handles.MoveXEdit,'String');
Speed=str2num(handles.Speed.String);
Acceleration=str2num(handles.Acceleration.String);
StringMove=str2num(StringMove)/1000; % transfer mm
classObj.MoCtrCard_MCrlAxisRelMove(0,StringMove,Speed,Acceleration);
handles.my.Reference(1)=handles.my.Reference(1)+StringMove*1000;
guidata(hObject,handles);
set(hObject,'Value',0)

% --- Executes on button press in MoveY.
function MoveY_Callback(hObject, eventdata, handles)
% hObject    handle to MoveY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MoveY
[classObj]=GetValueNormal(handles);
StagePort=handles.my.StagePort;
[SleepTime8 ,SleepTime1 ,SleepTime10 ,SleepTime11 ,SleepTime12 ,SleepTime2X,SleepTime2Y,SleepTime2Z,SleepTime3X,SleepTime3Y,SleepTime4,SleepTime5,SleepTime6,SleepTime7,SleepTime9,SleepTimeCut2]=GetValueSleepTime(handles);
StringMove=str2num(get(handles.MoveYEdit,'String'));
Speed=str2num(handles.Speed.String);
Acceleration=str2num(handles.Acceleration.String);
StringMove=StringMove/1000; % transfer mm
classObj.MoCtrCard_MCrlAxisRelMove(1,StringMove,Speed,Acceleration);
handles.my.Reference(2)=handles.my.Reference(2)+StringMove*1000;
guidata(hObject,handles);
set(hObject,'Value',0)

% --- Executes on button press in MoveZ.
function MoveZ_Callback(hObject, eventdata, handles)
% hObject    handle to MoveZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MoveZ
[classObj]=GetValueNormal(handles);
StagePort=handles.my.StagePort;
[SleepTime8 ,SleepTime1 ,SleepTime10 ,SleepTime11 ,SleepTime12 ,SleepTime2X,SleepTime2Y,SleepTime2Z,SleepTime3X,SleepTime3Y,SleepTime4,SleepTime5,SleepTime6,SleepTime7,SleepTime9,SleepTimeCut2]=GetValueSleepTime(handles);
StringMove=str2num(get(handles.MoveZEdit,'String'));
Speed=str2num(handles.Speed.String);
Acceleration=str2num(handles.Acceleration.String);
StringMove=StringMove/1000; % transfer mm
classObj.MoCtrCard_MCrlAxisRelMove(2,StringMove,Speed,Acceleration);
handles.my.Reference(3)=handles.my.Reference(3)+StringMove*1000;
guidata(hObject,handles);
set(hObject,'Value',0)

% --- Executes on button press in LeftBlue.
function LeftBlue_Callback(hObject, eventdata, handles)
% hObject    handle to LeftBlue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LeftBlue
Value=get(hObject,'Value');
if Value==1
    SetPulsePalVoltageNew(1,10); %488 Left
elseif Value==0
    SetPulsePalVoltageNew(1,0);
end

% --- Executes on button press in RightBlue.
function RightBlue_Callback(hObject, eventdata, handles)
% hObject    handle to RightBlue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RightBlue
Value=get(hObject,'Value');
if Value==1
    SetPulsePalVoltageNew(2,6); %488 Right
elseif Value==0
    SetPulsePalVoltageNew(2,0);
end

% --- Executes on button press in LeftYellow.
function LeftYellow_Callback(hObject, eventdata, handles)
% hObject    handle to LeftYellow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LeftYellow
Value=get(hObject,'Value');
if Value==1
    SetPulsePalVoltageNew(3,10); %561 Left
elseif Value==0
    SetPulsePalVoltageNew(3,0);
end

% --- Executes on button press in RightYellow.
function RightYellow_Callback(hObject, eventdata, handles)
% hObject    handle to RightYellow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RightYellow
Value=get(hObject,'Value');
if Value==1
    SetPulsePalVoltageNew(4,10); %561 Right
elseif Value==0
    SetPulsePalVoltageNew(4,0);
end

% --- Executes on button press in LeftRed.
function LeftRed_Callback(hObject, eventdata, handles)
% hObject    handle to LeftRed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LeftRed
Value=get(hObject,'Value');
if Value==1
    SetPulsePalVoltageNew(3,10); %647 Left
elseif Value==0
    SetPulsePalVoltageNew(3,0);
end

% --- Executes on button press in RightRed.
function RightRed_Callback(hObject, eventdata, handles)
% hObject    handle to RightRed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RightRed
Value=get(hObject,'Value');
if Value==1
    SetPulsePalVoltageNew(4,10); %647 Right
elseif Value==0
    SetPulsePalVoltageNew(4,0);
end


% --- Executes on button press in Initialize.
function Initialize_Callback(hObject, eventdata, handles)
% hObject    handle to Initialize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Initialize

%% addpath
MainProcedureFolder='';
if isempty(MainProcedureFolder)
    MainProcedureFolder=which('ImagingV');
    [MainProcedureFolder,~]=fileparts(MainProcedureFolder);
end
addpath(MainProcedureFolder);

%% ports

[PulsePalPort PulsePalNewPort StagePort WheelPort VibratomePort,FocusPort]=GetPorts;
handles.my.PulsePalPort=PulsePalPort;
handles.my.PulsePalNewPort=PulsePalNewPort;
handles.my.StagePort=StagePort;
handles.my.WheelPort=WheelPort;
handles.my.VibratomePort=VibratomePort;
%% wheel
Wheel = instrfind('Type', 'serial', 'Port', 'COM5', 'Tag', '');
if isempty(Wheel)
    Wheel = serial('COM5');
else
    fclose(Wheel);
    Wheel = Wheel(1);
end
fopen(Wheel);
set(Wheel, 'BaudRate', 128000);
%% Change The Magnification
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

%% Focus

if ~isfield(a,'Focus') 
    SZX2 = serial(FocusPort,'BaudRate', 19200,'Parity', 'even','StopBits', 2.0);
    fopen(SZX2);
    a.Focus=SZX2;
    try
        fprintf(SZX2, '%s\r\n', '3LOG IN');
    catch
        fprintf(SZX2, '%s\r\n', '3LOG OUT');
        fprintf(SZX2, '%s\r\n', '3LOG IN');
    end
    set(0,'UserData',a)
else
    SZX2=a.Focus;
end

handles.my.SZX2=SZX2;



%% Vibratome
if  ~isfield(handles,'my') | ~isfield(handles.my,'LeicaVibratome')
    LeicaVibratome=serial(VibratomePort);
    set(LeicaVibratome,'BaudRate',9600);  
    set(LeicaVibratome,'DataBits',8);
    set(LeicaVibratome,'StopBits',1); 
    handles.my.LeicaVibratome=LeicaVibratome;
end
%% Stage 

if isstruct(a)
    if isfield(a,'classObj')
         handles.my.classObj=a.classObj;
    end
end

if ~isfield(handles,'my') | ~isfield(handles.my,'classObj')
    NET.addAssembly('C:\Program Files\MATLAB\R2016b\bin\MCC6DLL_0425.dll');
    classObj = SerialPortLibrary.SPLibClass();
    classObj.MoCtrCard_Initial(StagePort);
    handles.my.classObj=classObj;    
    a.classObj=classObj;
    set(0,'UserData',a)
end

%% PulsePal ETL
PulsePal(PulsePalPort)
SetPulsePalVoltage(1,4.0);
SetPulsePalVoltage(2,4.0);

%% PulsePalNew
PulsePalNew(PulsePalNewPort)
SetPulsePalVoltageNew(1,0); %488 Left
SetPulsePalVoltageNew(2,0); %488 Right
SetPulsePalVoltageNew(3,0); %561 Left
SetPulsePalVoltageNew(4,0); %561 Right

%%  Other
handles.my.ParentFolder='D:\WholeBrainImagingData\';
handles.SaveFolderPath.String=[handles.my.ParentFolder handles.AnimalName.String];

Value=str2double(handles.MoveXEdit.String);
ValueUm=(Value+10000)/(10000*2)*1-0;
set(handles.MoveXSlider,'Value',ValueUm);

Value=str2double(handles.MoveYEdit.String);
ValueUm=(Value+10000)/(10000*2)*1-0;
set(handles.MoveYSlider,'Value',ValueUm);

Value=str2double(handles.MoveZEdit.String);
ValueUm=(Value+10000)/(10000*2)*1-0;
set(handles.MoveZSlider,'Value',ValueUm);

Value=str2double(handles.ExposureEdit.String);
ValueUm=Value/500;
handles.ExposureSlider.Value=ValueUm;

handles.my.ImagingStartTag=0;
handles.my.CleanN=1;
handles.my.Reference=[0 0 0];
%% ImageJ
% MIJ.start
set(hObject,'Value',0)
guidata(hObject,handles)


function PulsePalLeftV_Callback(hObject, eventdata, handles)
% hObject    handle to PulsePalLeftV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PulsePalLeftV as text
%        str2double(get(hObject,'String')) returns contents of PulsePalLeftV as a double
Voltage=str2double(get(hObject,'String'));
SetPulsePalVoltage(2,Voltage);

% --- Executes during object creation, after setting all properties.
function PulsePalLeftV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PulsePalLeftV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PulsePalRightV_Callback(hObject, eventdata, handles)
% hObject    handle to PulsePalRightV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PulsePalRightV as text
%        str2double(get(hObject,'String')) returns contents of PulsePalRightV as a double
Voltage=str2double(get(hObject,'String'));
SetPulsePalVoltage(1,Voltage);

% --- Executes during object creation, after setting all properties.
function PulsePalRightV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PulsePalRightV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Filter.
function Filter_Callback(hObject, eventdata, handles)
% hObject    handle to Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Filter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Filter

Wheel = instrfind('Type', 'serial', 'Port',handles.my.WheelPort, 'Tag', '');
Filter=get(hObject,'Value'); 
FilterStr=GetFilterString;
WheelTag=FilterStr(Filter);
query(Wheel, WheelTag, '%c\n');


% --- Executes during object creation, after setting all properties.
function Filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Speed_Callback(hObject, eventdata, handles)
% hObject    handle to Speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Speed as text
%        str2double(get(hObject,'String')) returns contents of Speed as a double


% --- Executes during object creation, after setting all properties.
function Speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SnapCombineSnapLeft.
function SnapCombineSnapLeft_Callback(hObject, eventdata, handles)
% hObject    handle to SnapCombineSnapLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SnapCombineSnapLeft

if handles.SnapCombineSnapLeft.Value==1
    [mmc,gui,commandTerminator,port]=GetValueNormal(handles);
    mmc.setExposure(str2num(handles.ExposureEdit.String));
    gui.sleep(10);
    VoltageSampledLeft=eval(handles.SnapCombineControlVoltageLeft.String);
    img=SnapCombine(VoltageSampledLeft,2,mmc,gui);
    figure;imshow(img,[]);
    handles.SnapCombineSnapLeft.Value=0;
end
    


function ExposureEdit_Callback(hObject, eventdata, handles)
% hObject    handle to ExposureEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExposureEdit as text
%        str2double(get(hObject,'String')) returns contents of ExposureEdit as a double
[mmc,gui,commandTerminator,port]=GetValueNormal(handles);
Value=str2double(get(hObject,'String'));
mmc.setExposure(Value);
ValueUm=Value/500;
handles.ExposureSlider.Value=ValueUm;



% --- Executes during object creation, after setting all properties.
function ExposureEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExposureEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function ExposureSlider_Callback(hObject, eventdata, handles)
% hObject    handle to ExposureSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
[mmc,gui,commandTerminator,port]=GetValueNormal(handles);
Value=get(hObject,'Value');
ValueUm=(Value-0)/1*(500)-0;
ValueUm=fix(ValueUm/1)*1;
handles.ExposureEdit.String=ValueUm;
mmc.setExposure(ValueUm);




% --- Executes during object creation, after setting all properties.
function ExposureSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExposureSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in Magnification.
function Magnification_Callback(hObject, eventdata, handles)
% hObject    handle to Magnification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Magnification contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Magnification


% --- Executes during object creation, after setting all properties.
function Magnification_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Magnification (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AnimalName_Callback(hObject, eventdata, handles)
% hObject    handle to AnimalName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AnimalName as text
%        str2double(get(hObject,'String')) returns contents of AnimalName as a double
handles.SaveFolderPath.String=[handles.my.ParentFolder '\' handles.AnimalName.String];



% --- Executes during object creation, after setting all properties.
function AnimalName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AnimalName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ParentFolder.
function ParentFolder_Callback(hObject, eventdata, handles)
% hObject    handle to ParentFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ParentFolder
handles.my.ParentFolder=uigetdir('D:\');
handles.ParentFolder.Value=0;
handles.SaveFolderPath.String=[handles.my.ParentFolder '\' handles.AnimalName.String];
guidata(hObject,handles);






function SaveFolderPath_Callback(hObject, eventdata, handles)
% hObject    handle to SaveFolderPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SaveFolderPath as text
%        str2double(get(hObject,'String')) returns contents of SaveFolderPath as a double


% --- Executes during object creation, after setting all properties.
function SaveFolderPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SaveFolderPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in LoadSettings.
function LoadSettings_Callback(hObject, eventdata, handles)
% hObject    handle to LoadSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LoadSettings
Folder=which('ImagingV');
Folder=fileparts(Folder);
Folder=[Folder,'\','Configure\*cfg'];
[ConfigureName,Path]=uigetfile(Folder);

ConfigureName=[Path,ConfigureName];
loadSettings(hObject,handles,ConfigureName)
handles.LoadSettings.Value=0;


    

function [SleepTime1]=getValueSleepTime_(handles)
    SleepTime1=handles.my.SleepTime1;



function XStepSize_Callback(hObject, eventdata, handles)
% hObject    handle to XStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of XStepSize as text
%        str2double(get(hObject,'String')) returns contents of XStepSize as a double


% --- Executes during object creation, after setting all properties.
function XStepSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function YStepSize_Callback(hObject, eventdata, handles)
% hObject    handle to YStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YStepSize as text
%        str2double(get(hObject,'String')) returns contents of YStepSize as a double


% --- Executes during object creation, after setting all properties.
function YStepSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ZStepSize_Callback(hObject, eventdata, handles)
% hObject    handle to ZStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ZStepSize as text
%        str2double(get(hObject,'String')) returns contents of ZStepSize as a double


% --- Executes during object creation, after setting all properties.
function ZStepSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ZStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ZCycle_Callback(hObject, eventdata, handles)
% hObject    handle to ZCycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ZCycle as text
%        str2double(get(hObject,'String')) returns contents of ZCycle as a double


% --- Executes during object creation, after setting all properties.
function ZCycle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ZCycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function XCycle_Callback(hObject, eventdata, handles)
% hObject    handle to XCycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of XCycle as text
%        str2double(get(hObject,'String')) returns contents of XCycle as a double


% --- Executes during object creation, after setting all properties.
function XCycle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to XCycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function YCycle_Callback(hObject, eventdata, handles)
% hObject    handle to YCycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YCycle as text
%        str2double(get(hObject,'String')) returns contents of YCycle as a double


% --- Executes during object creation, after setting all properties.
function YCycle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YCycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ZOverlap_Callback(hObject, eventdata, handles)
% hObject    handle to ZOverlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ZOverlap as text
%        str2double(get(hObject,'String')) returns contents of ZOverlap as a double


% --- Executes during object creation, after setting all properties.
function ZOverlap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ZOverlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CutStepCutting_Callback(hObject, eventdata, handles)
% hObject    handle to CutStepCutting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CutStepCutting as text
%        str2double(get(hObject,'String')) returns contents of CutStepCutting as a double


% --- Executes during object creation, after setting all properties.
function CutStepCutting_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CutStepCutting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ZCut_Callback(hObject, eventdata, handles)
% hObject    handle to ZCut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ZCut as text
%        str2double(get(hObject,'String')) returns contents of ZCut as a double


% --- Executes during object creation, after setting all properties.
function ZCut_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ZCut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ZDifference_Callback(hObject, eventdata, handles)
% hObject    handle to ZDifference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ZDifference as text
%        str2double(get(hObject,'String')) returns contents of ZDifference as a double


% --- Executes during object creation, after setting all properties.
function ZDifference_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ZDifference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CutStepReady_Callback(hObject, eventdata, handles)
% hObject    handle to CutStepReady (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CutStepReady as text
%        str2double(get(hObject,'String')) returns contents of CutStepReady as a double


% --- Executes during object creation, after setting all properties.
function CutStepReady_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CutStepReady (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTime7_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTime7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTime7 as text
%        str2double(get(hObject,'String')) returns contents of SleepTime7 as a double


% --- Executes during object creation, after setting all properties.
function SleepTime7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTime7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTime10_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTime10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTime10 as text
%        str2double(get(hObject,'String')) returns contents of SleepTime10 as a double


% --- Executes during object creation, after setting all properties.
function SleepTime10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTime10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTime5_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTime5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTime5 as text
%        str2double(get(hObject,'String')) returns contents of SleepTime5 as a double


% --- Executes during object creation, after setting all properties.
function SleepTime5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTime5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTime4_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTime4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTime4 as text
%        str2double(get(hObject,'String')) returns contents of SleepTime4 as a double


% --- Executes during object creation, after setting all properties.
function SleepTime4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTime4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTime6_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTime6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTime6 as text
%        str2double(get(hObject,'String')) returns contents of SleepTime6 as a double


% --- Executes during object creation, after setting all properties.
function SleepTime6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTime6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTime3X_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTime3X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTime3X as text
%        str2double(get(hObject,'String')) returns contents of SleepTime3X as a double


% --- Executes during object creation, after setting all properties.
function SleepTime3X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTime3X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTime2Y_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTime2Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTime2Y as text
%        str2double(get(hObject,'String')) returns contents of SleepTime2Y as a double


% --- Executes during object creation, after setting all properties.
function SleepTime2Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTime2Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTime2Z_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTime2Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTime2Z as text
%        str2double(get(hObject,'String')) returns contents of SleepTime2Z as a double


% --- Executes during object creation, after setting all properties.
function SleepTime2Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTime2Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTime2X_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTime2X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTime2X as text
%        str2double(get(hObject,'String')) returns contents of SleepTime2X as a double


% --- Executes during object creation, after setting all properties.
function SleepTime2X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTime2X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTime1_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTime1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTime1 as text
%        str2double(get(hObject,'String')) returns contents of SleepTime1 as a double


% --- Executes during object creation, after setting all properties.
function SleepTime1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTime1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTimeCut2_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTimeCut2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTimeCut2 as text
%        str2double(get(hObject,'String')) returns contents of SleepTimeCut2 as a double


% --- Executes during object creation, after setting all properties.
function SleepTimeCut2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTimeCut2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTime3Y_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTime3Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTime3Y as text
%        str2double(get(hObject,'String')) returns contents of SleepTime3Y as a double


% --- Executes during object creation, after setting all properties.
function SleepTime3Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTime3Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTime8_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTime8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTime8 as text
%        str2double(get(hObject,'String')) returns contents of SleepTime8 as a double


% --- Executes during object creation, after setting all properties.
function SleepTime8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTime8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTime9_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTime9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTime9 as text
%        str2double(get(hObject,'String')) returns contents of SleepTime9 as a double


% --- Executes during object creation, after setting all properties.
function SleepTime9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTime9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTime11_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTime11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTime11 as text
%        str2double(get(hObject,'String')) returns contents of SleepTime11 as a double


% --- Executes during object creation, after setting all properties.
function SleepTime11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTime11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SleepTime12_Callback(hObject, eventdata, handles)
% hObject    handle to SleepTime12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SleepTime12 as text
%        str2double(get(hObject,'String')) returns contents of SleepTime12 as a double


% --- Executes during object creation, after setting all properties.
function SleepTime12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SleepTime12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MaxCuttingThickness_Callback(hObject, eventdata, handles)
% hObject    handle to MaxCuttingThickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MaxCuttingThickness as text
%        str2double(get(hObject,'String')) returns contents of MaxCuttingThickness as a double


% --- Executes during object creation, after setting all properties.
function MaxCuttingThickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxCuttingThickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExposureRedRight_Callback(hObject, eventdata, handles)
% hObject    handle to ExposureRedRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExposureRedRight as text
%        str2double(get(hObject,'String')) returns contents of ExposureRedRight as a double


% --- Executes during object creation, after setting all properties.
function ExposureRedRight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExposureRedRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExposureYellowRight_Callback(hObject, eventdata, handles)
% hObject    handle to ExposureYellowRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExposureYellowRight as text
%        str2double(get(hObject,'String')) returns contents of ExposureYellowRight as a double


% --- Executes during object creation, after setting all properties.
function ExposureYellowRight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExposureYellowRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExposureBlueRight_Callback(hObject, eventdata, handles)
% hObject    handle to ExposureBlueRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExposureBlueRight as text
%        str2double(get(hObject,'String')) returns contents of ExposureBlueRight as a double


% --- Executes during object creation, after setting all properties.
function ExposureBlueRight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExposureBlueRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExposureYellowLeft_Callback(hObject, eventdata, handles)
% hObject    handle to ExposureYellowLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExposureYellowLeft as text
%        str2double(get(hObject,'String')) returns contents of ExposureYellowLeft as a double


% --- Executes during object creation, after setting all properties.
function ExposureYellowLeft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExposureYellowLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExposureBlueLeft_Callback(hObject, eventdata, handles)
% hObject    handle to ExposureBlueLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExposureBlueLeft as text
%        str2double(get(hObject,'String')) returns contents of ExposureBlueLeft as a double


% --- Executes during object creation, after setting all properties.
function ExposureBlueLeft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExposureBlueLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ExposureRedLeft_Callback(hObject, eventdata, handles)
% hObject    handle to ExposureRedLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExposureRedLeft as text
%        str2double(get(hObject,'String')) returns contents of ExposureRedLeft as a double


% --- Executes during object creation, after setting all properties.
function ExposureRedLeft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExposureRedLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in SnapPop.
function SnapPop_Callback(hObject, eventdata, handles)
% hObject    handle to SnapPop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SnapPop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SnapPop


% --- Executes during object creation, after setting all properties.
function SnapPop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SnapPop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ExposureDefaultPop.
function ExposureDefaultPop_Callback(hObject, eventdata, handles)
% hObject    handle to ExposureDefaultPop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ExposureDefaultPop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ExposureDefaultPop


% --- Executes during object creation, after setting all properties.
function ExposureDefaultPop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExposureDefaultPop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RightImaging_Callback(hObject, eventdata, handles)
% hObject    handle to RightImaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RightImaging as text
%        str2double(get(hObject,'String')) returns contents of RightImaging as a double


% --- Executes during object creation, after setting all properties.
function RightImaging_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RightImaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LeftImaging_Callback(hObject, eventdata, handles)
% hObject    handle to LeftImaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LeftImaging as text
%        str2double(get(hObject,'String')) returns contents of LeftImaging as a double


% --- Executes during object creation, after setting all properties.
function LeftImaging_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LeftImaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in BlueImaging.
function BlueImaging_Callback(hObject, eventdata, handles)
% hObject    handle to BlueImaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns BlueImaging contents as cell array
%        contents{get(hObject,'Value')} returns selected item from BlueImaging


% --- Executes during object creation, after setting all properties.
function BlueImaging_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BlueImaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in YellowImaging.
function YellowImaging_Callback(hObject, eventdata, handles)
% hObject    handle to YellowImaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns YellowImaging contents as cell array
%        contents{get(hObject,'Value')} returns selected item from YellowImaging


% --- Executes during object creation, after setting all properties.
function YellowImaging_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YellowImaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RedImaging.
function RedImaging_Callback(hObject, eventdata, handles)
% hObject    handle to RedImaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns RedImaging contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RedImaging


% --- Executes during object creation, after setting all properties.
function RedImaging_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RedImaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in CombinePop.
function CombinePop_Callback(hObject, eventdata, handles)
% hObject    handle to CombinePop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns CombinePop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from CombinePop


% --- Executes during object creation, after setting all properties.
function CombinePop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CombinePop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function VoltageLeft_Callback(hObject, eventdata, handles)
% hObject    handle to VoltageLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VoltageLeft as text
%        str2double(get(hObject,'String')) returns contents of VoltageLeft as a double


% --- Executes during object creation, after setting all properties.
function VoltageLeft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VoltageLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function VoltageRight_Callback(hObject, eventdata, handles)
% hObject    handle to VoltageRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VoltageRight as text
%        str2double(get(hObject,'String')) returns contents of VoltageRight as a double


% --- Executes during object creation, after setting all properties.
function VoltageRight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VoltageRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ConfigureName_Callback(hObject, eventdata, handles)
% hObject    handle to ConfigureName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ConfigureName as text
%        str2double(get(hObject,'String')) returns contents of ConfigureName as a double


% --- Executes during object creation, after setting all properties.
function ConfigureName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ConfigureName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ContinueCheck.
function ContinueCheck_Callback(hObject, eventdata, handles)
% hObject    handle to ContinueCheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ContinueCheck


% --- Executes on button press in Break.
function Break_Callback(hObject, eventdata, handles)
% hObject    handle to Break (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Break





function SnapCombineControlVoltageLeft_Callback(hObject, eventdata, handles)
% hObject    handle to SnapCombineControlVoltageLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SnapCombineControlVoltageLeft as text
%        str2double(get(hObject,'String')) returns contents of SnapCombineControlVoltageLeft as a double


% --- Executes during object creation, after setting all properties.
function SnapCombineControlVoltageLeft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SnapCombineControlVoltageLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SnapCombineControlVoltageRight_Callback(hObject, eventdata, handles)
% hObject    handle to SnapCombineControlVoltageRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SnapCombineControlVoltageRight as text
%        str2double(get(hObject,'String')) returns contents of SnapCombineControlVoltageRight as a double


% --- Executes during object creation, after setting all properties.
function SnapCombineControlVoltageRight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SnapCombineControlVoltageRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SnapCombineSnapRight.
function SnapCombineSnapRight_Callback(hObject, eventdata, handles)
% hObject    handle to SnapCombineSnapRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SnapCombineSnapRight
if handles.SnapCombineSnapRight.Value==1
    [mmc,gui,commandTerminator,port]=GetValueNormal(handles);
    VoltageSampledRight=eval(handles.SnapCombineControlVoltageRight.String);
    mmc.setExposure(str2num(handles.ExposureEdit.String));
    gui.sleep(10);
    img=SnapCombine(VoltageSampledRight,1,mmc,gui);
    figure;imshow(img,[]);
    handles.SnapCombineSnapRight.Value=0;
end

% --- Executes on selection change in YellowFilter.
function YellowFilter_Callback(hObject, eventdata, handles)
% hObject    handle to YellowFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns YellowFilter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from YellowFilter


% --- Executes during object creation, after setting all properties.
function YellowFilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YellowFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in RedFilter.
function RedFilter_Callback(hObject, eventdata, handles)
% hObject    handle to RedFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns RedFilter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from RedFilter


% --- Executes during object creation, after setting all properties.
function RedFilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RedFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in BlueFilter.
function BlueFilter_Callback(hObject, eventdata, handles)
% hObject    handle to BlueFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns BlueFilter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from BlueFilter


% --- Executes during object creation, after setting all properties.
function BlueFilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BlueFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SaveConfigure.
function SaveConfigure_Callback(hObject, eventdata, handles)
% hObject    handle to SaveConfigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SaveConfigure
SaveConfigure(handles);
handles.SaveConfigure.Value=0;


% --- Executes on button press in CleanStart.
function CleanStart_Callback(hObject, eventdata, handles)
% hObject    handle to CleanStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CleanStart

handles.my.CleanN=handles.my.CleanN+1;
handles.CleanStart.Value=0;
guidata(hObject,handles)


% --- Executes on button press in MoveReturnX.
function MoveReturnX_Callback(hObject, eventdata, handles)
% hObject    handle to MoveReturnX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MoveReturnX
[classObj]=GetValueNormal(handles);
Speed=str2num(handles.Speed.String);
Acceleration=str2num(handles.Acceleration.String);
Xlocation=handles.my.Xlocation;
Ylocation=handles.my.Ylocation;
Zdirection=handles.my.Zdirection;
% move X
classObj.MoCtrCard_MCrlAxisRelMove(0,Xlocation*(-1),Speed,Acceleration);
handles.MoveReturnX.Value=0;



% --- Executes on button press in MoveReturnY.
function MoveReturnY_Callback(hObject, eventdata, handles)
% hObject    handle to MoveReturnY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MoveReturnY
[classObj]=GetValueNormal(handles);
Speed=str2num(handles.Speed.String);
Acceleration=str2num(handles.Acceleration.String);
Xlocation=handles.my.Xlocation;
Ylocation=handles.my.Ylocation;
Zdirection=handles.my.Zdirection;
% move X
classObj.MoCtrCard_MCrlAxisRelMove(1,Ylocation*(-1),Speed,Acceleration);
handles.MoveReturnY.Value=0;


% --- Executes on button press in MoveReturnZ.
function MoveReturnZ_Callback(hObject, eventdata, handles)
% hObject    handle to MoveReturnZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MoveReturnZ
[classObj]=GetValueNormal(handles);
Speed=str2num(handles.Speed.String);
Acceleration=str2num((handles.Acceleration.String));
Xlocation=handles.my.Xlocation;
Ylocation=handles.my.Ylocation;
Zlocation=handles.my.Zdirection;
% move X
classObj.MoCtrCard_MCrlAxisRelMove(2,Zlocation*(-1),Speed,Acceleration);
handles.MoveReturnZ.Value=0;

% --- Executes on button press in MoveReturn0.
function MoveReturn0_Callback(hObject, eventdata, handles)
% hObject    handle to MoveReturn0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MoveReturn0
[classObj]=GetValueNormal(handles);
Speed=str2num(handles.Speed.String);
Acceleration=str2num(handles.Acceleration.String);
Xlocation=handles.my.Xlocation;
Ylocation=handles.my.Ylocation;
Zlocation=handles.my.Zdirection;
% move X
classObj.MoCtrCard_MCrlAxisRelMove(0,Xlocation*(-1),Speed,Acceleration);
pause(2)
classObj.MoCtrCard_MCrlAxisRelMove(1,Ylocation*(-1),Speed,Acceleration);
pause(2)
classObj.MoCtrCard_MCrlAxisRelMove(2,Zlocation*(-1),Speed,Acceleration);
handles.MoveReturnX.Value=0;
handles.MoveReturnY.Value=0;
handles.MoveReturnZ.Value=0;
handles.MoveReturn0.Value=0;


% --- Executes on button press in ControlReturn0.
function ControlReturn0_Callback(hObject, eventdata, handles)
% hObject    handle to ControlReturn0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ControlReturn0
[classObj]=GetValueNormal(handles);
Speed=str2num(handles.Speed.String);
Acceleration=str2num(handles.Acceleration.String);
%X
classObj.MoCtrCard_MCrlAxisRelMove(0,num2str(handles.my.Reference(1)/1000),Speed,Acceleration);
pase(abs(handles.my.Reference(1))/1000*1.5);

%Y
classObj.MoCtrCard_MCrlAxisRelMove(1,num2str(handles.my.Reference(2)/1000),Speed,Acceleration);
pase(abs(handles.my.Reference(1))/1000*1.5);

%Y
classObj.MoCtrCard_MCrlAxisRelMove(2,num2str(handles.my.Reference(3)/1000),Speed,Acceleration);
pase(abs(handles.my.Reference(1))/1000*1.5);

handles.my.Reference(1)=0;
handles.my.Reference(2)=0;
handles.my.Reference(3)=0;
guidata(hObject,handles);
set(hObject,'Value',0);



% --- Executes on button press in ControlReturnX.
function ControlReturnX_Callback(hObject, eventdata, handles)
% hObject    handle to ControlReturnX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ControlReturnX
[classObj]=GetValueNormal(handles);
Speed=str2num(handles.Speed.String);
Acceleration=str2num(handles.Acceleration.String);
%X
classObj.MoCtrCard_MCrlAxisRelMove(0,num2str(handles.my.Reference(1)/1000),Speed,Acceleration);
pase(abs(handles.my.Reference(1))/1000*1.5);
handles.my.Reference(1)=0;
guidata(hObject,handles);
set(hObject,'Value',0);

% --- Executes on button press in ControlReturnY.
function ControlReturnY_Callback(hObject, eventdata, handles)
% hObject    handle to ControlReturnY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ControlReturnY
[classObj]=GetValueNormal(handles);
StagePort=handles.my.StagePort;
Speed=str2num(handles.Speed.String);
Acceleration=str2num(handles.Acceleration.String);
%Y
classObj.MoCtrCard_MCrlAxisRelMove(1,num2str(handles.my.Reference(2)/1000),Speed,Acceleration);
pase(abs(handles.my.Reference(2))/1000*1.5);
handles.my.Reference(2)=0;
guidata(hObject,handles);
set(hObject,'Value',0);

% --- Executes on button press in SetReference.
function SetReference_Callback(hObject, eventdata, handles)
% hObject    handle to SetReference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SetReference
handles.my.Reference(1)=0;
handles.my.Reference(2)=0;
handles.my.Reference(3)=0;
set(hObject,'Value',0);
guidata(hObject,handles);

% --- Executes on button press in ControlReturnZ.
function ControlReturnZ_Callback(hObject, eventdata, handles)
% hObject    handle to ControlReturnZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ControlReturnZ
[classObj]=GetValueNormal(handles);
Speed=str2num(handles.Speed.String);
Acceleration=str2num(handles.Acceleration.String);
%Y
classObj.MoCtrCard_MCrlAxisRelMove(1,num2str(handles.my.Reference(3)/1000),Speed,Acceleration);
pase(abs(handles.my.Reference(3))/1000*1.5);
handles.my.Reference(3)=0;
guidata(hObject,handles);
set(hObject,'Value',0);


% --- Executes on button press in PrintLocation.
function PrintLocation_Callback(hObject, eventdata, handles)
% hObject    handle to PrintLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PrintLocation
X=handles.my.Reference(1);
Y=handles.my.Reference(2);
Z=handles.my.Reference(3);
display(['CurrentLocation(um)  X:', num2str(X),'   Y:',num2str(Y),'   Z:',num2str(Z)]);
set(hObject,'Value',0);



function Acceleration_Callback(hObject, eventdata, handles)
% hObject    handle to Acceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Acceleration as text
%        str2double(get(hObject,'String')) returns contents of Acceleration as a double


% --- Executes during object creation, after setting all properties.
function Acceleration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Acceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Normalspeed_Callback(hObject, eventdata, handles)
% hObject    handle to Normalspeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Normalspeed as text
%        str2double(get(hObject,'String')) returns contents of Normalspeed as a double


% --- Executes during object creation, after setting all properties.
function Normalspeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Normalspeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CutspeedReady_Callback(hObject, eventdata, handles)
% hObject    handle to CutspeedReady (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CutspeedReady as text
%        str2double(get(hObject,'String')) returns contents of CutspeedReady as a double


% --- Executes during object creation, after setting all properties.
function CutspeedReady_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CutspeedReady (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CutspeedCutting_Callback(hObject, eventdata, handles)
% hObject    handle to CutspeedCutting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CutspeedCutting as text
%        str2double(get(hObject,'String')) returns contents of CutspeedCutting as a double


% --- Executes during object creation, after setting all properties.
function CutspeedCutting_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CutspeedCutting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AccelerationRealMove_Callback(hObject, eventdata, handles)
% hObject    handle to AccelerationRealMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AccelerationRealMove as text
%        str2double(get(hObject,'String')) returns contents of AccelerationRealMove as a double


% --- Executes during object creation, after setting all properties.
function AccelerationRealMove_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AccelerationRealMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit79_Callback(hObject, eventdata, handles)
% hObject    handle to ZStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ZStepSize as text
%        str2double(get(hObject,'String')) returns contents of ZStepSize as a double


% --- Executes during object creation, after setting all properties.
function edit79_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ZStepSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ContinuslyMove.
function ContinuslyMove_Callback(hObject, eventdata, handles)
% hObject    handle to ContinuslyMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles
% Hint: get(hObject,'Value') returns toggle state of ContinuslyMove


% --- Executes on button press in Planning.
function Planning_Callback(hObject, eventdata, handles)
% hObject    handle to Planning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Planning


% --- Executes on selection change in PlanningMag.
function PlanningMag_Callback(hObject, eventdata, handles)
% hObject    handle to PlanningMag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PlanningMag contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PlanningMag


% --- Executes during object creation, after setting all properties.
function PlanningMag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PlanningMag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ImagingMag.
function ImagingMag_Callback(hObject, eventdata, handles)
% hObject    handle to ImagingMag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ImagingMag contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ImagingMag


% --- Executes during object creation, after setting all properties.
function ImagingMag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ImagingMag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in LightSide.
function LightSide_Callback(hObject, eventdata, handles)
% hObject    handle to LightSide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns LightSide contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LightSide


% --- Executes during object creation, after setting all properties.
function LightSide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LightSide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in LightColor.
function LightColor_Callback(hObject, eventdata, handles)
% hObject    handle to LightColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns LightColor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LightColor


% --- Executes during object creation, after setting all properties.
function LightColor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LightColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in MoveToCenter.
function MoveToCenter_Callback(hObject, eventdata, handles)
% hObject    handle to MoveToCenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MoveToCenter



function SignalThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to SignalThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SignalThreshold as text
%        str2double(get(hObject,'String')) returns contents of SignalThreshold as a double


% --- Executes during object creation, after setting all properties.
function SignalThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SignalThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SignalRatio_Callback(hObject, eventdata, handles)
% hObject    handle to SignalRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SignalRatio as text
%        str2double(get(hObject,'String')) returns contents of SignalRatio as a double
get(hObject,'String')

% --- Executes during object creation, after setting all properties.
function SignalRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SignalRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function OverlapImaging_Callback(hObject, eventdata, handles)
% hObject    handle to OverlapImaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OverlapImaging as text
%        str2double(get(hObject,'String')) returns contents of OverlapImaging as a double


% --- Executes during object creation, after setting all properties.
function OverlapImaging_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlapImaging (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PlanningLeftETLVoltage_Callback(hObject, eventdata, handles)
% hObject    handle to PlanningLeftETLVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PlanningLeftETLVoltage as text
%        str2double(get(hObject,'String')) returns contents of PlanningLeftETLVoltage as a double


% --- Executes during object creation, after setting all properties.
function PlanningLeftETLVoltage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PlanningLeftETLVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PlanningRightETLVoltage_Callback(hObject, eventdata, handles)
% hObject    handle to PlanningRightETLVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PlanningRightETLVoltage as text
%        str2double(get(hObject,'String')) returns contents of PlanningRightETLVoltage as a double


% --- Executes during object creation, after setting all properties.
function PlanningRightETLVoltage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PlanningRightETLVoltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SetCenter.
function SetCenter_Callback(hObject, eventdata, handles)
% hObject    handle to SetCenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SetCenter
 handles.my.CurrentLocation=[0 0];
 guidata(hObject,handles);
 handles.SetCenter.Value=0;
 

% --- Executes on button press in togglebutton39.
function togglebutton39_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton39


% --- Executes on button press in VisPlanning.
function VisPlanning_Callback(hObject, eventdata, handles)
% hObject    handle to VisPlanning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of VisPlanning
MagLow=str2num(handles.PlanningMag.String{handles.PlanningMag.Value}(1:end-1)); % Planning Magnification
MagImaging=str2num(handles.ImagingMag.String{handles.ImagingMag.Value}(1:end-1)); % Imaging Magnification
OverlapLowImaging=str2num(handles.OverlapPlanning.String); % Overlap of the low magnification imaging 
OverlapHighImaging=str2num(handles.OverlapImaging.String); % Overlap of the high magnifiation imaging


% The Grid Size is 2x2
SizeLowImaging=fix(2048*2-2048*OverlapLowImaging/100);
InputVolume=ones(SizeLowImaging,SizeLowImaging);
ImagingCenterLocation=size(InputVolume)/2;
DownfactorXY=1;
DownfactorZ=1;
CutoffSignal=0;
CutoffImaging=0.01;
[ImagingMatrix,StepStage,StartRowA,EndRowA,StartColumnA,EndColumnA,ResolutionProgramme,ResolutionImaging,EndRowAV,EndColumnAV]=FindImagingMatrix(InputVolume,DownfactorXY,DownfactorZ,MagLow,MagImaging,OverlapHighImaging,CutoffSignal,CutoffImaging);
figure
imshow(InputVolume)
hold on
PlotGrids(StartRowA,EndRowA,StartColumnA,EndColumnA,ImagingMatrix);
hold on;plot(ImagingCenterLocation(1),ImagingCenterLocation(2),'bo')

handles.my.ImagingMatrix=ImagingMatrix;
handles.my.StartRowA=StartRowA;
handles.my.EndRowA=EndRowA;
handles.my.StartColumnA=StartColumnA;
handles.my.EndColumnA=EndColumnA;
handles.my.EndColumnAV=EndColumnAV;
handles.my.EndRowAV=EndRowAV;
handles.VisPlanning.Value=0;
handles.ImagingCenterLocation=ImagingCenterLocation;
guidata(hObject,handles);




% --- Executes on button press in PriLoc.
function PriLoc_Callback(hObject, eventdata, handles)
% hObject    handle to PriLoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PriLoc
CurrentLocation=handles.my.CurrentLocation;
display(['CurrentLocation: [', num2str(CurrentLocation(1)),',',num2str(CurrentLocation(2)),']'])
handles.PriLoc.Value=0;
guidata(hObject,handles);

function MoveToLocation_Callback(hObject, eventdata, handles)
% hObject    handle to MoveToLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MoveToLocation as text
%        str2double(get(hObject,'String')) returns contents of MoveToLocation as a double
ImagingMatrix=handles.my.ImagingMatrix;
StartRowA=handles.my.StartRowA;
EndRowA=handles.my.EndRowAV;
StartColumnA=handles.my.StartColumnA;
EndColumnA=handles.my.EndColumnAV;
MoveToLocation=eval(handles.MoveToLocation.String);
CurrentLocation=handles.my.CurrentLocation;
ImagingCenterLocation=handles.ImagingCenterLocation;
classObj=handles.my.classObj;

SizeImagingMatrix=size(ImagingMatrix);
if mod(MoveToLocation(1),1) | mod(MoveToLocation(2),1)
  warning('Please Input A Integral Location. For example, [1 1]')
  return;
end
if all(CurrentLocation==0)
    CurrentImagingCenterLocation=ImagingCenterLocation;
else
    Ind=(CurrentLocation(1,1)-1)*SizeImagingMatrix(1)+CurrentLocation(1,2);
    CurrentImagingCenterLocation=[(StartRowA(Ind)+EndRowA(Ind))/2 (StartColumnA(Ind)+EndColumnA(Ind))/2 ];
end

if all(MoveToLocation==0)
    MoveToImagingCenterLocation=ImagingCenterLocation;
else
    Ind=(MoveToLocation(1,1)-1)*SizeImagingMatrix(1)+MoveToLocation(1,2);
    MoveToImagingCenterLocation=[fix((StartRowA(Ind)+EndRowA(Ind))/2) fix((StartColumnA(Ind)+EndColumnA(Ind))/2) ];
end

[Normalspeed, CutspeedReady, CutspeedCutting,Acceleration]=GetSpeed(handles);
TimeConstant=200;
MagLow=str2num(handles.PlanningMag.String{handles.PlanningMag.Value}(1:end-1));
MagResolutionLow=GetResolution(MagLow);
StepUnit=MagResolutionLow;
CurrentImagingCenterLocation=fix(CurrentImagingCenterLocation);
MoveToImagingCenterLocation=fix(MoveToImagingCenterLocation);
MoveToADestination(CurrentImagingCenterLocation,MoveToImagingCenterLocation,classObj,StepUnit,Normalspeed,Acceleration,TimeConstant);
handles.my.CurrentLocation=MoveToLocation;
handles.MoveToLocation.Value=0;
guidata(hObject,handles);




% --- Executes during object creation, after setting all properties.
function MoveToLocation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MoveToLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function OverlapPlanning_Callback(hObject, eventdata, handles)
% hObject    handle to OverlapPlanning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OverlapPlanning as text
%        str2double(get(hObject,'String')) returns contents of OverlapPlanning as a double


% --- Executes during object creation, after setting all properties.
function OverlapPlanning_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OverlapPlanning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TellLocation_Callback(hObject, eventdata, handles)
% hObject    handle to TellLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TellLocation as text
%        str2double(get(hObject,'String')) returns contents of TellLocation as a double
TellLocation=eval(handles.TellLocation.String);
handles.my.CurrentLocation=TellLocation;
guidata(hObject,handles);




% --- Executes during object creation, after setting all properties.
function TellLocation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TellLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CheckPlanning.
function CheckPlanning_Callback(hObject, eventdata, handles)
% hObject    handle to CheckPlanning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckPlanning


% --- Executes on button press in StartI.
function StartI_Callback(hObject, eventdata, handles)
% hObject    handle to StartI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of StartI
