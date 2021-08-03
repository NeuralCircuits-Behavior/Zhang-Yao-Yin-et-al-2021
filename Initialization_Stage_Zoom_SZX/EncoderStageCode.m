
a=get(0,'UserData')
classObj=a.classObj
%% Initialized file, make sure the right DLL file is used,and the serial port number must be right.
% NET.addAssembly('C:\Program Files\MATLAB\R2016b\bin\MCC6DLL_GetComDiff_2.dll');
% NET.addAssembly('C:\Program Files\MATLAB\R2016b\bin\MCC6DLL_0418.dll');
NET.addAssembly('C:\Program Files\MATLAB\R2016b\bin\MCC6DLL_0425.dll');
classObj = SerialPortLibrary.SPLibClass();
classObj.MoCtrCard_Initial('COM30');% serial port parameter: (115200,N,8,1)
disp(ans); % ans=1, successful; ans=2,failing.

%% Move control. Axis number: X-0; Y-1; Z-2. MaxSpeed:20,MaxAcceleration:20.
 % Relative motion
  classObj.MoCtrCard_MCrlAxisRelMove(0,1);%(Axis,RelativePosition).
  classObj.MoCtrCard_MCrlAxisRelMove(2,-0.3,5,5);%(Axis,RelativePosition).
  classObj.MoCtrCard_MCrlAxisRelMove(2,-1.005,5,5);
  classObj.MoCtrCard_MCrlAxisRelMove(2,1.008,0.1,0.1);%(Axis,RelativePosition,Speed,Acceleration).
  classObj.MoCtrCard_MCrlAxisMove(0,-1);%(Axis,Orientation),the distance is fixed. 
 % Absolute motion
  classObj.MoCtrCard_MCrlAxisAbsMove(2,2);%(Axis,AbsolutePosition).
  classObj.MoCtrCard_MCrlAxisAbsMove (2,10,20,20);%(Axis,AbsolutePosition,Speed,Acceleration).
 % Stop control_1
  classObj.MoCtrCard_EmergencyStopAxisMov(2); % Emergency stop Axis move.
  classObj.MoCtrCard_ParaStopAxisMov(2,10);% (Axis,Acceleration)Stop Axis move slowly.
 % Stop control_2. Not used frequently, the ReStartAxisMov() has a bug.
  classObj.MoCtrCard_PauseAxisMov(0);
  classObj.MoCtrCard_ReStartAxisMov(0);
 % Reset to zero
  classObj.MoCtrCard_ResetCoordinate(0,0.0);%(Axis,0.0),Reset Coordinate to zero.
  classObj.MoCtrCard_SetEncoderPos(0,0);%(Axis,EncoderPos),Reset EncoderPosition to zero.
  %classObj.MoCtrCard_ClearInternalPulseCount();%(Axis),?????????.
 % SeekZero. Not used frequently.
  classObj.MoCtrCard_SeekZero(2);%SeekZero
  classObj.MoCtrCard_SeekZero (2,5,5);%SeekZero(Axis,Speed<20,Acceleration<20)
 % Open debug windows
  classObj.MoCtrCard_OpenSpDebugForm();% Open debug windows
  
%% Indicates the Axis Absolute Position. 1-X,2-Y,3-Z.
  classObj.MoCtrCard_GetAxisPos(255, classObj.gbAxisPos);
  Pos1=classObj.gbAxisPos(3);
  disp (Pos1); % The number is from the input CommandPosition. Unit: mm.
  
  
  
  %%
  % x axis
  classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
  Pos=classObj.gbAxisEnc(1);
  %  Pos = double(Pos)/1000; % The number is from the EncoderPositon, conver it to AbsolutePosition, 1 pulse is 1um.
  disp (Pos); %Unit: mm.
  
  % y axis
  classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
  Pos=classObj.gbAxisEnc(2);
  %  Pos = double(Pos)/1000; % The number is from the EncoderPositon, conver it to AbsolutePosition, 1 pulse is 1um.
  disp (Pos); %Unit: mm.
  % z axis  
    classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
  Pos=classObj.gbAxisEnc(3 );
  %  Pos = double(Pos)/1000; % The number is from the EncoderPositon, conver it to AbsolutePosition, 1 pulse is 1um.
  disp (Pos); %Unit: mm.
      


%  clear PulsePalSystem PulsePalSystemNew
  
%% Indicates the Axis State, Moving or Stopped. 0-stopped,1-Moving.
tic
  ttt = ones (1, 4, 'uint32');
  classObj.MoCtrCard_GetRunState(ttt);
  classObj.gbRunState;
  MovState = bitget(classObj.gbRunState,11); 
  toc
  %returns the bit value at position 11 bit in gbRunState.
  % X-3,Y-7,Z-11.
  disp(MovState);
  
 %% encoder or non-encoder choice
   classObj.MoCtrCard_EnableCompensateFunction (2);
   classObj.MoCtrCard_DisableCompensateFunction (2);
 %% The difference between and CommandPosition and EncoderPosition,No Plus-Minus. 
    % Not used frequently.
   classObj.MoCtrCard_GetComDiff(2,classObj.gbComDiff);% Axis: 0-X, 1-Y,2-Z.
   Diff=classObj.gbComDiff(3);% Parameter: 1-X,2-Y,3-Z.
   disp (Diff); % Unit:um, No plus-minus
   %%
   classObj.MoCtrCard_MCrlAxisRelMoveAndPulse(2,1,3,1,0.002,0.002,...
     0.07,0.005,10);
 

 
 
 
 
 
 
 
 
 
  