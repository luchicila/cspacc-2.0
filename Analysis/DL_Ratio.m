function DL_Ratio(ca_norm,n,nt) ;

% Directionality Ratio of cell paths
% Input:
%   ca = [nt x 9 x n] matrix with the (x, y, z) position of the cell.
%   n = number of cells
%   nt = maximum tracks length

% Output:
%   Plots of directionality ratio with and without error bars

for i = 1:n
    for k = 1:(nt-1)

        % D => beeline distance
        xd(k,i) = ca_norm( k + 1,1,i ) - ca_norm( 1,1,i ) ;
        yd(k,i) = ca_norm( k + 1,2,i ) - ca_norm( 1,2,i ) ;

        % L
        xl(k,i) = ca_norm( k + 1,1,i ) - ca_norm( k,1,i ) ;
        yl(k,i) = ca_norm( k + 1,2,i ) - ca_norm( k,2,i ) ;

        D(k,i) = sqrt((xd(k,i).^2) + (yd(k,i).^2)) ;

        L(k,i) = sqrt((xl(k,i).^2) + (yl(k,i).^2)) ;

        Path = cumsum(L) ;

    end
end

DLR =  D./Path ;

MDLR = mean(DLR') ;





for i = 1:n

        magx(i) = ca_norm( end ,1,i ) - ca_norm( 1,1,i ) ;
        magy(i) = ca_norm( end ,2,i ) - ca_norm( 1,2,i ) ;

end
magD =  sqrt(magx.^2 + magy.^2) ;
angleD = atan2(magy,magx) ; 


% Plot with no errorbars of mean DLR
% figure()
% plot(MDLR,'b')
% ylim([0 1])
% xlabel('Time')
% ylabel('Directionality Ratio')
% title('< D/L >')

% Error bars are SEM
figure()
hline = errorbar(MDLR, std(DLR')/sqrt(n)) ;
hline.Color = 'b' ;
hold on
plot(MDLR,'k')
xlabel('Time')
ylabel('Directionality Ratio')
title('< D/L >')

% All tracks and their respective DLR
figure()
plot(DLR)
xlabel('Time')
ylabel('Directionality Ratio')
str = cellstr(num2str((1:n)' ,'Cell Track %d')) ;
% xlim([0 50])
legend(str,'Location','Best')
title('< D/L >')

% This plot shaded error bars using the 3rd party shaded error bar function.
% Optional!!
errBar = std(DLR')/sqrt(n) ; plotX = [1:nt-1] ; plotY = MDLR ;
figure()
shadedErrorBar(plotX,plotY,errBar)
xlabel('Time')
ylabel('Directionality Ratio')
title('< D/L >')
% this overlays the line so I can change the colour...
% hold on ; plot(MDLR, 'k') ;

end
