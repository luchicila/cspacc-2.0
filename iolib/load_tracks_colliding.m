function [ca, cb, n, nt, col_pt] = load_tracks_colliding()
% Input user to select a file with the data and tehn load tracks of colliding 
% cells from .csv file. Tracks file needs to be structured as the corresponding 
% tracks-template.xlsx.
% Output:
%   ca = nt x 9 x n matrix with the (x, y, z) coordinates of cell A.
%   cb = nt x 9 x n matrix with the (x, y, z) coordiantes of cell B.
%   n = number of cell pairs
%   nt = maximum track length (number of frames)
%   col_pt = collision time point
% Note that zeros are going to be replaced with NaN values. 
%
% Author: A. Luchici, 2015

[file_name, dpath] = uigetfile('.csv'); % ask user to select .csv data file

% Extract number of pairs & number of frames
tmp = csvread(fullfile(dpath, file_name), 0, 0, 'A1..C1');
n = tmp(1); % number of cell pairs
nt = tmp(2); % maximum track length
col_pt = tmp(3); % collision time point
clear tmp

tracks_data = csvread(fullfile(dpath, tcell_file), 4, 0); % read .csv file

% Initialize output
ca = zeros(nt, 9, n);
cb = zeros(nt, 9, n);

% Extract tracks for each cell
for i = 1:n
    ca(:,1:3,i) = tracks_data(:,6*(i-1)+1:6*(i-1)+3);
    cb(:,1:3,i) = tracks_data(:,6*(i-1)+4:6*(i-1)+6);
end

% Replace 0 values (i.e. missing data) by nan
ca(ca == 0) = nan;
cb(cb == 0) = nan;