

function  CurrentImagingCenterLocation=GetCenterLocation(CurrentLocation,StartRowA,EndRowAV,StartColumnA,EndColumnAV,SizeImagingMatrix)
   
Ind=(CurrentLocation(1,1)-1)*SizeImagingMatrix(1)+CurrentLocation(1,2);
CurrentImagingCenterLocation=[(StartRowA(Ind)+EndRowAV(Ind))/2 (StartColumnA(Ind)+EndColumnAV(Ind))/2 ];

end
