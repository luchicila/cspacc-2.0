function vdir = compute_dir(vec, n, nt)
% Compute vector direction per frame for each entry in the sample. 
% Input:
%   vec = [nt x 3 x n] matrix with the vectors in the sample. 
%   n = number of vectors in the sample.
%   nt = maximum number of time points available. 
% Output: 
%   vdir = [nt x 2 x n] matrix with the vector directions per frame. The first 
%          column represents the angle between vector projection in the XY plane 
%          and the OX axis. The second column is the angle beween the vector and 
%          OZ axis. 
%
% Author: A. Luchici, 2015

% Initialize output
vdir = zeros(nt, 2, n);

% Compute vector directions for each entry in the sample at eacha available
% timepoint.
for i = 1:n
    for k = 1:nt
        vdir(k,1,i) = atan2(vec(k,2,i),vec(k,1,i));
        vdir(k,2,i) = atan2(sqrt(vec(k,1,i)^2 + vec(k,2,i)^2), vec(k,3,i));
    end
end