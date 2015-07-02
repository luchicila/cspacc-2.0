function [ca, n, nt] = load_tracks_single()
% Input user to select a file with the data and tehn load tracks of colliding 
% cells from .csv file. Tracks file needs to be structured as the corresponding 
% tracks-template.xlsx.
% Output:
%   ca = nt x 9 x n matrix with the (x, y, z) position of cells. 
%   n = number of cells.
%   nt = maximum track length.
% Note that zeros are going to be replaced with NaN values. 
%
% Author: A. Luchici, 2015

[file_name, dpath] = uigetfile('.csv'); % ask user to select .csv data file

% Extract number of pairs & number of frames.
tmp = csvread(fullfile(dpath, file_name), 0, 0, 'A1..B1');
n = tmp(1); % number of cells
nt = tmp(2); % maximum length of tracks 
clear tmp

tracks_data = csvread(fullfile(dpath, tcell_file), 4, 0); % read .csv file

% Initialize output
ca = zeros(nt, 9, n);

% Extract tracks for each cell
for i = 1:n
    ca(:,1:3,i) = tracks_data(:,3*(i-1)+1:3*(i-1)+3);
end

% Replace 0 values (i.e. missing data) by nan
ca(ca == 0) = nan;