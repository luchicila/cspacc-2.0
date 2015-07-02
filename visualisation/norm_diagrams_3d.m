% Diagrams for 3D normalisation 
%% Normalise with respect to colliding partner

% Define coordiantes of the points
A0 = [-0.5; 1; .8; 1];
A1 = [1; 2.5; 1.8; 1];
A2 = [1; 1; 4; 1];
A1A0 = A1 - A0;
A2A0 = A2 - A1;

% Coordinate axis
close all
figure
hold on
quiver3(-1, 0, 0, 3, 0, 0, 'k', 'autoscale', 'off', 'linewidth', .5);
quiver3(0, -1, 0, 0, 3, 0, 'k', 'autoscale', 'off', 'linewidth', .5);
quiver3(0, 0, -1, 0, 0, 3, 'k', 'autoscale', 'off', 'linewidth', .5);
view([254 6])

% Plot vectors before normalisation
quiver3(A0(1), A0(2), A0(3), A1A0(1), A1A0(2), A1A0(3), 'r', ...
    'autoscale', 'off', 'linewidth', 2);
quiver3(A1(1), A1(2), A1(3), A2A0(1), A2A0(2), A2A0(3), 'b', ...
    'autoscale', 'off', 'linewidth', 1.2);

% Set maximum scale for x,y,z axis.
axis([-1, 4, -1, 4, -1, 4]);
set(gca, 'xtick', []);
set(gca, 'ytick', []);
set(gca, 'ztick', []);
box on

% Translate such that A0 is the origin of the coordinate system
T = [1, 0, 0, -A0(1); ...
     0, 1, 0, -A0(2); ...
     0, 0, 1, -A0(3); ...
     0, 0, 0, 1];
A0 = T * A0;
A1 = T * A1;
A2 = T * A2; 
A1A0 = A1 - A0;
A2A0 = A2 - A1;

% Coordinate axis
figure
hold on
quiver3(-1, 0, 0, 3, 0, 0, 'k', 'autoscale', 'off', 'linewidth', .5);
quiver3(0, -1, 0, 0, 3, 0, 'k', 'autoscale', 'off', 'linewidth', .5);
quiver3(0, 0, -1, 0, 0, 3, 'k', 'autoscale', 'off', 'linewidth', .5);
view([254 6])

% Plot rotated translated 
quiver3(A0(1), A0(2), A0(3), A1A0(1), A1A0(2), A1A0(3), 'r', ...
    'autoscale', 'off', 'linewidth', 2);
quiver3(A1(1), A1(2), A1(3), A2A0(1), A2A0(2), A2A0(3), 'b', ...
    'autoscale', 'off', 'linewidth', 1.2);

% Set maximum scale for x,y,z axis.
axis([-1, 4, -1, 4, -1, 4]);
set(gca, 'xtick', []);
set(gca, 'ytick', []);
set(gca, 'ztick', []); 
box on
% Find angle of rotation
thetaz = atan2(A1(2), A1(1));

% Build rotation matrix that will make vector parallel to XOZ plane
Rz = [cos(thetaz), -sin(thetaz), 0, 0; ...
    sin(thetaz), cos(thetaz), 0, 0; ...
    0, 0, 1, 0; ...
    0, 0, 0, 1];

A1 = Rz * A1;
A2 = Rz * A2;
A1A0 = A1 - A0;
A2A0 = A2 - A1;

% Plot vectors after rotation about z
% Coordinate axis
figure
hold on
quiver3(-1, 0, 0, 3, 0, 0, 'k', 'autoscale', 'off', 'linewidth', .5);
quiver3(0, -1, 0, 0, 3, 0, 'k', 'autoscale', 'off', 'linewidth', .5);
quiver3(0, 0, -1, 0, 0, 3, 'k', 'autoscale', 'off', 'linewidth', .5);
view([254 6])

% Plot rotated vectors 
quiver3(A0(1), A0(2), A0(3), A1A0(1), A1A0(2), A1A0(3), 'r', ...
    'autoscale', 'off', 'linewidth', 2);
quiver3(A1(1), A1(2), A1(3), A2A0(1), A2A0(2), A2A0(3), 'b', ...
    'autoscale', 'off', 'linewidth', 1.2);

% Set maximum scale for x,y,z axis.
axis([-1, 4, -1, 4, -1, 4]);
set(gca, 'xtick', []);
set(gca, 'ytick', []);
set(gca, 'ztick', []);
box on

