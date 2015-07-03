function [pdist_theta, x_theta, pdist_phi, x_phi] = pdf_dir(vec, n, nt, nbins)
% Estimate the probability density function for vector directions. 
% Input:
%   vec = [nt x 3 x n] matrix with the (x, y, z) components of the vectors.
%   n = number of vectors in the sample.
%   nt = maximum number of time points.
%   nbins = number of points used for evaluating the PDF.
%
% Output:
%   pdist_theta = [nt x n, 1] vector with the probability density function
%                 for the direction theta, between the XY projection of the 
%                 vector and OX axis.
%   x_theta = [nt x n, 1] vector with angles at which the PDF for theta is 
%             evaluated.
%   pdist_phi = [nt x n, 1] vector with the probability density function
%               for the direction phi, between the vector and OZ axis.
%   x_phi = [nt x n, 1] vector with angles at which the PDF for phi is 
%           evaluated.
% 
% Author: A. Luchici, 2015.

% Compute vector direction.
vec_dir = compute_dir(vec, n, nt);

theta = vec_dir(:,1,:);
theta = reshape(theta, n*nt, 1);

phi = vec_dir(:,2,:);
phi = reshape(phi, n*nt, 1);

% Fit distribution to vectors magnitude using Epanechnikov kernel.
pd_theta = fitdist(theta, 'Kernel', 'Kernel', 'epanechnikov');
pd_phi = fitdist(phi, 'Kernel', 'Kernel', 'epanechnikov');

% Compute distribution values for evenly spaced magnitudes between 0 and
% maximum recorded magnitude + 10% more.
x_theta = linspace(min(theta)-0.1*min(theta),max(theta)+0.1*max(theta), nbins);
pdist_theta = pdf(pd_theta, x_theta);

x_phi = linspace(min(phi)-0.1*min(phi), max(phi)+0.1*max(phi), nbins);
pdist_phi = pdf(pd_phi, x_phi);