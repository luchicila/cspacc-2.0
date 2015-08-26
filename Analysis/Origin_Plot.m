% simple script to plot cell paths from origin
% take cell paths split into X and Y paths (imageJ already does this)

prompt = 'Enter the cell track number' ;
            result = input(prompt) ;
            j = result

scalePathx = ca(1,1,j) ;
scalePathy = ca(1,2,j) ;

% subtract first XY value from all XY points

    X0 = ca(:,1,j) - scalePathx ;
    Y0 = ca(:,2,j) - scalePathy ;


       plot(X0 , Y0);

       hold on
       plot(X0(1),Y0(1),'or')
       plot(X0(end),Y0(end),'or')
