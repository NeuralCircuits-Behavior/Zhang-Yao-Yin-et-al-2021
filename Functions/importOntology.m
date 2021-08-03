function ont = importOntology(fn)

fid = fopen(fn);
cnt = 0;
while ~feof(fid)
    str = fgetl(fid);
    cnt = cnt + 1;
end
fclose(fid);

id = zeros(cnt, 1);
info = cell(cnt, 1);

fid = fopen(fn);
cnt = 0;
while ~feof(fid)
    str = fgetl(fid);
    cnt = cnt + 1;
    
    inds = strfind(str, ',');
    
    if ~isempty(inds)
    
    id(cnt) = str2double(str(1:inds(1)-1));
    temp = str(inds(1)+1:end);
    
    temp = temp(temp~='"');
    info{cnt} = temp;
    end

end
fclose(fid);

ont.name = info;
ont.id = id;