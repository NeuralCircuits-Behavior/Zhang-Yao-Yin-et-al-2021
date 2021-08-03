
% 
% VoltageSampledLeft=[2.0]; % from small to big
% VoltageSampledRight=[1]; % from big to small
%SetPulsePalVoltage(1,2.4);
DC1=0.001; % delay(s) between giving voltage and starting exposure, for the camera. 
DE1=0.001; % delay(s) between giving voltage and reaching stable state of the ETL.
Exposure=0.02 ; % cameral exposure time

%% link trigger channel 1
ProgramPulsePalParam(1, 12, 1); % 'LinkedToTriggerCH1';
ProgramPulsePalParam(2, 12, 1); 
ProgramPulsePalParam(3, 12, 1); 

ProgramPulsePalParam(1,128,0); % 128 (Trigger mode, 0 = normal, 1 = toggle, 2 = pulse-gated) 
ProgramPulsePalParam(2,128,0);
%% set trigger snap voltage, channel 4
ProgramPulsePalParam(4, 1, 0); % 1 (Biphasic pulse (0 = monophasic, 1 = biphasic)
% ProgramPulsePalParam(3, 3, 2); % 2 (Phase 1 voltage, Volts, -10 to +10)
ProgramPulsePalParam(4, 4, 0.0050); % 4 (Phase 1 duration, Seconds, 0.0001-3600)
ProgramPulsePalParam(4, 7, 0);% 7 (Inter-pulse interval, Seconds)
ProgramPulsePalParam(4, 8, 0.0050) ; % 8 (Burst duration, Seconds)
ProgramPulsePalParam(4, 10, 0.0050);% 10 (Pulse train duration, Seconds)
ProgramPulsePalParam(4, 11, 0);% 11 (Pulse train delay, Seconds)


%% set cameral voltage train, channel 3
SnapNumber=length(VoltageSampledLeftN);
Phase1Duration=0.005;
InterPulseInterval=Exposure+DC1-Phase1Duration+DE1-DC1;
BurstDuration=(Phase1Duration+InterPulseInterval)*SnapNumber;
DelayC=DE1-DC1;

ProgramPulsePalParam(3, 1, 0); % 1 (Biphasic pulse (0 = monophasic, 1 = biphasic)
% ProgramPulsePalParam(3, 3, 2); % 2 (Phase 1 voltage, Volts, -10 to +10)
ProgramPulsePalParam(3, 4, Phase1Duration); % 4 (Phase 1 duration, Seconds, 0.0001-3600)
ProgramPulsePalParam(3, 7, InterPulseInterval);% 7 (Inter-pulse interval, Seconds)
ProgramPulsePalParam(3, 8, BurstDuration) ; % 8 (Burst duration, Seconds)
ProgramPulsePalParam(3, 10, BurstDuration);% 10 (Pulse train duration, Seconds)
ProgramPulsePalParam(3, 11, DelayC);% 11 (Pulse train delay, Seconds)



%% set ETL voltage train
ProgramPulsePalParam(1, 11, 0);% 11 (Pulse train delay, Seconds)
ProgramPulsePalParam(2, 11, 0);% 11 (Pulse train delay, Seconds)

ProgramPulsePalParam(1, 14, 1); % Sets output channel 1 to use custom train 1
ProgramPulsePalParam(2, 14, 2); % Sets output channel 2 to use custom train 2
EachPulseTime=Exposure+DE1;

% AddSuffixRight=repmat(VoltageSampledRight(1),[1,3000]); 
% AddSuffixLeft=repmat(VoltageSampledLeft(1),[1,3000]);     
% VoltageSampledRight=[VoltageSampledRight AddSuffixRight];
% VoltageSampledLeft=[VoltageSampledLeft AddSuffixLeft];

SendCustomWaveform(1, EachPulseTime, VoltageSampledRightN);
SendCustomWaveform(2, EachPulseTime, VoltageSampledLeftN);






% % Exposure  10 ms
% % LineIntervel 10 us  20    30      40       50     60     70     80
% % FrameRate    32.7   19.55  13.94   10.83    8.86   7.49   6.49  5.73

% % Exposure  10 ms
% % LineIntervel 90 us   100     110    120      150    200    300   500
% % FrameRate    5.12     4.63    4.23   3.89     3.14    2.37  1.59  0.96

%   1000/(500*2048/1000+10)

