function [portlightRight,portlightLeft,ChangeToBlueOpenRight,ChangeToBlueCloseRight, ChangeToYellowOpenRight,ChangeToYellowCloseRight,ChangeToRedOpenRight,ChangeToRedCloseRight,ChangeToBlueOpenLeft,ChangeToBlueCloseLeft,ChangeToYellowOpenLeft,ChangeToYellowCloseLeft,ChangeToRedOpenLeft,ChangeToRedCloseLeft]=getValueLight(handles)

    portlightRight=handles.my.portlightRight; 
    portlightLeft=handles.my.portlightLeft;
    ChangeToBlueOpenRight=handles.my.ChangeToBlueOpenRight;
    ChangeToBlueCloseRight=handles.my.ChangeToBlueCloseRight; 
    ChangeToYellowOpenRight=handles.my.ChangeToYellowOpenRight;
    ChangeToYellowCloseRight=handles.my.ChangeToYellowCloseRight;
    ChangeToRedOpenRight=handles.my.ChangeToRedOpenRight;
    ChangeToRedCloseRight=handles.my.ChangeToRedCloseRight;

    ChangeToBlueOpenLeft=handles.my.ChangeToBlueOpenLeft;
    ChangeToBlueCloseLeft=handles.my.ChangeToBlueCloseLeft;
    ChangeToYellowOpenLeft=handles.my.ChangeToYellowOpenLeft;
    ChangeToYellowCloseLeft=handles.my.ChangeToYellowCloseLeft;
    ChangeToRedOpenLeft=handles.my.ChangeToRedOpenLeft;
    ChangeToRedCloseLeft=handles.my.ChangeToRedCloseLeft;
end