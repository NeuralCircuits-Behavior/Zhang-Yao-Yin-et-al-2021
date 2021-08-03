function csLines = file2cellstr(vcFile)
% read text file to a cell string
fid = fopen(vcFile, 'r');
csLines = {};
while ~feof(fid)
    csLines{end+1} = fgetl(fid);
end
csLines = csLines';
fclose(fid);