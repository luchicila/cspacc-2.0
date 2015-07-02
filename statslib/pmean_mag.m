function vmean = pmean_mag(vec, n, nt)
% VMEAN = PMEAN_MAG(VEC, N, NT). Compute mean magnitude of a sample of vectors 
% recorded at discrete intervals.
% Input:
%   vec = [nt x 3 x n] matrix with the (x,y,z) components of the vecotors. 
%   n = number of vectors in the sample.
%   nt = number of time intervals.
% 
% Output:
%   vmean = [nt x 1] vector with the average magnitude of the vectors
%           computed at each time point. 
%
% Author: A. Luchici, 2015

vmean = zeros(nt,1); % initialize output

% Compute magnitude for every vector in the sample @ each time point
% available.
vmag = compute_mag(vec, n, nt);

% Find average magnitude per time point. 
for k = 1:nt
    vmean(k) = mean(vmag(k,:));
end