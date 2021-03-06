function tf = package(name, preserve_toolbox_dir)

%   PACKAGE -- True if a package namespace is on the search path.
%
%     tf = isonpath.package( name ); returns true if `name` is a top-level
%     package namespace on Matlab's search path, excluding packages in 
%     Matlab's toolbox directory.
%
%     tf = isonpath.package( ..., preserve_toolbox_dir ); indicates whether
%     to include Matlab's toolbox directory in the list of searchable
%     paths. Default is false.
%
%     EX // 
%
%     isonpath.package( 'matlab' );       % false
%     isonpath.package( 'matlab', true ); % true
%
%     See also isonpath.file, repadd

if ( nargin < 2 )
  preserve_toolbox_dir = false;
end

if ( ischar(name) )
  tf = check( name, preserve_toolbox_dir );
else
  tf = cellfun( @(x) check(x, preserve_toolbox_dir), name );
end

end

function tf = check(name, preserve_toolbox_dir)

persistent folder_cache;

tf = false;

if ( isempty(name) )
  return
end

if ( name(1) == '+' )
  search_for = name;
else
  search_for = sprintf( '+%s', name );
end

if ( ~isa(folder_cache, 'containers.Map') )
  folder_cache = containers.Map();
end

p = get_path( preserve_toolbox_dir );

if ( folder_cache.isKey(name) )
  cache_info = folder_cache(name);
  
  if ( cache_info.exists && ismember(cache_info.package_dir, p) )
    % This package existed the last time we checked, and its directory is
    % present in the current path.
    tf = true;
    return
  elseif ( ~cache_info.exists && isequal(p, cache_info.path) )
    % This package did not exist the last time we checked, and the current
    % path is the same as when we last checked -- so it can't exist.
    return
  end
end

is_high_likelihood = contains( p, name );
likely = p(is_high_likelihood);
unlikely = p(~is_high_likelihood);

if ( perform_search(likely, name, search_for, folder_cache) )
  tf = true;
  return
elseif ( perform_search(unlikely, name, search_for, folder_cache) )
  tf = true;
  return
end

folder_cache(name) = make_folder_cache_entry( false, '', p );

end

function tf = perform_search(p, name, search_for, cache)

tf = false;

for i = 1:numel(p)
  package_p = fullfile( p{i}, search_for );
  
  if ( dir_exists(package_p) )
    cache(name) = make_folder_cache_entry( true, p{i}, p );
    tf = true;
    return;
  end
end

end

function entry = make_folder_cache_entry(exists, dir, path)

entry = struct( 'exists', exists, 'package_dir', dir, 'path', {path} );

end

function tf = dir_exists(p)

tf = exist( p, 'dir' );

end

function p = get_path(preserve_toolbox_dir)

p = strsplit( path(), pathsep() );

if ( ~preserve_toolbox_dir )
  is_toolbox = contains( p, toolboxdir('') );
  p(is_toolbox) = [];
end

end