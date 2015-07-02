function save_vec(vec, path2results, file_name)
% Export vector sample data to .csv file. 
% Input:
%   vec = [nt x 3 x n] matrix with the vectors in the sample. Each row 
%           represents a time point, while each page represents one vector in 
%           the sample. 
%   path2results = string specifying the path to the folder where to create and
%                  save the .csv file with the vectors.
%   file_name = string specifying the name of the file in which to save the
%               vectors. 
%
% Author A. Luchici, 2015

% Make folder with results. 
mkdir(path2results);
path2data = fullfile(path2results, file_name);

% Create and write .csv file with the vector sample.
csvwrite(path2data, vec);
