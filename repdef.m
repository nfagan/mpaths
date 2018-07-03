function repdef(p)

%   REPDEF -- Define path to repositories directory.
%
%     repdef( '~/Users/Repositories' ) saves a file 'mpaths.mat' in the
%     folder housing this function ('repdef.m'). The file contains the
%     string '~/Users/Repositories'.
%
%     See also repdir, repfname
%
%     IN:
%       - `p` (char)

assert( ischar(p), 'Path must be char; was "%s".', class(p) );

f = repfname();

save( f, 'p' );

fprintf( '\nSaved "%s" as repositories folder\n\n', p );

end