function Origin_Plot(ca, n)

% Plot cell paths from common origin
% Cell paths must be split into X and Y paths (imageJ already does this)

% Input:
%   ca_norm = [nt x 9 x n] matrix with the (x, y, z) position of the cell
%   n = number of cells

% Output:
%   Plot of cell tracks, stemming from common origin.

for cn = 1:n
    scalePathx = ca(1,1,cn) ;
    scalePathy = ca(1,2,cn) ;
    % subtract first XY value from all XY points
    X0 = ca(:,1,cn) - scalePathx ;
    Y0 = ca(:,2,cn) - scalePathy ;

    plot(X0 , Y0);
    hold all
    plot(X0(1),Y0(1),'or')
    plot(X0(end),Y0(end),'or')
end

end
