function ca_norm = norm_in(ca, cb, n, nt, dt)
% Compute velocity and acceleration data normalized to the direction of the
% incoming partner, i.e. the unit vector of the vector connecting the position 
% of the 2 cells at time t. Note that the colliding partner need not be a
% cell. It can be any fixed reference with respect to which to normalise
% the velocity and acceleration. 
% Input:
%   ca = nt x 9 x n matrix with the (x, y, z) coordinates of cell A. 
%   cb = nt x 9 x n matrix with the (x, y, z) coordinates of cell B.
%   n = number of cells.
%   nt = maximum length of the tracks.
%   dt = accuisition rate
%
% Output:
%   ca_norm = nt x 9 x n matrix with the normalised velocity and
%   acceleration vectors for cell A. 
%
% Author: A. Luchici, 2015

ca_norm = ca;
for i = 1:n
    for k = 2:nt-1
        % Location of left cell at t in homogeneous coordinates
        A = ca(k,1:3,i);
        A(4) = 1;
        A = A';
        
        % Location of right cell at t in homogeneous coordinates
        B = cb(k,1:3,i);
        B(4) = 1;
        B = B';
        
        % Translate point B such that AB is a position vector starting from the
        % origin. This is the same as making A the origin of the coordinate system.
        T = [1, 0, 0, -A(1); ...
             0, 1, 0, -A(2); ...
             0, 0, 1, -A(3); ...
             0, 0, 0, 1];
        B1 = T * B;
        
        % Find transform that would make AB parallel to OX
        % Find angle between projection of A1B1 to XOY plane and OX
        thetax = -atan2(B1(2), B1(1));
        
        % Build rotation matrix that will make vector parallel to XOZ plane
        Rz = [cos(thetax), -sin(thetax), 0, 0; ...
              sin(thetax), cos(thetax), 0, 0; ...
              0, 0, 1, 0; ...
              0, 0, 0, 1];
        
        B11 = Rz * B1; % rotate about z-axis to bring vector to XOZ plane
        
        thetaz = atan2(B11(3), B11(1)); % find angle between AB11 and OX
        
        % Build rotation matrix that will make vector parallel to OX
        Ry = [cos(thetaz), 0, sin(thetaz), 0;...
              0, 1, 0, 0; ...
             -sin(thetaz), 0, cos(thetaz), 0; ...
              0, 0, 0, 1];
      
        % Transform triplet
        % Extract position left cell at k-1 in homogenenous coordinates.
        A1 = ca(k-1,1:3,i);
        A1(4) = 1;
        A1 = A1';
        
        % Extract position left cell at k+1 in homogenenous coordinates.
        A3 = ca(k+1,1:3,i);
        A3(4) = 1;
        A3 = A3';
        
        % Translate vectors such that the position of the cell at (k-1) is the
        % center of the coordinate system.
        A11 = T * A1;
        
        % Find the position of the cell at (k-1) after AB is horizontal along OX 
        A12 = Ry * Rz * A11;
   
        % Translate vectors such that the position of the cell at (k+1) is the
        % center of the coordinate system.
        A31 = T * A3;
   
        % Find the position of the cell at (k+1) after AB is horizontal along OX 
        A32 = Ry * Rz * A31;
        
        % Compute normalised acceleration between (k-1) and (k+1) in
        % microns per minute^2
        ca_norm(k,7:9,i) = [A32(1:3) - A12(1:3)]' / (dt^2) * (60^2); 
        
        % Compute normalised velocity between k and (k+1) in microns per
        % minute.
        ca_norm(k,4:6,i) = [A32(1:3) - A1(1:3)]' / dt * 60;
    end
end