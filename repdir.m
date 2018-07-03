function p = repdir()

%   REPDIR -- Get the path to the repositories path definition.
%
%     An error is thrown if the file has not yet been defined.
%
%     See also repfname
%
%     OUT:
%       - `p` (char)

f = repfname();

if ( exist(f, 'file') == 0 )
  error( 'Repository path has not been defined; see `repdefine`.' );
end

p = dload( f );

end

function x = dload(p)
x = load( p );
x = x.(char(fieldnames(x)));
end