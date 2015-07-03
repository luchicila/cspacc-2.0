function ca_norm = norm_vprev(ca, n, nt, dt)
% ca_norm = NORM_VPREV(ca, n, nt, dt). Compute velocity and acceleration data 
% normalized to the direction of the previous velocity, i.e. the unit vector of 
% the velocity at t-1. 
% Input:
%   ca = nt x 9 x n matrix with the (x, y, z) coordinates of the cells.
%   n = number of cells.
%   nt = maximum length of the tracks.
%   dt = accuisition rate
%
% Output:
%   ca_norm = nt x 9 x n matrix with the normalised velocity and
%   acceleration vectors. 
%
% Author: A. Luchici, 2015

ca_norm = ca; % initialize output
for i = 1:n
    for k = 2:nt-1
         % Cell coordinates at t-1 in homogeneous coordinates
        A0 = ca(k-1,1:3,i);
        A0(4) = 1;
        A0 = A0';
        
        % Cell coordinates at t in homogeneous coordinates
        A1 = ca(k,1:3,i);
        A1(4) = 1;
        A1 = A1';
        
        % Translate point B such that AB is a position vector starting from the
        % origin. This is the same as making A the origin of the coordinate system.
        T = [1, 0, 0, -A0(1); ...
             0, 1, 0, -A0(2); ...
             0, 0, 1, -A0(3); ...
             0, 0, 0, 1];
        A11 = T * A1;
        
        % Find transform that would make A0A1 parallel to OX
        % Find angle between projection of A0A1 to XOY plane and OX
        thetax = -atan2(A11(2), A11(1));
        
        % Build rotation matrix that will make vector parallel to XOZ plane
        Rz = [cos(thetax), -sin(thetax), 0, 0; ...
              sin(thetax), cos(thetax), 0, 0; ...
              0, 0, 1, 0; ...
              0, 0, 0, 1];
        
        A12 = Rz * A11; % rotate about z-axis to bring vector to XOZ plane
        
        thetaz = atan2(A12(3), A12(1)); % find angle between A0A12 and OX
        
        % Build rotation matrix that will make vector parallel to OX
        Ry = [cos(thetaz), 0, sin(thetaz), 0;...
              0, 1, 0, 0; ...
             -sin(thetaz), 0, cos(thetaz), 0; ...
              0, 0, 0, 1];
        A13 = Ry * A12;
        
        % Compute normalised velocity and acceleration
        % Cell coordinates at k+1 in homogenenous coordinates.
        A2 = ca(k+1,1:3,i);
        A2(4) = 1;
        A2 = A2';
        
        % Translate vectors such that the position of the cell at (k-1) is the
        % center of the coordinate system.
        A21 = T * A2;
        
        % Find the position of the cell at (k-1) after A0A1 is horizontal 
        % along OX 
        A22 = Ry * Rz * A21;
   
        % Compute normalised acceleration between (k-1) and (k+1) in
        % microns per minute^2
        ca_norm(k,7:9,i) = [A22(1:3)]' / (dt^2) * (60^2); 
        
        % Compute normalised velocity between k and (k+1) in microns per
        % minute.
        ca_norm(k,4:6,i) = [A22(1:3) - A13(1:3)]' / dt * 60;
    end
end