% Snap a stack of images of single light. Only for left light or right light seperately
% Using motor control instead of the grating ruler.

if s~=Zstacks
    ZImages=SlicesPerStack;
else
    ZImages=SlicesLastStack;
end


SnapBlue;
SnapYellow;
SnapRed;


