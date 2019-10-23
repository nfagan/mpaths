function f = repfname()

%   REPFNAME -- Get the name of the repositories definition file.
%
%     See also repdir, repadd

f = fullfile( fileparts(which(mfilename)), 'mpaths.mat' );

end