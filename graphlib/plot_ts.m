function plot_ts(ts_data, x, plot_prop, path2results, file_name)
% PLOT_TS(TS_DATA, X, PLOT_PROP, PATH2RESULTS, FILE_NAME). Plot time series. 
% Input:
%   ts_data = [n x 1] vector with the time-series.
%   x = [n x 1] vector with the points at which the time-series is evaluated.
%   plot_prop = structure with the details of the plot.
%       plot_prop.col = char specifying the color of the graph.
%       plot_prop.width = line width.
%       plot_prop.axis_size = [min_x max_x min_y max_y] dimensions of the
%                             plot.
%       plot_prop.imres = string with the image resolution, e.g. '-r300'
%                         for 300dpi
%   path2results = string with the complete path where to save the plot.
%   file_name = string with the name of the file where to save the plot
%               with the adequate extension, e.g. 'acceleration-ts.png'.
%
% Author: A. Luchici, 2015

% Change default axes fonts.
set(0, 'DefaultAxesFontName', 'Helvetica')
set(0, 'DefaultAxesFontSize', 14)
set(0, 'DefaultAxesFontWeight', 'Bold')

% Change default text fonts.
set(0, 'DefaultTextFontname', 'Helvetica')
set(0, 'DefaultTextFontSize', 14)
set(0, 'DefaultTextFontWeight', 'Bold')

% Plot graph
plot(x, ts_data, 'Color', plot_prop.col, 'LineWidth', plot_prop.width);
axis tight
axis equal
axis(plot_prop.axis_size); 

% Save image to file
% Create folder where to store the image
mkdir(path2results);

% Save image.
fname_out = fullfile(path2results, file_name);
print(gcf, '-dpng', plot_prop.imres, fname_out);