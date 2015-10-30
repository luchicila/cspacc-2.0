% Computation and visualisation of streamlines from interpolated
% PIV data
% prompt = 'Enter Frame Number';
% result = input(prompt);
% c = result

%%
% loads all images to be overlayed
TIF = uigetdir() ;
imgFile = dir(fullfile(TIF, '*.tif')) ;

for i = 1:numel(imgFile) ;

    filenameImg = imgFile(i).name ;
    I = imread(fullfile(TIF,filenameImg)) ;
    img{i} = I ;

end

% load all data files
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

%%
% Compute streamlines
Nt = length(dataFile) ;
n = 1 ;
for k = 1:Nt-1

    X = matFile{n}.x_flow ;
    Y = matFile{n}.y_flow ;

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

    % Arbitrarily chosen points
    startx = [133 367] ;
    starty = [282 180] ;

  

    startx = reshape(startx, 1, size(startx,1)*size(startx,2)) ;
    starty = reshape(starty, 1, size(starty,1)*size(starty,2)) ;

    xy = stream2(x,y,X,Y,startx,starty) ;

    imshow(zImg)
    hold on
    h = streamline(xy) ;
    sl = streamslice(x,y,X,Y) ;

    set(h,'Color','c','LineStyle','-') ;
    set(sl,'Color','m','LineStyle','-') ;

    % clear X Y startx starty

    n = n + 1 ;

    drawnow ;
    % clear X Y startx starty

end
