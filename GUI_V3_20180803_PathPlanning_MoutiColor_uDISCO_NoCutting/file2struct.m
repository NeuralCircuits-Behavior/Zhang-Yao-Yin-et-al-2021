function P = file2struct(vcFile_file2struct)
% any files can be run as .m script file and result saved to a struct P
% _prm and _prb can now be called .prm and .prb files

if ~exist(vcFile_file2struct, 'file')
    fprintf(2, '%s does not exist.\n', vcFile_file2struct);
    P = [];
    return;
end

% load text file
fid=fopen(vcFile_file2struct, 'r');
csCmd = textscan(fid, '%s', 'Delimiter', '\n');
fclose(fid);
csCmd = csCmd{1};

% parse command
for iCmd=1:numel(csCmd)
    try
        vcLine1 = strtrim(csCmd{iCmd});
        if isempty(vcLine1), continue; end
        if find(vcLine1=='%', 1, 'first')==1, continue; end
        iA = find(vcLine1=='=', 1, 'first');
        if isempty(iA), continue; end            
        iB = find(vcLine1=='(', 1, 'first');
        if ~isempty(iB) && iB<iA, iA=iB; end
        eval(vcLine1);
        vcVar1 = strtrim(vcLine1(1:iA-1));
        eval(sprintf('P.(vcVar1) = %s;', vcVar1));
    catch
        fprintf(2, lasterr);
    end
end %for
end %func

% vcTemp = sprintf('temp_jrclust_%d', round(rand()*1e6));
% copyfile(vcFile_file2struct, [vcTemp, '.m'], 'f');
% % clear vcFile; %remove this variable
% try
%     eval(vcTemp);
% catch
%     disp(lasterror());
%     error(['Error in ', vcFile_file2struct]);
% end
% 
% eval(['save ', vcTemp]);
% P = load(vcTemp);
% 
% % delete temp files
% warning off;
% waitfor_jjj(.1);
% delete([vcTemp, '.mat']);
% delete([vcTemp, '.m']);