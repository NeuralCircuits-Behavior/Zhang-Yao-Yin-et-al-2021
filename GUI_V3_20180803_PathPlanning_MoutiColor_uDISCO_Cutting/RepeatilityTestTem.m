
%%
  classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
  Pos=classObj.gbAxisEnc(3);
  disp (Pos); 
  
  %%

  classObj.MoCtrCard_MCrlAxisRelMove(2,-1,1,1);

  
  %%
  classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
  Pos=classObj.gbAxisEnc(3);
  disp (Pos); 
  %%
   classObj.MoCtrCard_MCrlAxisRelMove(2,-1.03,0.1,0.1);
  
  
  %%
  
  classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
  Pos=classObj.gbAxisEnc(3);
  disp (Pos); 
  %%
classObj.MoCtrCard_MCrlAxisRelMove(2,2.03,1,1);

  
  %%
  
  classObj.MoCtrCard_GetEncoderVal(255, classObj.gbAxisEnc);
  Pos=classObj.gbAxisEnc(3);
  disp (Pos); 