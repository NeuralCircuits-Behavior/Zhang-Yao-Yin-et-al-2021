





Folder='I:\WholeBrainImaging\20170913_YFP_Copy\Stack_1\ChangeBrightness\Denoise\';


List=dir([Folder,'*tif']);

for i=1:length(List)
   file=[Folder List(i).name]; 
   changename=strrep(file,'_denoised','');
   if strcmp(file,changename)
       continue;
   end
   movefile(file,changename);
end