% Colapse line to OX
thetay = -atan2(A1(3), A1(2)); % find angle between P1 and OX

% Build rotation matrix that will make vector parallel to OX
Ry = [1, 0, 0, 0;...
    0, cos(thetay), -sin(thetay), 0; ...
    0, sin(thetay), cos(thetay), 0; ...
    0, 0, 0, 1];
A1 = Ry * A1;
A2 = Ry * A2;
A1A0 = A1 - A0;
A2A0 = A2 - A1;

% Plot vectors after rotation about y
% Coordinate axis
figure
hold on
quiver3(-1, 0, 0, 3, 0, 0, 'k', 'autoscale', 'off', 'linewidth', .5);
quiver3(0, -1, 0, 0, 3, 0, 'k', 'autoscale', 'off', 'linewidth', .5);
quiver3(0, 0, -1, 0, 0, 3, 'k', 'autoscale', 'off', 'linewidth', .5);
view([254 6])

% Plot rotated vectors 
quiver3(A0(1), A0(2), A0(3), A1A0(1), A1A0(2), A1A0(3), 'r', ...
    'autoscale', 'off', 'linewidth', 2);
quiver3(A1(1), A1(2), A1(3), A2A0(1), A2A0(2), A2A0(3), 'b', ...
    'autoscale', 'off', 'linewidth', 1.2);

% Set maximum scale for x,y,z axis.
axis([-1, 4, -1, 4, -1, 4]);
set(gca, 'xtick', []);
set(gca, 'ytick', []);
set(gca, 'ztick', []);
box on

%% Normalise with respect to the colliding partner
% Define coordiantes of the points
A0 = [-0.5; 1; .8; 1];
A1 = [1; 2.5; 1.8; 1];
A2 = [1; 1; 4; 1];
B1 = [2; 2; 0.5; 1];

A1A0 = A1 - A0;
A2A0 = A2 - A1;
B1A1 = B1 - A1;

% Coordinate axis
close all
figure
hold on
quiver3(-1, 0, 0, 3, 0, 0, 'k', 'autoscale', 'off', 'linewidth', .5);
quiver3(0, -1, 0, 0, 3, 0, 'k', 'autoscale', 'off', 'linewidth', .5);
quiver3(0, 0, -1, 0, 0, 3, 'k', 'autoscale', 'off', 'linewidth', .5);
view([41 36])

% Plot vectors before normalisation
quiver3(A0(1), A0(2), A0(3), A1A0(1), A1A0(2), A1A0(3), 'r', ...
    'autoscale', 'off', 'linewidth', 2);
quiver3(A1(1), A1(2), A1(3), A2A0(1), A2A0(2), A2A0(3), 'b', ...
    'autoscale', 'off', 'linewidth', 1.2);
quiver3(A1(1), A1(2), A1(3), B1A1(1), B1A1(2), B1A1(3), 'm--', ...
    'autoscale', 'off', 'linewidth', 1);

% Set maximum scale for x,y,z axis.
axis([-1, 5, -1, 5, -1, 5]);
set(gca, 'xtick', []);
set(gca, 'ytick', []);
set(gca, 'ztick', []);
box on

% Translate such that A0 is the origin of the coordinate system
T = [1, 0, 0, -A1(1); ...
     0, 1, 0, -A1(2); ...
     0, 0, 1, -A1(3); ...
     0, 0, 0, 1];
A0 = T * A0;
A1 = T * A1;
A2 = T * A2; 
B1 = T * B1;
A1A0 = A1 - A0;
A2A0 = A2 - A1;
B1A1 = B1 - A1;

% Coordinate axis
figure
hold on
quiver3(-1, 0, 0, 3, 0, 0, 'k', 'autoscale', 'off', 'linewidth', .5);
quiver3(0, -1, 0, 0, 3, 0, 'k', 'autoscale', 'off', 'linewidth', .5);
quiver3(0, 0, -1, 0, 0, 3, 'k', 'autoscale', 'off', 'linewidth', .5);
view([41 36])

% Plot rotated translated 
quiver3(A0(1), A0(2), A0(3), A1A0(1), A1A0(2), A1A0(3), 'r', ...
    'autoscale', 'off', 'linewidth', 2);
