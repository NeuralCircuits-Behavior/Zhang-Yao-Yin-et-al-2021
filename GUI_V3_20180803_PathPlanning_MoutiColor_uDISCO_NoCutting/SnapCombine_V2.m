
% SnapCombine(VoltageSampled,Light) Light: 1 right, 2 left
% use IJ.save to snap a image. The cameral should be live mode.
function SnapCombine_V2(VoltageSampled,Light,IJ,gui,Folder,Color,ExposureNumber,namei,j,k)

     for V=1:length(VoltageSampled)
         SetPulsePalVoltage(Light,VoltageSampled(V));
         gui.sleep(1000);
         FileName=[Folder,Color,'_',num2str(k),'_',num2str(ExposureNumber),'_',num2str(namei),'_',num2str(j),'_',num2str(V),'.tif'];
         IJ.saveAs('Tiff', FileName)
     end
end   

















