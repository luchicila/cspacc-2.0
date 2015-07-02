function pdist_mag = pdf_mag(vec, n, nt)
% Estimate the probability density function for the vectors magnitude. 
% Input:
%   vec = [nt x 3 x n] matrix with the (x, y, z) components of the vectors.
%   n = number of vectors in the sample.
%   nt = maximum number of time points.
%
% Output:
%   pdist_mag = [nt x n, 1] vector with the probability density function
%               for vector magnitudes. 
% 
% Author: A. Luchici, 2015.
