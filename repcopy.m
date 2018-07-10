function p = repcopy(rep)

%   REPCOPY -- Copy repository path to clipboard.
%
%     repcopy( REPOSITORY ) copies the absolute path to `REPOSITORY` to the
%     clipboard.
%
%     p = repcopy(...) also returns the copied path.
%
%     See also repget, repdir, repdef
%
%     IN:
%       - `rep` (char)
%     OUT:
%       - `p` (char)

p = repget( rep );
clipboard( 'copy', p );

end