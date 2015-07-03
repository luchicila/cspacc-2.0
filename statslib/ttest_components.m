function pval = ttest_components(vec, nt, mu_x, mu_y, mu_z, alpha)
% [pval, hval] = israndom_vec(vec, nt). 
% Compute Two-Tailed T-Test for components of the vector at every time
% point. The null hypothesis for the test is that average value of each
% component is equal to some user specified values. 
% Input:
%   vec = [nt x 3 x n] matrix with the vector sample.
%   nt = number of time points available.
%   mu_x = expected average for the x-component.
%   mu_y = expected average for the y-component.
%   mu_z = expected average for the z-component.
%   alpha = alpha value for the t-test.
%   
% Output:
%   pval = [nt x 3] vector with the p-value for each frame. Each column
%   contains the p-value for the corresponding component.
%
% Author: A. Luchici, 2015

% Initialize output
pval = zeros(nt,3);

% Check each component of the vector sample at each time step.
for i = 1:nt
    [~, pval(i,1)] = ttest(vec(i,1,:), mu_x, 'alpha', alpha, 'tail', 'both');
    [~, pval(i,2)] = ttest(vec(i,2,:), mu_y, 'alpha', alpha, 'tail', 'both');
    [~, pval(i,3)] = ttest(vec(i,3,:), mu_z, 'alpha', alpha, 'tail', 'both');
end