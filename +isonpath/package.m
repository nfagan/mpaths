function tf = package(name)

%   PACKAGE -- True if a package namespace is on the search path.
%
%     tf = isonpath.package( name ); returns true if `name` is a top-level
%     package namespace on Matlab's search path.
%
%     See also isonpath.file, repadd

if ( ischar(name) )
  tf = check( name );
else
  tf = cellfun( @check, name );
end

end

function tf = check(name)

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

p = get_path();

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

function p = get_path()

p = strsplit( path(), pathsep() );
is_toolbox = contains( p, toolboxdir('') );
p(is_toolbox) = [];

end