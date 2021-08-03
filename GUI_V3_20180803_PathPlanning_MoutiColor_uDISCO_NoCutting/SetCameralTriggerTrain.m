
%% link trigger channel 1
ProgramPulsePalParam(1, 12, 0); % 'LinkedToTriggerCH1';
ProgramPulsePalParam(2, 12, 0); 
ProgramPulsePalParam(3, 12, 0); 
ProgramPulsePalParam(4, 12, 0); 

ProgramPulsePalParam(1, 13, 0); % 'LinkedToTriggerCH2';
ProgramPulsePalParam(2, 13, 0); 
ProgramPulsePalParam(3, 13, 0); 
ProgramPulsePalParam(4, 13, 0); 


ProgramPulsePalParam(1,128,0); % 128 (Trigger mode, 0 = normal, 1 = toggle, 2 = pulse-gated) 
ProgramPulsePalParam(2,128,0);


ProgramPulsePalParam(1, 11, 0);% 11 (Pulse train delay, Seconds)
ProgramPulsePalParam(2, 11, 0);% 11 (Pulse train delay, Seconds)


%% set trigger snap voltage, channel 4
ProgramPulsePalParam(4, 1, 0); % 1 (Biphasic pulse (0 = monophasic, 1 = biphasic)
% ProgramPulsePalParam(3, 3, 2); % 2 (Phase 1 voltage, Volts, -10 to +10)
ProgramPulsePalParam(4, 4, 0.0010); % 4 (Phase 1 duration, Seconds, 0.0001-3600)
ProgramPulsePalParam(4, 7, 0);% 7 (Inter-pulse interval, Seconds)
ProgramPulsePalParam(4, 8, 0.0010) ; % 8 (Burst duration, Seconds)
ProgramPulsePalParam(4, 10, 0.0010);% 10 (Pulse train duration, Seconds)
ProgramPulsePalParam(4, 11, 0);% 11 (Pulse train delay, Seconds)


%% set cameral voltage train, channel 3
ProgramPulsePalParam(3, 1, 0); % 1 (Biphasic pulse (0 = monophasic, 1 = biphasic)
% ProgramPulsePalParam(3, 3, 2); % 2 (Phase 1 voltage, Volts, -10 to +10)
ProgramPulsePalParam(3, 4, 0.0010); % 4 (Phase 1 duration, Seconds, 0.0001-3600)
ProgramPulsePalParam(3, 7, 0);% 7 (Inter-pulse interval, Seconds)
ProgramPulsePalParam(3, 8, 0.0010) ; % 8 (Burst duration, Seconds)
ProgramPulsePalParam(3, 10, 0.0010);% 10 (Pulse train duration, Seconds)
ProgramPulsePalParam(3, 11, 0);% 11 (Pulse train delay, Seconds)


