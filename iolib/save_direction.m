function save_direction(theta, path2results, file_name)
% Export direction for vectors in the sample to .csv file.
% Input:
%   theta = [nt x 2 x n] matrix with the directions of vectors in the
%           sample. Each row represents a time point, while each page
%           represents one vector in the sample. 
%   path2results = string specifying the path to the folder where to create and
%                  save the .csv file with the directions.
%   file_name = string specifying the name of the file in which to save the
%               vector directions. 
%
% Author A. Luchici, 2015

% Make folder with results. 
mkdir(path2results);
path2data = fullfile(path2results, file_name);

% Create and write .csv file with the direction of the vector sample.
csvwrite(path2data, theta);

