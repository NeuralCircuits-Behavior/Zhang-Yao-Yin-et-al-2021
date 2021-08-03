
LineInterval=15; %us
Exposure=10; % ms

% VoltageTrainLeft=[1 2 3 ];
VoltageTrainLeft=VoltageSampledLeftN; %2.1:0.1:3.6;
% VoltageTrainRight=3.6:-0.1:2.1;
VoltageTrainRight=VoltageSampledRightN; %3.7:-0.1:3.2;


%% link trigger channel 1
ProgramPulsePalParam(1, 12, 1); % 'LinkedToTriggerCH1';
ProgramPulsePalParam(2, 12, 1); 
ProgramPulsePalParam(3, 12, 1); 
ProgramPulsePalParam(4, 12, 0); 
% ProgramPulsePalParam(1,128,0); % 128 (Trigger mode, 0 = normal, 1 = toggle, 2 = pulse-gated) 
ProgramPulsePalParam(1,128,0);
ProgramPulsePalParam(2,128,0);




%% set cameral voltage train, channel 3

Phase1Duration=0.001;
InterPulseInterval=0;
BurstDuration=Phase1Duration;
DelayC=0;

ProgramPulsePalParam(3, 1, 0); % 1 (Biphasic pulse (0 = monophasic, 1 = biphasic)
% ProgramPulsePalParam(3, 3, 2); % 2 (Phase 1 voltage, Volts, -10 to +10)
ProgramPulsePalParam(3, 4, Phase1Duration); % 4 (Phase 1 duration, Seconds, 0.0001-3600)
ProgramPulsePalParam(3, 7, InterPulseInterval);% 7 (Inter-pulse interval, Seconds)
ProgramPulsePalParam(3, 8, BurstDuration) ; % 8 (Burst duration, Seconds)
ProgramPulsePalParam(3, 10, BurstDuration);% 10 (Pulse train duration, Seconds)
ProgramPulsePalParam(3, 11, DelayC);% 11 (Pulse train delay, Seconds)


% % Channel 4
Phase1Duration=0.001;
InterPulseInterval=0;
BurstDuration=Phase1Duration;
DelayC=0;

ProgramPulsePalParam(4, 1, 0); % 1 (Biphasic pulse (0 = monophasic, 1 = biphasic)
% ProgramPulsePalParam(3, 3, 2); % 2 (Phase 1 voltage, Volts, -10 to +10)
ProgramPulsePalParam(4, 4, Phase1Duration); % 4 (Phase 1 duration, Seconds, 0.0001-3600)
ProgramPulsePalParam(4, 7, InterPulseInterval);% 7 (Inter-pulse interval, Seconds)
ProgramPulsePalParam(4, 8, BurstDuration) ; % 8 (Burst duration, Seconds)
ProgramPulsePalParam(4, 10, BurstDuration);% 10 (Pulse train duration, Seconds)
ProgramPulsePalParam(4, 11, DelayC);% 11 (Pulse train delay, Seconds)



% set resting potential
ProgramPulsePalParam(1,17,VoltageTrainRight(1))
ProgramPulsePalParam(2,17,VoltageTrainLeft(1))


% ProgramPulsePalParam(2,17,4.1)
%% SendWaveForm

AImageTime=Exposure+LineInterval/1000*2048; % ms
AImageTime=AImageTime/1000; % s

EachPulseTimeLeft=AImageTime/length(VoltageTrainLeft);
EachPulseTimeRight=AImageTime/length(VoltageTrainRight);
EachPulseTimeLeft=fix(EachPulseTimeLeft/0.001)*0.001;
EachPulseTimeRight=fix(EachPulseTimeRight/0.001)*0.001;

ProgramPulsePalParam(1, 11, 0);% 11 (Pulse train delay, Seconds)
ProgramPulsePalParam(2, 11, 0);% 11 (Pulse train delay, Seconds)

ProgramPulsePalParam(1, 14, 1); % Sets output channel 1 to use custom train 1
ProgramPulsePalParam(2, 14, 2); % Sets output channel 2 to use custom train 2


% Add first voltage
% VoltageTrainRight=[ VoltageTrainRight repmat(VoltageTrainRight(1), [1,3000])];
% VoltageTrainLeft=[ VoltageTrainLeft repmat(VoltageTrainLeft(1), [1,3000])];

SendCustomWaveform(1, EachPulseTimeRight, VoltageTrainRight);
SendCustomWaveform(2, EachPulseTimeLeft, VoltageTrainLeft);


%% Trigger PulsePal to start imaging
% SetPulsePalVoltage(4,3);
% pause(0.01)
% SetPulsePalVoltage(4,0);
% TriggerPulsePal([4])

