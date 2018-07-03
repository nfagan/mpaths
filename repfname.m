function f = repfname()

%   REPFNAME -- Get the name of the repositories definition file.
%
%     See also repdir, repadd
%
%     OUT:
%       - `f` (char)

outerdir = fileparts( which(mfilename) );
fname = 'mpaths.mat';
f = fullfile( outerdir, fname );
end