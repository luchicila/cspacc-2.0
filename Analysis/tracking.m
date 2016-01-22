%% Load images to be overlayed (either stationary or moving tif files).

% Lawrence Yolland last modified 28th Nov 2015
png_1 = uigetdir();
im_file_1 = dir(fullfile(png_1, '*.png'));

for i = 1:numel(im_file_1);
    filename_im_1 = im_file_1(i).name;
    im_cell_body = imread(fullfile(png_1, filename_im_1));
    try
        im_cell_body = im_cell_body(:, :, 2);
    catch
    end
    img_1{i} = im_cell_body;
end

%%
% Select save folder location.
folder = uigetdir();


%%
Nt = length(im_file_1) ;

for k = 1:Nt - 1
    
    I2 = im2double(img_1{k}); % Convert to double precision.
    I2_tmp = medfilt2(I2,[12 12]);
    I2_tmp(I2_tmp < 1) = 0; %
    BW1 = edge(I2_tmp, 'Canny'); % Find object edge using canny algorithm.
    SE = strel('disk', 4); % Creates a flat disk of radius R
    dilate_BW1 = imdilate(BW1, SE); % dilate
    fill_BW1 = imfill(dilate_BW1, 8, 'holes'); % fill
    erode_BW1 = imerode(fill_BW1, SE); % erode
    BW2 = bwareaopen(erode_BW1,80,8); % Removes all connected points smaller than ?px
    
    BW_label = bwlabel(BW2);
    BW_rp = regionprops(BW2);
    %     s = BW_rp;
    %   centroids = cat(1, s.Centroid);
    
    stats = regionprops('table',BW2,'Centroid',...
        'MajorAxisLength','MinorAxisLength');
    centre = [stats.Centroid];
    diameter = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
    radii = diameter/2;
    
    %     imshow(I2);
    %     hold on;
    %     plot(centre(:,1),centre(:,2), 'mx');
    %     viscircles(centre, radii,...
    %         'LineStyle','-',...
    %         'Color', 'm');
    
    centroid_x(k) = centre(:,1);
    centroid_y(k) = centre(:,2);
    
    
    
    
    %     drawnow
    %
    %     Overlay = getframe(gcf);
    %     overlay = Overlay.cdata;
    %     dx = abs(size(overlay, 2) - 512);
    %     dy = abs(size(overlay, 1) - 512);
    %     im_to_save = overlay(ceil(dy/2):ceil(dy/2) + 511, ...
    %         ceil(dx/2):ceil(dx/2) + 511, ...
    %         :);
    %
    %     % Specify the file where to write the overlayed image (PNG format)
    %     image_path = fullfile(folder, ['frame-', num2str(1000 + k), '.png']);
    %
    %     % Save overlayed image to file
    %     imwrite(im_to_save, image_path);
    
    
end
    plot(centroid_x, centroid_y,'-b')
