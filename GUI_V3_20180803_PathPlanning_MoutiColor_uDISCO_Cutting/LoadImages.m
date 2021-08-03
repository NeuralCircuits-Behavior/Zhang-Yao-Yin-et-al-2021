% Suppose imaging matrix was 2x2 with a order from the topleft, topright,
% downright, downleft

function InputVolumn=LoadImages(SaveFolder,OverLapLowMag)
   LastImageNum=DetectLastImageNum(SaveFolder);
   n=0;
   for i=LastImageNum:-1:LastImageNum-3
       n=n+1;
       ImageName=[SaveFolder 'Image1_' num2str(i) '.tif'];
       Im(:,:,n)=loadTifFast(ImageName);
   end
   
   
   OverLapPix=fix(2048*OverLapLowMag);
   RemainingPix=2048-OverLapPix;
   InputVolumn=zeros(2048+RemainingPix,2048+RemainingPix);
   
   InputVolumn(1:2048,1:2048)=Im(:,:,4);
   InputVolumn(1:2048,2049:end)=Im(:,OverLapPix+1:end,3);
   
   InputVolumn(2049:end,1:2048)=Im(OverLapPix+1:end,:,1);
   InputVolumn(2049:end,2049:end)=Im(OverLapPix+1:end,OverLapPix+1:end,2);
   
end
