% %This one works for steps of 1!
% 
% % This will look at how aligned the vectors are. This ignores magnitude.
% % Velocity autocorrelation functions can be built from here.
% 
% % definition => av dot bv = abs(av)*abs(bv)*cos(theta)
% %               cos(theta) = (av dot bv)/(abs(av)*abs(bv))
% %               theta = dot(A,B)/(norm(A)*norm(B))
% 
% % if cos(theta)~=1 then they are aligned
% % if cos(theta)~=0 then they are unrelated (approaching orthogonal)
% % if cos(theta)~=-1 then they are opposite (change in direction)
% 
% % xy angle to OX for first cell (the cell number will need to be changed)
% % Need differences between points (start and end points of path)
% % Get lengths of path x and y
% 
% % Need to use cell_norm to normalise cell direction to previous timepoints
% prompt = 'Enter the cell track number';
% result = input(prompt);
% j = result
% 
% % Get path distance at each time point
% X = diff(ca_norm(:,1,j)) ;
% Y = diff(ca_norm(:,2,j)) ;
% 
% 
% % Split for sequential path
% p1 = X(1:2:end) ;
% p2 = X(2:2:end) ;
% p3 = Y(1:2:end) ;
% p4 = Y(2:2:end) ;
% 
% % Get magnitude of the path (same as norm)
% A = sqrt(p1.^2 + p3.^2) ;
% B = sqrt(p2.^2 + p4.^2) ;
% C = A .* B ;
% 
% % Dot Product
% AdotB = ( p1 .* p2 ) + (p3 .* p4 ) ;
% 
% % Apply the formula for cosine similarity
% 
% cSim = AdotB ./ C ;
% 
% meancSim = mean(cSim) ;
% 
% figure()
% plot(cSim,'r')
% xlim([0 20]) ; ylim([-1.5 1.5]) ; refline(0,0) ;refline(0,1) ;
% ylabel('cos(\theta)')
% xlabel('\Delta t')
% title('')
% m = meancSim; hline = refline([0 m]); hline.Color = 'm' ;
% hline.LineStyle = '--' ;
