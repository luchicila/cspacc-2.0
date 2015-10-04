function [DLR] = DL_Ratio(old)(ca_norm, n)

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
    xlS = ca(1,1,i) ;
    xlE = ca(end,1,i) ;
    % start and end point for Y
    ylS = ca(1,2,i) ;
    ylE = ca(end,2,i) ;
    % Beeline length (D)
    D = sqrt((xlE - xlS)^2 + (ylE - ylS)^2) ;
    % Compute L - the summed path length
    % Get path info at each time point

    % Length of X 'path'
    dX = diff(ca(:,1,i)) ;
    % Length of Y 'path'
    dY = diff(ca(:,2,i)) ;
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

figure(5)
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%so this gives me the scatter plots etc but to get the plots in the paper I need
%this script.


for s = 1:nt
  for i = 1:n
        xlS(i) = ca(1,1,i) ;
        xlE(i) = ca(end,1,i) ;
        % start and end point for Y
        ylS(i) = ca(1,2,i) ;
        ylE(i) = ca(end,2,i) ;

        for cn = 1:n
            for k = 1:nt - s
            %this gives me the difference between tp
            xd = ca( k + s,1,cn ) - ca( k,1,cn ) ;
            yd = ca( k + s,2,cn ) - ca( k,2,cn ) ;
            %gives me the length of the the vectors
            d( s, cn ) =  sqrt(sum(d( s ) + xd^2 + yd^2))   ;
        end
            DLR(s,cn) =  sqrt((xlE(i) - xlS(i)).^2 + (ylE(i) - ylS(i)).^2) / d( s, cn) ;
          end
  end
end



dRat = mean( DLR' ) ;
figure()
plot(dRat)

end
    xlS = ca_norm(1,1,i) ;
    xlE = ca_norm(end,1,i) ;
    % start and end point for Y
    ylS = ca_norm(1,2,i) ;
    ylE = ca_norm(end,2,i) ;
