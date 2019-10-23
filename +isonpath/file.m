function tf = file(name)

%   FILE -- True if an mfile is found on the search path.
%
%     tf = isonpath.file( name ); returns true if `name` is a function,
%     class, or m-file found on Matlab's search path.
%
%     See also isonpath.package, repadd

if ( ischar(name) )
  tf = ~isempty( which(name) );
else
  tf = cellfun( @(x) ~isempty(which(x)), name );
end

end