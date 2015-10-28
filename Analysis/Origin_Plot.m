function Origin_Plot(ca,n)

% Plot cell paths from common origin
% Cell paths must be split into X and Y paths (imageJ already does this)

% Input:
%   ca_norm = [nt x 9 x n] matrix with the (x, y, z) position of the cell
%   n = number of cells

% Output:
%   Plot of cell tracks, stemming from a common origin.

for i = 1:n

    scalePathx = ca(1,1,i) ;
    scalePathy = ca(1,2,i) ;
    % subtract first XY value from all XY points
    X0 = ca(:,1,i) - scalePathx ;
    Y0 = ca(:,2,i) - scalePathy ;

    plot(X0,Y0);

    hold on

end

ylim([-20 25])
xlabel('x')
ylabel('y')
str = cellstr( num2str((1:n)','Cell Track %d') );
legend(str)
title('Tracked Nuclei of Drosophila Embryonic Hemocytes')
hold off

% This is supposed to plot all tracks and their respective straight shot paths.
% It always breaks.
figure()
for j = 1:n
    subplot(4,2,j)
    plot(ca(:,1,j),ca(:,2,j),'k')
    str = cellstr(num2str((j)' ,'Cell Track %d')) ;
    title(str)

    hold all

    subplot(4,2,j)
    b = line( [  ca(1,1,j) ca(end,1,j) ] , ...
        [ ca(1,2,j) ca(end,2,j) ] )
    b.Color = 'blue'
    str = cellstr(num2str((j)' ,'Cell Track %d')) ;
    title(str)
end


% for j = 1:n
%
%     X1 = ca(:,1,i) ;
%     Y1 = ca(:,2,i) ;
%
%     plot(X1,Y1)
%
%     hold on
% end
%
% xlabel('x')
% ylabel('y')
% str = cellstr( num2str((1:n)','Cell Track %d') );
% legend(str)
% title('Tracked Nuclei of Drosophila Embryonic Hemocytes')
% hold off


end



    scalePathx = ca(1,1,1) ;
    scalePathy = ca(1,2,1) ;
    % subtract first XY value from all XY points
    X0 = ca(:,1,1) - scalePathx ;
    Y0 = ca(:,2,1) - scalePathy ;

    plot(X0,Y0);

    hold on










