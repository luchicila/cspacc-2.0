function plot_dist(pdf_data, x, plot_prop, path2results, file_name)
% plot_dist(pdf_data, x, plot_prop, path2results, file_name). Plot with PDF of 
% the sample distribution.
% Input:
%   pdf_data = [n x 1] vector with the PDF.
%   x = [n x 1] vector with the points at which the PDF is evaluated.
%   plot_prop = structure with the details of the plot.
%       plot_prop.col = char specifying the color of the graph.
%       plot_prop.width = line width.
%       plot_prop.axis_size = [min_x max_x min_y max_y] dimensions of the
%                             plot.
%       plot_prop.imres = string with the image resolution, e.g. '-r300'
%                         for 300dpi
%   path2results = string with the complete path where to save the plot.
%   file_name = string with the name of the file where to save the plot
%               with the adequate extension, e.g. 'acceleration-pdf.png'.
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
plot(x, pdf_data, 'Color', plot_prop.col, 'LineWidth', plot_prop.width);
axis tight
set(gca, 'XLim', plot_prop.axis_size(1:2)); 
set(gca, 'YLim', plot_prop.axis_size(3:4));

% Save image to file
% Create folder where to store the image
mkdir(path2results);

% Save image.
fname_out = fullfile(path2results, file_name);
print(gcf, '-dpng', plot_prop.imres, fname_out);

