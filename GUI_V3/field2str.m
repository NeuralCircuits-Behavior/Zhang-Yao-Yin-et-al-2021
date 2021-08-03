function vcStr = field2str(val)
% if isempty(val), vcStr = '[]'; return; end

switch class(val)
    case {'int', 'int16', 'int32', 'uint16', 'uint32'}
        vcFormat = '%d';
    case {'double', 'float'}
        if numel(val)==1 && mod(val(1),1)==0
            vcFormat = '%d';
        else
            vcFormat = '%g';
        end
    case {'char','datetime'}
        vcStr = sprintf('''%s''', val); 
        return;
    case 'cell'
        vcStr = '{';
        for i=1:numel(val)
            vcStr = [vcStr, field2str(val{i})];
            if i<numel(val), vcStr = [vcStr, ', ']; end
        end
        vcStr = [vcStr, '}'];
        return;
end

if numel(val) == 1
    vcStr = sprintf(vcFormat, val);
else
    vcStr = '[';
    for i=1:numel(val)
        vcStr = [vcStr, field2str(val(i))];
        if i<numel(val), vcStr = [vcStr, ', ']; end
    end
    vcStr = [vcStr, ']'];
end
end %func