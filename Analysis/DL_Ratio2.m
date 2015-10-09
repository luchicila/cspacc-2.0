function DL_Ratio2(ca,n)

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
    DLR2(i) = D / L ;
end

figure()
stem(DLR2,'ok')
xlim([ 0.5 n+0.5 ])
ylim([-0.5 1.5])
meanDLR2 = mean(DLR2);
hline1 = refline([0 meanDLR2]);
hline1.Color = 'm' ; hline1.LineStyle = '-' ;
hline2 = refline(0,1) ;
hline2.Color = 'k' ; hline2.LineStyle = ':' ;

title('D / L')
xlabel('Cell [ID]')
ylabel('Directionality Ratio')
legend('D/L Value','Mean D/L Value')

end

