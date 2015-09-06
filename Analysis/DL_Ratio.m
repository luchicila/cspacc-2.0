function [DLR] = DL_Ratio(ca_norm, n)

% Directionality Ratio (D/L) - Sometimes called a tortuosity index
% D is the straight shot/beeline distance
% L is the path length
% Input:
%   ca_norm = [nt x 9 x n] matrix with the (x, y, z) position of the cell.
%   n = number of cells

% Output:
%   dirRat = vector of length n providing the tortosity index of each cell
%   track

for i = 1:n
    % Compute D - the beeline length
    % This is the measured from the start point to the end point of the path
    % start and end point for X
    xlS = ca_norm(1,1,i) ;
    xlE = ca_norm(end,1,i) ;
    % start and end point for Y
    ylS = ca_norm(1,2,i) ;
    ylE = ca_norm(end,2,i) ;
    % Beeline length (D)
    D = sqrt((xlE - xlS)^2 + (ylE - ylS)^2) ;
    % Compute L - the summed path length
    % Get path info at each time point
    % Length of X 'path'
    dX = diff(ca_norm(:,1,i)) ;
    % Length of Y 'path'
    dY = diff(ca_norm(:,2,i)) ;
    % This is a summation of all time point lengths.
    L = sum(sqrt(dX.^2 +dY.^2)) ;
    % Formula for the ratio. Where 1 is a perfectly straight path.
    DLR(i) = D / L ;
end
% Plot all coefficients (1 is perfectly straight / 0 is a random path)
figure(1)
plot(DLR,'ok')
xlim([0 n])
ylim([0 1.5])
refline(0,1)
title('Directional Ratio')
xlabel('Cell ID')
ylabel('D/L')

figure(2)
stem(DLR,'ok')
xlim([0 n + 1])
ylim([-0.5 1.5])
refline(0,1)
title('Directional Ratio')
xlabel('Cell ID')
ylabel('D/L')
MDLR = mean(DLR); hline = refline([0 MDLR]); hline.Color = 'm' ;
hline.LineStyle = ':' ;

end

 %%%%% Optional Plot %%%%%%
% figure(3)
% % Plot specific path
% Origin_Plot(ca_norm, n)
% hold on
% % Sketch line between start and end points
% hline = line([ xlS xlE ], [ ylS ylE ]);
% hline.Color = 'k' ;
% hline.LineStyle = ':' ;
%
% end
