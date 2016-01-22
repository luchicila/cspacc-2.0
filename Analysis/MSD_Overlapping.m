function MSD_Overlapping(ca, n, nt)

% Mean Squared Displacement Overlapping
% Input:
%   ca = [nt x 9 x n] matrix with the (x, y, z) position of the cell.
%   n = number of cells
%   nt = maximum tracks length

% Output:
%   msd = vector of length nt

d = zeros(nt, n);

for s = 1:nt

    for cn = 1:n

        for k = 1:nt - s

            xd = ca(k + s, 1, cn) - ca(k, 1, cn);
            yd = ca(k + s, 2, cn) - ca(k, 2, cn);

            d(s, cn) = d(s) + xd^2 + yd^2;
        end
        sd(s, cn) = d(s, cn) / (nt - s + 1);
        end
    end



tau = 1:nt;
msd = mean(sd');

dx = log(tau(4)) - log(tau(1));
dy = log(msd(4)) - log(msd(1));
slope_msd = dy / dx;
slope_msd = round(slope_msd, 2, 'significant');

str = cellstr(num2str((slope_msd),'Slope = %d'));

figure()
plot(log(tau), log(msd))
xlabel('log(\tau)')
ylabel('log(MSD)')
text(log(tau(4)), log(msd(4)), str, 'Color', 'Black', 'FontSize', 14)
title('Mean Squared Displacement Analysis')

figure()
plot(tau(1:nt-1), msd(1:nt-1))
xlabel('\tau')
ylabel('MSD')
title('Mean Squared Displacement Analysis')

figure()
ebar_msd = std(d') / (sqrt(n));
ebar_msd = ebarMSD(1:end-1);
errorbar(msd(1:end-1), ebarmsd)
xlabel('\tau')
ylabel('MSD')
title('Mean Squared Displacement Analysis')

% This plots shaded error bars using the 3rd party shaded error bar function.
% Optional but the standard plot is
figure()
err_bar1 = std(d') / (sqrt(n));
plotX = [1:nt-1];
plotY = ([msd(1:end-1)]);
% The last point is a zero so to avoid the plot looking daft I'll remove it
% here
err_bar = err_bar1(1:end-1);
shaded_error_bar(plotX,plotY,err_bar)
xlabel('\tau')
ylabel('MSD')
title('Mean Squared Displacement Analysis')
% this overlays the line so I can change the colour...
% hold on ; plot(MDLR, 'k') ;

end