quiver3(A1(1), A1(2), A1(3), A2A0(1), A2A0(2), A2A0(3), 'b', ...
    'autoscale', 'off', 'linewidth', 1.2);
quiver3(A1(1), A1(2), A1(3), B1A1(1), B1A1(2), B1A1(3), 'm--', ...
    'autoscale', 'off', 'linewidth', 1);

% Set maximum scale for x,y,z axis.
axis([-1, 5, -1, 5, -1, 5]);
set(gca, 'xtick', []);
set(gca, 'ytick', []);
set(gca, 'ztick', []); 
box on

% Find angle of rotation
thetaz = atan2(B1(2), B1(1));
if thetaz < 0
    thetaz = 2*pi - abs(thetaz);
end
thetaz = - thetaz;
% Build rotation matrix that will make vector parallel to XOZ plane
Rz = [cos(thetaz), -sin(thetaz), 0, 0; ...
    sin(thetaz), cos(thetaz), 0, 0; ...
    0, 0, 1, 0; ...
    0, 0, 0, 1];

A1 = Rz * A1;
A2 = Rz * A2;
B1 = Rz * B1;
A1A0 = A1 - A0;
A2A0 = A2 - A1;
B1A1 = B1 - A1;

% Plot vectors after rotation about z
% Coordinate axis
figure
hold on
quiver3(-1, 0, 0, 3, 0, 0, 'k', 'autoscale', 'off', 'linewidth', .5);
quiver3(0, -1, 0, 0, 3, 0, 'k', 'autoscale', 'off', 'linewidth', .5);
quiver3(0, 0, -1, 0, 0, 3, 'k', 'autoscale', 'off', 'linewidth', .5);
view([41 36])

% Plot rotated vectors 
quiver3(A0(1), A0(2), A0(3), A1A0(1), A1A0(2), A1A0(3), 'r', ...
    'autoscale', 'off', 'linewidth', 2);
quiver3(A1(1), A1(2), A1(3), A2A0(1), A2A0(2), A2A0(3), 'b', ...
    'autoscale', 'off', 'linewidth', 1.2);
quiver3(A1(1), A1(2), A1(3), B1A1(1), B1A1(2), B1A1(3), 'm--', ...
    'autoscale', 'off', 'linewidth', 1);

% Set maximum scale for x,y,z axis.
axis([-1, 5, -1, 5, -1, 5]);
set(gca, 'xtick', []);
set(gca, 'ytick', []);
set(gca, 'ztick', []);
box on

% Colapse line to OX
thetay = atan2(B1(3), B1(1)); % find angle between P1 and OX
if thetay < 0
    thetay = 2*pi - abs(thetay);
end
% Build rotation matrix that will make vector parallel to OX
Ry = [cos(thetay), 0, sin(thetay), 0;...
    0, 1, 0, 0; ...
    -sin(thetay), 0, cos(thetay), 0; ...
    0, 0, 0, 1];
A1 = Ry * A1;
A2 = Ry * A2;
B1 = Ry * B1;
A1A0 = A1 - A0;
A2A0 = A2 - A1;
B1A1 = B1 - A1;

% Plot vectors after rotation about y
% Coordinate axis
figure
hold on
quiver3(-1, 0, 0, 3, 0, 0, 'k', 'autoscale', 'off', 'linewidth', .5);
quiver3(0, -1, 0, 0, 3, 0, 'k', 'autoscale', 'off', 'linewidth', .5);
quiver3(0, 0, -1, 0, 0, 3, 'k', 'autoscale', 'off', 'linewidth', .5);
view([41 36])

% Plot rotated vectors 
quiver3(A0(1), A0(2), A0(3), A1A0(1), A1A0(2), A1A0(3), 'r', ...
    'autoscale', 'off', 'linewidth', 2);
quiver3(A1(1), A1(2), A1(3), A2A0(1), A2A0(2), A2A0(3), 'b', ...
    'autoscale', 'off', 'linewidth', 1.2);
quiver3(A1(1), A1(2), A1(3), B1A1(1), B1A1(2), B1A1(3), 'm--', ...
    'autoscale', 'off', 'linewidth', 1);

% Set maximum scale for x,y,z axis.
axis([-1, 5, -1, 5, -1, 5]);
set(gca, 'xtick', []);
set(gca, 'ytick', []);
set(gca, 'ztick', []);
box on