function [ca, n, nt, dt, dpath, file_name] = load_tracks_single()
% Input user to select a file with the data and tehn load tracks of colliding 
% cells from .csv file. Tracks file needs to be structured as the corresponding 
% tracks-template.xlsx.
% Output:
%   ca = nt x 9 x n matrix with the (x, y, z) position of cells. 
%   n = number of cells.
%   nt = maximum track length.
%   dt = interval between timepoints (seconds).
%   dpath = string with the path to the .csv file with the tracks.
%   file_name = string with the name of the tracks file used to load data.
%
% Author: A. Luchici, 2015

[file_name, dpath] = uigetfile('.csv'); % ask user to select .csv data file

% Extract number of pairs & number of frames.
tmp = csvread(fullfile(dpath, file_name), 0, 0, 'A1..C1');
n = tmp(1); % number of cells
nt = tmp(2); % maximum length of tracks 
dt = tmp(3); % interval between frames (seconds)
clear tmp

tracks_data = csvread(fullfile(dpath, file_name), 4, 0); % read .csv file

% Initialize output
ca = zeros(nt, 9, n);

% Extract tracks for each cell
for i = 1:n
    ca(:,1:3,i) = tracks_data(:,3*(i-1)+1:3*(i-1)+3);
end