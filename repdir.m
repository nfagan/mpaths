function p = repdir()

%   REPDIR -- Get the path to the repositories directory.
%
%     An error is thrown if the file containing the repositories path
%     has not yet been defined. In this case, use `repdef` to define it.
%
%     See also repdef, repfname
%
%     OUT:
%       - `p` (char)

f = repfname();

if ( exist(f, 'file') == 0 )
  error( 'Repository path has not been defined; see `repdef`.' );
end

p = dload( f );

end

function x = dload(p)
x = load( p );
x = x.(char(fieldnames(x)));
end