function cellstr2file(vcFile, csLines)
% read text file to a cell string
fid = fopen(vcFile, 'w');
for i=1:numel(csLines)
    fprintf(fid, '%s\n', csLines{i});
end
fclose(fid);
end