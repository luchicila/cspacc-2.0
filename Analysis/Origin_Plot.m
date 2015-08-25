% simple script to plot cell paths from origin
% take cell paths split into X and Y paths (imageJ already does this)
% get first XY value

prompt = 'Enter the cell track number' ;
            result = input(prompt) ;
            j = result

scalePathx = ca_norm(1,1,j) ;
scalePathy = ca_norm(1,2,j) ;

% subtract first XY value from all XY points
for i = 1:length(ca_norm)

    oX = ca_norm(:,1,j) - scalePathx ;
    oY = ca_norm(:,2,j) - scalePathy ;

end

hold on
plot(oX , oY);
