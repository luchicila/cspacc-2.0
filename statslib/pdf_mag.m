function [pdist_mag, vmag] = pdf_mag(vec, n, nt, nbins)
% [pdist_mag, vmag] = pdf_mag(vec, n, nt, nbins). 
% Estimate the probability density function for the vectors magnitude. 
% Input:
%   vec = [nt x 3 x n] matrix with the (x, y, z) components of the vectors.
%   n = number of vectors in the sample.
%   nt = maximum number of time points.
%   nbins = number of points used for evaluating the PDF.
%
% Output:
%   pdist_mag = [nt x n, 1] vector with the probability density function
%               for vector magnitudes. 
%   vmag = [nt x n, 1] vector with the veector magnitudes at which the PDF
%          is computed. 
%
% Author: A. Luchici, 2015.

% Compute vector magnitude.
vec_mag = compute_mag(vec, n, nt);
vec_mag = reshape(vec_mag, n*nt, 1);

% Fit distribution to vectors magnitude using Epanechnikov kernel.
pd = fitdist(vec_mag, 'Kernel', 'Kernel', 'epanechnikov');

% Compute distribution values for evenly spaced magnitudes between 0 and
% maximum recorded magnitude + 10% more.
vmag = linspace(0, max(vec_mag)+0.1*max(vec_mag), nbins);
pdist_mag = pdf(pd, vmag);
