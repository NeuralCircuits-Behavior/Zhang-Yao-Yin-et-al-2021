function AdJustFocus(handles,MoveDistance,MoveDirection)

%	We have signed a confidentiality agreement with Olympus China regarding the realization of automatic zoom. 
%	SDK information and control instructions for SZX2-FOA, SZX2-MDCU and SZX-MDHSW will not be disclosed for the time being. 
%	Therefore, the control instruction codes are replaced with "XXX" in the scripts. For more information, please contact Olympus China.
% MoveDirection, 1 up, -1 down
SZX2=handles.my.SZX2;

pause(1)
if MoveDirection==1
    MoveString=['XXX' 'XXX' num2str(MoveDistance)]; %Focus plane goes up
elseif MoveDirection==-1
    MoveString=['XXX' 'XXX' num2str(MoveDistance)]; %Focus plane goes down
end
fprintf(SZX2, '%s\r\n', MoveString);

end
