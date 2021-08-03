function varargout = subsFileExt(vcFile, varargin)
%substitute the extension part of the file
for i=1:numel(varargin)
    vcExt = varargin{i};
    [vcDir, vcFile1, ~] = fileparts(vcFile);
    if isempty(vcDir)
        varargout{i} = [vcFile1, vcExt];
    else
        varargout{i} = [vcDir, filesep(), vcFile1, vcExt];
    end
end
end %func