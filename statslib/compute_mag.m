function vmag = compute_mag(vec, n, nt)
% Compute vector magnitude per frame for each entry in the sample. 
% Input:
%   vec = [nt x 3 x n] matrix with the vectors in the sample. 
%   n = number of vectors in the sample.
%   nt = maximum number of time points available. 
% Output: 
%   vmag = [nt x n] matrix with the vector magnitude per frame. 
%
% Author: A. Luchici, 2015

% Initialize output
vmag = zeros(nt, n);

% Compute magnitude of each vector in the sample at each available
% timepoint.
for i = 1:n
    for k = 1:nt
        vmag(k,i) = norm(vec(k,:,i));
    end
end