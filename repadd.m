function p = repadd(name, recursive)

%   REPADD -- Add repository to path.
%
%     repadd( 'example' ) adds repository 'example' to the search path. The
%     folder containing 'example' is given as `repdir()`, as defined by
%     `repdef()`.
%
%     p = repadd( ... ) returns the full path to 'example'.
%
%     repadd( ..., RECURSIVE ) specifies whether to recursively add
%     subfolders of `P`. Default is false -- only the outer folder `P` is
%     added.
%
%     See also repdef, repdir
%
%     IN:
%       - `name` (char)
%       - `recursive` (logical) |OPTIONAL|
%     OUT:
%       - `p` (char)

if ( nargin < 2 ), recursive = false; end

p = repget( name );

if ( recursive ), p = genpath( p ); end

addpath( p );

end