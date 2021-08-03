
function Resolution=GetResolution(Mag)

if Mag==0.63
   Resolution=5.1760;  % resolution in the programmed magnification. um/pixel 
elseif Mag==0.8
   Resolution=4.0717;
elseif Mag==1
   Resolution=3.2637;
elseif Mag==1.25
   Resolution=2.6042;
elseif Mag==1.6
   Resolution=2.04;
elseif Mag==2
   Resolution=1.6372;
elseif Mag==2.5
   Resolution=1.3082;
elseif Mag==3.2
   Resolution=1.02;
elseif Mag==4
    Resolution=0.8114;
elseif Mag==5
    Resolution=0.6435;
elseif  Mag==6.3
    Resolution=0.5160;   
end





end

