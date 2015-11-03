
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

for k = 1:Nt-1
    
    U = matFile{k}.x_flow ;
    V = matFile{k}.y_flow ;
    %   W = sqrt(matFile{k}.x_flow.^2 + matFile{1}.y_flow.^2) ;
    
    % Convert to double precision
    I2 = im2double(img{k}) ;
    % find the edge of the object using canny algorithm
    BW1 = edge(I2,'Canny') ;
    SE = strel('disk',4) ;
    % dilate
    dBW1 = imdilate(BW1, SE) ;
    % fill
    fBW1 = imfill(dBW1, 4, 'holes') ;
    % erode
    eBW1 = imerode(fBW1, SE) ;
    % multiply to remove background (both need to be double precision)
    zImg = +eBW1 .* I2 ;
    
%     % find the edge of the object using canny algorithm
%     BW2 = edge(I2,'Canny') ;
%     % dilate
%     dBW2 = imdilate(BW2, SE) ;
%     % fill
%     fBW2 = imfill(dBW2, 4, 'holes') ;
%     % copy b&w (I might want the original..)
%     SE2 = strel('disk',15) ;
%     % erode
%     eBW2 = imerode(fBW2, SE2) ;
%     % get cell edge line
%     edgeSL = edge(eBW2,'Canny') ;
%     [A, B] = find(edgeSL) ;
%     
    % Convert the grayscale image to RGB
    %     Irgb = cat(3,zImg,zImg,zImg) ;
    
    % create a coordinate grid the same size as the image to be overlayed
    [x, y] = meshgrid(1:1:512, 1:1:512) ;
    
    % A vector the length of the image in one dimension
    N = size(zImg,1);
    
        %     find where the zero values are (these are background)
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
%     
%         % stop any zeros from being start points
        startx(startx==0) = nan ;
        starty(starty==0) = nan ;
%     %
         startx = reshape(startx, 1, size(startx,1)*size(startx,2)) ;
         starty = reshape(starty, 1, size(starty,1)*size(starty,2)) ;
    
    %   Arbitrarily chosen points (these give a pair of points at opposing
    %   'sides' of the lamella
    %   startx = [133 365] ;
    %   starty = [283 180] ;
    
    %   Edge points at the start...
%      startx = B ;
%     starty = A ;
%     
    %   Compute the stream lines
    xy = stream2(x,y,U,V,B,A) ;
    
    %   Show the images in sequence
    imshow(zImg) ;
    hold on
    
    % Plot end points and filters spurious points
    n = 1 ;
    for i = 1:length(xy)
        pos = xy{n} ;
        
        pDiff1 = pos(end,1) - pos(1,1) ;
        pDiff2 = pos(end,2) - pos(1,2) ;
        m = [pDiff1 pDiff2] ;
        if m(:,1) >= 25 || m(:,2) >= 25
            
            P = plot(pos(end,1),pos(end,2),'o',...
                'MarkerEdgeColor','m',...
                'MarkerFaceColor','c',...
                'MarkerSize', 12) ;
            hold all
        end
        n = n + 1 ; 
    end
    
    %  imshow(Irgb)
    %  hold on
    %
    %  Items that can be overlaid or plotted individually
    
    %  Streamlines Properties
%             sln = streamline(xy) ;
%             set(sln,'Color','c','LineStyle','-') ;
%     
    %   Streamslice Properties
    %   slc = streamslice(x,y,X,Y) ;
    %   set(slc,'Color','g','LineStyle','-') ;
    
    %   Contour
    %   [C,cn] = contour(x,y,W) ;
    %   cn.ShowText = 'on' ;
    %   cn.LineColor = 'flat' ;
    
    drawnow ;
    
    %   Convert the figure to an image
    overlay = getframe(gcf) ;
    
    %   Specify the file where to write the overlayed image (PNG format)
    imagePath = fullfile(folder, ...
        ['frame-', num2str(1000 + k), '.png']);
    
    %   Save overlayed image to file
    imwrite(overlay.cdata, imagePath);
    
    hold off
    
    
end


