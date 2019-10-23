function p = repdef(p, allow_non_existing)

%   REPDEF -- Define path to repositories directory.
%
%     repdef( directory ) defines the absolute path to a repositories 
%     `directory` (that is, a folder containing subfolders of code).
%
%     Subsequently, the `repadd` command (as in, `repadd(subfoldername)`)
%     can be used to add a subfolder of `directory` to Matlab's search
%     path.
%
%     repdef( '--default' ) or repdef --default defines the repositories
%     directory as the folder containing the `mpaths` repository.
%
%     repdef( ..., allow_non_existing ) indicates whether a non-existing
%     directory can be saved. Default is false -- an error is thrown if 
%     `directory` does not exist.
%
%     p = repdef(...) returns the saved directory path.
%
%     See also repdir, repfname, repadd

if ( nargin < 2 )
  allow_non_existing = false;
end

validateattributes( p, {'char'}, {'scalartext'}, mfilename, 'p' );
validateattributes( allow_non_existing, {'logical'}, {'scalar'}, mfilename ...
  , 'allow_non_existing' );

if ( strcmpi(p, '--default') )
  p = get_default_repo_dir();
end

if ( ~allow_non_existing )
  assert( exist(p, 'dir') == 7, ['Directory "%s" does not exist, and' ...
    , ' "allow_non_existing" flag is false.'], p );
end

save( repfname(), 'p' );

fprintf( '\nSaved "%s" as repositories folder\n\n', p );

end

function p = get_default_repo_dir()

parts = fileparts( which(mfilename) );
slash = get_slash();

split = strsplit( parts, slash );
split(cellfun(@isempty, split)) = [];

if ( numel(split) < 2 )
  error( 'Could not locate containing directory for directory "%s".', parts );
end

p = fullfile( split{1:end-1} );

if ( ~isempty(p) && p(1) ~= slash )
  p = [ slash, p ];
end

end

function slash = get_slash()

if ( ispc() )
  slash = '\';
else
  slash = '/';
end

end