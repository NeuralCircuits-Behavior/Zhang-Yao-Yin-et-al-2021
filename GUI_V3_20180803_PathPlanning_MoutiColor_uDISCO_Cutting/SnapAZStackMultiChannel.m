% Snap a stack of images. 
% YX, 20170903

if s~=Zstacks
    ZImages=SlicesPerStack;
else
    ZImages=SlicesLastStack;
end

if Zdirection>0
    TranslationZ=TranslationZP;
else
    TranslationZ=TranslationZN;
end

SnapLightTransfer;
for z=1:ZImages-1
    classObj.MoCtrCard_MCrlAxisRelMove(2,TranslationZ,Normalspeed,Acceleration);
    pause(SleepTime2Z);
    SnapLightTransfer;
end
Zdirection=-1*Zdirection;



