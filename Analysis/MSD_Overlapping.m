function [msd] = MSD_Overlapping(ca, n, nt)

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
        for k = 1:nt - s
            xd = ca(k + s,1,cn) - ca(k,1,cn) ;
            yd = ca(k + s,2,cn) - ca(k,2,cn) ;
            d(s, cn) = d(s) + xd^2 + yd^2 ;
        end
        sd(s, cn) = d(s, cn) / (nt - s + 1) ;
    end
end

tau = 1:nt ;
msd = mean(sd') ;
plot(log(tau), log(msd)) ;
xlabel('log(\tau)')
ylabel('log(MSD)')


errorbar(msd, std(d'))
xlabel('log(\tau)')
ylabel('log(MSD)')

end
