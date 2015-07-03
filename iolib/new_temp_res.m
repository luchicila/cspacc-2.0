function [ca_new, nt1] = new_temp_res(ca, n, nt, dt, origin, new_origin)
% [ca_new, nt1] = new_temp_res(ca, n, nt, dt, origin, new_origin).
% Change temporal resolution by selecting data points every dt number of
% frames surrounding a user specified origin. 
% Input:
%   ca = [nt x 9 x n] matrix with the (x, y, z) position of the cell.
%   n = number of cells
%   nt = maximum tracks length
%   dt = time interval (in frames) at which to extract data. 
%   origin = zero time point for the raw tracks (e.g. collision time
%            point).
%   new_origin = zero time point for the tracks at new temporal resolution. 
%
% Output:
%   ca_new = [nt x 9 x n] matrix with the (x, y, z) position of the cell at the 
%            new temporal resolution.
%   nt1 = new maximum number of tracks.
%
% Author A. Luchici, 2015

nt1 = length(1:dt:nt); % new track length
ca_new = zeros(nt1, 9, n); % initialize output

for i = 1:n
    % Extract data from origin up to begining of data set
    k = new_origin;
    for j = origin:-dt:1
        if k >= 1
            ca_new(k,:,i) = ca(j,:,i);
            k = k - 1;
        end
    end

    % Extract data from origin up the end of data set
    k = new_origin + 1;
    for j = origin+dt:dt:nt
        ca_new(k,:,i) = ca(j,:,i);
        k = k + 1;
    end
end
