function tf = repexists(name)

%   REPEXISTS -- True if repository exists.
%
%     repexists( 'example' ) returns true if 'example' is a repository
%     housed in the folder given by `repdir`, as defined by `repdef`.
%
%     See also repget, repdir, repdef
%
%     IN:
%       - `name` (char)
%     OUT:
%       - `tf` (logical)

tf = exist( repget(name), 'dir' ) == 7;

end