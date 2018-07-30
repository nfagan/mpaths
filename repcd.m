function repcd(name)

%   REPCD -- Change working directory to repository.
%
%     repcd( NAME ) changes the working directory to the absolute path
%     containing the repository `NAME`.
%
%     See also repget, repdef
%
%     IN:
%       - `name` (char)

cd( repget(name) );

end