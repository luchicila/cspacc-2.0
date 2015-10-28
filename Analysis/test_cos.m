% BROKEN
% Velocity Autocorrelation Function
% Input:
%   vdir = [nt x 2 x n] matrix with precalculated angles position of 
%   between subsequent path vectors the cell.
%   n = number of cells
%   nt = maximum track length

% Output:
%   .............

% Definition => av dot bv = abs(av)*abs(bv)*cos(theta)
%               cos(theta) = (av dot bv)/(abs(av)*abs(bv))
%               theta = dot(A,B)/(norm(A)*norm(B))
% 
% When: cos(theta)~=1 then they are aligned
%       cos(theta)~=0 then they are unrelated (approaching orthogonal)
%       cos(theta)~=-1 then they are opposite (change in direction)

c = zeros(nt,n) ;
alpha = vdir ;

for j = 1:nt
    for cn = 1:n
        for k = 1:nt - j
            ad = alpha(k + j,1,cn) - alpha(k,1,cn) ;
            c(j,cn) = c(j) + cos(ad) ;
        end
            DA(j, cn) = c(j, cn) / (nt - j + 1) ;
    end
end

