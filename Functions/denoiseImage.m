function denoiseImage(inputfile,SaveName)
      OpenCommander=['path=[' inputfile ']'];
      MIJ.run('Open...', OpenCommander);
      MIJ.run('VSNR_Macro_2D', 'where=[Text File (.txt)] choose=[F:\\Projects\\Log.txt]');
      SaveCommander=['save=','[',SaveName,']'];
      SaveCommander=strrep(SaveCommander,'\','\\');
      for i=1:3
          FileName=MIJ.getCurrentTitle;
          if all(FileName=='Denoised Image')
              MIJ.run('Save', SaveCommander);
              MIJ.run('Close')
%               break
          else
              MIJ.run('Close')
          end
      end
end