
function Destripe(Folder)
    %the input folder
%     Folder = '\\DISKSATION\Data\LightSheetRelated\Image A Brain\20170711_DiI_Coronal\2x\';
    %the output folder
    output = [Folder,'\Denoise\'];
    mkdir(output)
    list=dir([Folder,'*tif']);
    % MIJ.setBatchMode(true); 
    for i= 1:length(list)  % (i = 0;i<list.length;i++)
    %     InputFileFullName=[Folder, 'Section_',num2str(i),'.tif'];
        InputFileFullName=[Folder, list(i).name];
        inputfileName=strrep(list(i).name,'.tif','');
        SaveName=[output,inputfileName,'.tif'];
        denoiseImage(InputFileFullName,SaveName);
    end    
end