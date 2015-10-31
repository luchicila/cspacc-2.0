% Computation and visualisation of streamlines from interpolated
% PIV data
% prompt = 'Enter Frame Number';
% result = input(prompt);
% c = result

%% loads all images to be overlayed (either stationary or moving tif files)
TIF = uigetdir() ;
imgFile = dir(fullfile(TIF, '*.tif')) ;

for i = 1:numel(imgFile) ;
    
    filenameImg = imgFile(i).name ;
    I = imread(fullfile(TIF,filenameImg)) ;
    img{i} = I ;
    
end
%% load all data files (mat files of interpolated data)
MAT = uigetdir() ;
dataFile = dir(fullfile(MAT,'*.mat')) ;

% tells me what's in the current directory
% f = what('') ;
% data = f.mat ;

for i = 1:numel(dataFile)
    
    filenameData = dataFile(i).name;
    M = load(fullfile(MAT,filenameData)) ;
    matFile{i} = M ;
    
end
%% This is where the overlaid images will get saved
folder = uigetdir();


%%
% Compute streamlines
Nt = length(imgFile) ;
n = 1 ;
for k = 1:Nt-1
    
    X = matFile{n}.x_flow ;
    Y = matFile{n}.y_flow ;
    W = sqrt(matFile{n}.x_flow.^2 + matFile{n}.y_flow.^2) ;
    
    % Convert to double precision
    I2 = im2double(img{n}) ;
    
    % find the edge of the object using canny algorithm
    BW1 = edge(I2,'Canny') ;
    
    % copy b&w (I might want the original..)
    BW2 = BW1 ;
    SE = strel('disk',4);
    
    % dilate
    dBW1 = imdilate(BW2, SE);
    
    % fill
    fBW1 = imfill(dBW1, 4, 'holes');
    
    % erode
    eBW1 = imerode(fBW1, SE);
    
    % multiply to remove background
    % (both need to be double precision)
    zImg = +eBW1 .* I2 ;
    
    % create a coordinate grid the same size as the image to be overlayed
    [x, y] = meshgrid(1:1:512, 1:1:512) ;
    
    % A vector the length of the image in one dimension
    N = size(zImg,1);
    
    % find where the zero values are (these are background)
    k2 = 1;
    for j = 1:N
        k1 = 1;
        for i = 1:N-1
            if zImg(j,i) == 0 || zImg(j,i+1) ~= 0
                startx(k2,k1) = i+1;
                starty(k2,k1) = j;
                k1 = k1 + 1;
            end
        end
        k2 = k2 + 1;
    end
    
    % stop any zeros from being start points
    startx(startx==0) = nan ;
    starty(starty==0) = nan ;
    
    startx = reshape(startx, 1, size(startx,1)*size(startx,2)) ;
    starty = reshape(starty, 1, size(starty,1)*size(starty,2)) ;
    
    % Arbitrarily chosen points
    startx = [133 365] ;
    starty = [283 180] ;
    
    xy = stream2(x,y,X,Y,startx,starty) ;
    
    
    %      Show the images in sequence
    imshow(zImg) ;
    hold on
    
    %      Items that can be overlaid or plotted individually
%     h = streamline(xy) ;
    sl = streamslice(x,y,X,Y) ;
%     [C,cn] = contour(x,y,W) ;
    
    %       Streamlines Properties
    %       set(h,'Color','c','LineStyle','-') ;
    
    %       Streamslice Properties 
    %       set(sl,'Color','g','LineStyle','-') ;
    %
    %       Contour Properties
    %       cn.ShowText = 'on' ;
    %       cn.LineColor = 'flat' ;
    
    drawnow ;
    
    % Convert the figure to an image
    overlay = getframe(gcf) ;
    
    % Specify the file where to write the overlayed image (tif format)
    imagePath = fullfile(folder, ...
        ['frame-', num2str(1000 + n), '.png']);
    %
    %     % Save overlayed image to file
    imwrite(overlay.cdata, imagePath);
    
    hold off
    
    n = n + 1 ;
    
    
end
