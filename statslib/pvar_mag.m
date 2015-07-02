function vvar = pvar_mag(vec, n, nt)
% Compute variance of the magnitude of a sample of vectors recorded at discrete 
% intervals.
% Input:
%   vec = [nt x 3 x n] matrix with the (x,y,z) components of the vecotors. 
%   n = number of vectors in the sample.
%   nt = number of time intervals.
% 
% Output:
%   vvar = [nt x 1] vector with the variance of the magnitude of the vectors
%           computed at each time point. 
%
% Author: A. Luchici, 2015

vvar = zeros(nt,1); % initialize output
for k = 1:nt
    % Compute vector magnitude at each time point.
    tmp = zeros(n,1);
    for j = 1:n
        tmp(j) = norm(vec(k,:,j));
    end
    
    % Find the variance of the vector sample at each time point. 
    vvar(k) = std(tmp);
end
