function MSD_NonOverlapping(ca, n, nt)

% Mean Squared Displacement Non Overlapping
% Input:
%   ca = [nt x 9 x n] matrix with the (x, y, z) position of the cell.
%   n = number of cells
%   nt = maximum tracks length

% Output:
%   msdn = vector of length nt

t = 1;

for t = 1:nt-1
    m = 1;
    clear sd
    for cn = 1:n
        for k = 2:t:nt
            xd = ca(k,1,cn) - ca(k-1,1,cn);
            yd = ca(k,2,cn) - ca(k-1,2,cn);
            sd(m) = xd^2 + yd^2;
            m = m + 1;
        end
    end
    msdn(t) = mean(sd);
end

plot(msdn,':o')
title('Mean Squared Displacement Analysis - Non Overlapping')
xlabel('Time')
ylabel('MSD')

end
