
% Computation and visualisation of streamlines from interpolated
% PIV data.

% Need to fix comments as per google python standards...

%% Load images to be overlayed (either stationary or moving tif files).
tif1 = uigetdir() ;
img_file = dir(fullfile(tif1,'*.tif'));

for i = 1:numel(img_file);
    filename_img1 = img_file(i).name;
    img_cellBody = imread(fullfile(tif1, filename_img1));
    img1{i} = img_cellBody;
end

%% Load images with segmented cell body.
tif2 = uigetdir();
img_file2 = dir(fullfile(tif2, '*.tif'));

for i = 1:numel(img_file2);
    filename_img2 = img_file2(i).name;
    img_no_cell_body = imread(fullfile(tif2, filename_img2));
    img2{i} = img_no_cell_body;
end

%% Load data files (mat files of interpolated data).
MAT = uigetdir();
data_file = dir(fullfile(MAT, '*.mat'));

for i = 1:numel(data_file)
    filename_data = data_file(i).name;
    M = load(fullfile(MAT, filename_data));
    mat_file{i} = M;
end
%% Select save folder location.
folder = uigetdir();

%%
% Compute streamlines.
Nt = length(img_file);


for k = 1:Nt-1
    
    U = mat_file{k}.x_flow; % Define U,V components field vectors.
    V = mat_file{k}.y_flow;
    % W = sqrt(matFile{k}.x_flow.^2 + matFile{1}.y_flow.^2) ;
    
    I2 = im2double(img1{k}); % Convert to double precision.
    BW1 = edge(I2, 'Canny'); % Find object edge using canny algorithm.
    SE = strel('disk', 4); % Creates a flat disk of radius R
    dilate_BW1 = imdilate(BW1, SE); % dilate
    fill_BW1 = imfill(dilate_BW1, 8, 'holes'); % fill
    erode_BW1 = imerode(fill_BW1, SE); % erode
    zero_img = +erode_BW1 .* I2;% multiply to remove background
    
    % Find the area of the cell
%     number_of_ones= find(erode_BW1 == 1);
%     area(k) = number_of_ones(end,1) * 0.1^2;
%     areap = area/max(area);
%     mean_areap = mean(areap(2:end)-areap(1:end-1)); 
%     plot(area/max(area))
%     set(gca,'YLim',[0, 1])
    
%     cell_area(Nt, erode_BW1)



    
    
% im = imfilter(img1{k}, gauss);

SE2 = strel('disk', 15); % Strel radius has changed
erode_BW2 = imerode(fill_BW1, SE2);
edge_line = edge(erode_BW2, 'Canny'); % Get cell edge line
[A, B] = find(edge_line);

no_cell_body = im2double(img2{k});
no_cell_body(no_cell_body == 0) = no_cell_body(1, 1);

% find difference between filled image and image with holes
img_fix = fill_BW1 - no_cell_body;
% where the image = 1, make it = 0
img_fix(img_fix == 1 - no_cell_body(1, 1)) = no_cell_body(1, 1);
img_fix(img_fix == no_cell_body(1,1)) = 0;
img_fix(img_fix ~=0) = 1;
% multiply filled image with specific image details
img_segmented = fill_BW1 .* img_fix;

% Takes the U and V data points and multiplies by 0 any vector that
 U = img_segmented .* U;
 V = img_segmented .* V;

% im = imfilter(img1{i}, gauss);

 
 
d = divergence(U, V);
d(d > 0.5) = 0;
d(d < -0.5) = 0;



% Convert the grayscale image to RGB
%  drgb = cat(3,d,d,d) ;


% create a coordinate grid the same size as the image to be overlayed
[x, y] = meshgrid(1:1:512, 1:1:512);

% A vector the length of the image in one dimension
%   N = size(zImg,1);
%
%         % find where the zero values are (these are background)
%         k2 = 1;
%         for j = 1:N
%             k1 = 1;
%             for i = 1:N-1
%                 if (zImg(j,i) == 0 && zImg(j,i+1) ~= 0) || ...
%                         (zImg(j,i) ~= 0 && zImg(j,i+1) == 0)
%                     startx(k2,k1) = i+1;
%                     starty(k2,k1) = j;
%                     k1 = k1 + 1;
%                 end
%             end
%             k2 = k2 + 1;
%         end
%
%         % stop any zeros from being start points
%         startx(startx==0) = nan ;
%         starty(starty==0) = nan ;
%
%         startx = reshape(startx, 1, size(startx,1)*size(startx,2)) ;
%         starty = reshape(starty, 1, size(starty,1)*size(starty,2)) ;

%   Arbitrarily chosen points (these give a pair of points at opposing
%   'sides' of the lamella
%   startx = [133 365] ;
%   starty = [283 180] ;

%   Compute the stream lines
S = stream2(x, y, U, V, B, A);

%   Show the images in sequence overlaid onto whatever image is needed
imagesc(d);
colormap parula

% hold on

% Spurious streamlines and end points are also be plotted. This fixs that
% by setting a minimum length threshold on each x{i} vector.
% this threshold is arbitrary.

%     test1 = zeros(length(xy),1) ;
%     test2 = zeros(length(xy),1) ;
% for i = 1:length(S)
%     s_list = S{i};
%     %       test1(i) = pos(end,1) ;
%     %       test2(i) = pos(end,2) ;
%     s_diff1 = s_list(end, 1) - s_list(1, 1);
%     s_diff2 = s_list(end, 2) - s_list(1, 2);
%     mag_s = sqrt(s_diff1^2 + s_diff2^2);
%     % if m(:,1) >= 50 || m(:,2) >= 50
%     if mag_s >= 10
%         P = plot(s_list(end, 1), s_list(end, 2), ...
%             'o', ...
%             'MarkerEdgeColor', 'm', ...
%             'MarkerFaceColor', 'c', ...
%             'MarkerSize',12);
%         hold all
%     end
% end
%  Items that can be overlaid or plotted individually
%  Streamlines Properties
%  sln = streamline(S) ;
%  set(sln,'Color','c','LineStyle','-') ;
%
%  Streamslice Properties
%    slc = streamslice(x, y, U, V,'method','cubic');
%    set(slc, 'Color', 'c', 'LineStyle', '-');

%  Contour
%  [C, cn] = contour(x, y, W) ;
%  cn.ShowText = 'on' ;
%  cn.LineColor = 'flat' ;




drawnow;

%  Convert the figure to an image
Overlay = getframe(gcf);

%  Specify the file where to write the overlayed image (PNG format)
image_path = fullfile(folder, ['frame-', num2str(1000 + k), '.png']);

%  Save overlayed image to file
imwrite(Overlay.cdata, image_path);
% hold off
clf
end
