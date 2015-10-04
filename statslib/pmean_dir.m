function vmean_dir = pmean_dir(vec, n, nt)
% Compute mean direction of a sample of vectors recorded at discrete
% intervals. The mean direction is equivalent to the direction of the
% resultant of the unit vectors from the sample.
% Input:
%   vec = [nt x 3 x n] matrix with the (x,y,z) components of the vectors. 
%   n = number of vectors in the sample.
%   nt = maximum number of time points.
% 
% Output:
%   vmean_dir = [nt x 3] vector with the average direction of the vectors
%           computed at each time point. The first comlumn is the angle
%           made by the projetion of the vector to the XY plane  with the
%           OX axis. The second column represents the angle made by the
%           resultant vector with the OZ axis. The thrid column represents
%           the magnitude of the resultant vector. This value can be used
%           as a measurement for how dispersed is the data.
%
% Author: A. Luchici, 2015

vmean_dir = zeros(nt,3); % initialize output

tmp = vec;
for k = 1:nt
    % Find the unit vectors for every entry in the sample at current time
    % point.
    for i = 1:n
        tmp(k,:,i) = tmp(k,:,i) / norm(tmp(k,:,i))
    end
    
    vx = sum(tmp(k,1,:)); % compute the x-component of the resultant vector.
    vy = sum(tmp(k,2,:)); % compute the y-component of the resultant vector.
    vz = sum(tmp(k,3,:)); % compute the z-component of the resultant vector.
    
    % Find the angle (in radians) between the projection of the vector in the XY
    % plane and OX axis.
    vmean_dir(k,1) = atan2(vy, vx); 
    
    % Find the angle (in radians) between the resultant vector and the OZ axis.
    vmean_dir(k,2) = atan2(norm([vx, vy]), vz);
    
    vmean_dir(k,3) = norm([vx, vy, vz]); % magnitude of the resultant vector.
end
end