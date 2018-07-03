function p = repget(name)

%   REPGET -- Get full path to repository.
%
%     repadd( 'example' ) gets the full path to repository 'example'. The
%     folder containing 'example' is given as `repdir()`, as defined by
%     `repdef()`.
%
%     IN:
%       - `name` (char)
%     OUT:
%       - `p` (char)

assert( ischar(name), 'Name must be char; was "%s".', class(name) );

p = fullfile( repdir(), name );

end