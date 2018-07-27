function repdef(p)

%   REPDEF -- Define path to repositories directory.
%
%     repdef( '~/Users/Repositories' ) saves a file 'mpaths.mat' in the
%     folder housing this function ('repdef.m'). The file contains the
%     string '~/Users/Repositories'.
%
%     repdef( '--default' ) or repdef --default defines the repositories
%     directory as the folder containing the `mpaths` repository.
%
%     See also repdir, repfname
%
%     IN:
%       - `p` (char)

assert( ischar(p), 'Path must be char; was "%s".', class(p) );

if ( strcmpi(p, '--default') )
  p = get_default_repo_dir();
end

save( repfname(), 'p' );

fprintf( '\nSaved "%s" as repositories folder\n\n', p );

end

function p = get_default_repo_dir()

parts = fileparts( which(mfilename) );
slash = get_slash();

split = strsplit( parts, slash );

if ( numel(split) < 2 || any(cellfun(@isempty, split)) )
  error( 'Could not locate containing directory for directory "%s".', parts );
end

p = fullfile( split{1:end-1} );

end

function slash = get_slash()

if ( ispc() )
  slash = '\';
else
  slash = '/';
end

end