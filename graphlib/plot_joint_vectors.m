function plot_joint_vectors(v1, v2, n, nt, plot_prop, path2results)
% Combine and display vectors in a single panel and save images to file.
% Input:
%   v1 = [nt x 3 x n] matrix containing the (x,y,z) coordinates of the
%        vector that is displayed in the left panel. 
%   v2 = [nt x 3 x n] matrix containing the (x,y,z) coordinates of the
%        vector that is displayed in the right panel. 
%   n = number of vectors.
%   nt = maximum number of timepoints.
%   plot_prop = structure specifying the properties of the plot as follows:
%       plot_prop.axis_size = [min_x max_x min_y max_y min_z max_z].
%       plot_prop.imres = strign with the resolution at which to save images, 
%                         e.g. '-r300' for 300dpi.
%       plot_prop.dimensions = number of dimensions for the plot. This is
%                              either 2 or 3.
%   path2results = string specifying the path to the directory where to
%                  save the vector images. 
%
%   Author: A. Luchici, 2015

% Change default axes fonts.
set(0, 'DefaultAxesFontName', 'Helvetica')
set(0, 'DefaultAxesFontSize', 14)
set(0, 'DefaultAxesFontWeight', 'Bold')

% Change default text fonts.
set(0, 'DefaultTextFontname', 'Helvetica')
set(0, 'DefaultTextFontSize', 14)
set(0, 'DefaultTextFontWeight', 'Bold')

if ~exists(path2results, 'dir')
    mkdir(path2results);
end

figure
for j = 1:nt-1
    clf
    hold on
    if j == nt-1
        fill([plot_prop.axis_size(2) - .2 - 2, ...
            plot_prop.axis_size(2) - .2 - 2, ...
            plot_prop.axis_size(2) - .2, ...
            plot_prop.axis_size(2) - .2], ...
            [plot_prop.axis_size(4) - .2, ...
            plot_prop.axis_size(4)-.15, ...
            plot_prop.axis_size(4)-.15, ...
            plot_prop.axis_size(4) - .2], 'k');
    end
    q = quiver(zeros(1,1,n), zeros(1,1,n), zeros(1,1,n), ...
               v1(j,1,:), v1(j,2,:), v1(j,3,:), 'k');
    q.AutoScale = 'off';
    q.LineWidth = 2;
    
    q = quiver(zeros(1,1,n), zeros(1,1,n), zeros(1,1,n), ...
               v2(j,1,:), v2(j,2,:), v2(j,3,:), 'k');
    q.AutoScale = 'off';
    q.LineWidth = 2;
    
    axis tight
    axis equal
    axis(plot_prop.axis_size);
    view(plot_prop.dimensions);
    drawnow;
    
    % Save frame to .png file
    fname_out = fullfile(path2results, ['frame_', num2str(10000+j), '.png']);
    print(gcf, '-dpng', plot_prop.imres, fname_out);
    
    hold off
end