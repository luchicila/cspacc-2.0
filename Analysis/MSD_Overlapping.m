function MSD_Overlapping(ca,n,nt)

% Mean Squared Displacement Overlapping
% Input:
%   ca = [nt x 9 x n] matrix with the (x, y, z) position of the cell.
%   n = number of cells
%   nt = maximum tracks length

% Output:
%   msd = vector of length nt

d = zeros(nt,n) ;

for s = 1:nt
    for cn = 1:n
        for k = 1:nt - 1
            xd = ca(k + 1,1,cn) - ca(k,1,cn) ;
            yd = ca(k + s,2,cn) - ca(k,2,cn) ;
            
            d(s, cn) = d(s) + xd^2 + yd^2 ;
        end
        sd(s, cn) = d(s, cn) / (nt - s + 1) ;
    end
end

tau = 1:nt ;
mda = mean(DA') ;

xdiff = log(tau(4)) - log(tau(1)) ;
ydiff = log(msd(4)) - log(msd(1)) ;
slopemsd = ydiff/xdiff ;
slopemsd = round(slopemsd,3,'significant') ;

str = cellstr(num2str((slopemsd),'Slope = %d')) ;

figure()
plot(log(tau), log(msd))
xlabel('log(\tau)')
ylabel('log(MSD)')
text(log(tau(4)),log(msd(4)),str,'Color','Black','FontSize',14)
title('Mean Squared Displacement Analysis')

figure()
plot(tau(1:nt-1),mda(1:nt-1))
xlabel('\tau')
ylabel('MSD')
title('Mean Squared Displacement Analysis')

figure()
ebarMSD = std(d')/(sqrt(n)) ;
ebarMSD = ebarMSD(1:end-1) ;
errorbar(msd(1:end-1), ebarMSD)
xlabel('\tau')
ylabel('MSD')
title('Mean Squared Displacement Analysis')

% This plots shaded error bars using the 3rd party shaded error bar function.
% Optional but the standard plot is
figure()
errBar1 = std(d')/(sqrt(n)) ;
plotX = [1:nt-1] ;
plotY = ([msd(1:end-1)]) ;
% The last point is a zero so to avoid the plot looking daft I'll remove it
% here
errBar = errBar1(1:end-1) ;
shadedErrorBar(plotX,plotY,errBar)
xlabel('\tau')
ylabel('MSD')
title('Mean Squared Displacement Analysis')
% this overlays the line so I can change the colour...
% hold on ; plot(MDLR, 'k') ;

end
