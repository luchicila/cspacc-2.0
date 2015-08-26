% Directionality Ratio (D/L) - Sometimes called a tortuosity index
% D is the straight shot/beeline distance
% L is the path length

% prompt = 'Enter the cell track number';
%             result = input(prompt);
%             j = result


 j = 1 ;

 for i = 1:n-1

     j = j + 1 ;

% Compute D - the beeline length

% This is the measured from the start point to the end point of the path
% start and end point for X
     xlS = ca_norm(1,1,j) ;
     xlE = ca_norm(end,1,j) ;

% start and end point for Y
     ylS = ca_norm(1,2,j) ;
     ylE = ca_norm(end,2,j) ;


     % Beeline length (D)
     D = sqrt((xlE - xlS)^2 + (ylE - ylS)^2) ;

% Compute L - the summed path length

% Get path info at each time point
% Length of X 'path'
     dX = diff(ca_norm(:,1,j)) ;

% Length of Y 'path'
     dY = diff(ca_norm(:,2,j)) ;

     % This is a summation of all time point lengths.
     L = sum(sqrt(dX.^2 +dY.^2)) ;

% Formula for the ratio. Where 1 is a perfectly straight path.
     dirRat(j) = D / L ;
     j = j + 1 ;

 end


% Plot all coefficients (1 is perfectly straight / 0 is a random path)
figure(1)
plot(dirRat,'ok')
     xlim([0 10])
     ylim([0 1.5])
     refline(0,1)
     title('Directional Ratio')
     xlabel('Cell ID')
     ylabel('D/L')

figure(2)
     stem(dirRat,'ok')
     xlim([0 10])
     ylim([-1.5 1.5])
     refline(0,1)
     title('Directional Ratio')
     xlabel('Cell ID')
     ylabel('D/L')

%%%%% Optional Plot %%%%%%
figure(3)
% Plot specific path
     Origin_Plot
     hold on

% Plot start and end point markers
     plot(X0(1),Y0(1),'or')
     plot(X0(end),Y0(end),'or')

% Sketch line between start and end points
     hline = line([  oX(1) oX(end) ], [ oY(1) oY(end) ]);
     hline.Color = 'k' ;
     hline.LineStyle = ':' ;
