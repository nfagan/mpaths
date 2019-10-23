function p = repget(name)

%   REPGET -- Get full path to repository.
%
%     repget( 'example' ) gets the full path to repository 'example'. The
%     folder containing 'example' is given as `repdir()`, as defined by
%     `repdef()`.
%
%     See also repadd, repdir
%
%     IN:
%       - `name` (char)
%     OUT:
%       - `p` (char)

validateattributes( name, {'char', 'string'}, {'scalartext'}, mfilename, 'name' );

p = fullfile( repdir(), char(name) );

end