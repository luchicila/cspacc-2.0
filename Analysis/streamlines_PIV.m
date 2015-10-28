% Get images
% p = uigetdir();
% % imgFile = dir(fullfile(p, '*.tif'));
%  
% % Get data
% q = uigetdir();
% % f = dir(fullfile(q,'*.dat')) ; 
% addpath('p','q')
% 
% 
% n = 1;
% t0 = 1;
% Nt = 1;
% % imgFile = dir(fullfile(p, '*.tif'));
% 
% dt = length(imgFile);
% for k = t0:dt:Nt-dt
% I = imread(fullfile(p, imgFile(n).name));
% V = readDataFile(fullfile(q,f(n).name));
% end


p = uigetdir()
q = uigetdir()

load('filteredFrame-10008.mat')
I = imread('frame-1008.tif') ;
I2 = im2double(I) ;

BW1 = edge(I,'Canny') ;
% copy b&w
BW2 = BW1 ;
SE = strel('disk',4);
% dilate
dBW1 = imdilate(BW2, SE);
% fill
fBW1 = imfill(dBW1, 4, 'holes');
% erode 
eBW1 = imerode(fBW1, SE);
% multiply to remove background

zImg = +eBW1 .* I2 ;
imshow(zImg)

[x, y] = meshgrid(1:1:512, 1:1:512) ;

N = size(zImg,1);

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


startx(startx==0) = nan;
starty(starty==0) = nan ;

startx = reshape(startx, 1, size(startx,1)*size(startx,2));
starty = reshape(starty, 1, size(starty,1)*size(starty,2));

xy = stream2(x,y,x_flow,y_flow,startx(1:300:end),starty(1:300:end));

figure()
imshow(zImg)
hold on

h = streamline(xy) ;
set(h,'Color','magenta') ;






