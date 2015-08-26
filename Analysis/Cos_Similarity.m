%This one works for steps of 1!

% This will look at how aligned the vectors are. This ignores magnitude.
% Velocity autocorrelation functions can be built from here.

% definition => av dot bv = abs(av)*abs(bv)*cos(theta)
%               cos(theta) = (av dot bv)/(abs(av)*abs(bv))
%               theta = dot(A,B)/(norm(A)*norm(B))

% if cos(theta)~=1 then they are aligned
% if cos(theta)~=0 then they are unrelated (approaching orthogonal)
% if cos(theta)~=-1 then they are opposite (change in direction)


% xy angle to OX for first cell (the cell number will need to be changed)
% Need differences between points (start and end points of path)
% Get lengths of path x and y


% need to use cell_norm to normalise cell direction to previous timepoints

% prompt = 'Enter the cell track number';
%             result = input(prompt);
%             j = result
%
%             prompt = 'Enter the time step';
%                         result = input(prompt);
%                         t = result

t = %%
j = %%
    % Get path distance at each time point
    X = diff(ca_norm(:,1,j)) ;
    Y = diff(ca_norm(:,2,j)) ;

    % Keep this as it could be useful
    Path = [X Y] ;

    % Split for sequential paths
    p1 = X(1:t:end)
    p2 = X(2:t:end)
    p3 = Y(1:t:end)
    p4 = Y(2:t:end)

            % Get magnitude of the path (same as norm)
            A = sqrt(p1.^2 + p3.^2) ;
            B = sqrt(p2.^2 + p4.^2) ;
            C = A.*B ;

                % Dot Product
            for i = 1:length(p1)

                AdotB = ( p1 .* p2 ) + (p3 .* p4 ) ;

            end

            % Apply the formula for cosine similarity

            cSim = AdotB ./ C ;


        roundcSim = round(cSim) ; % pile of crap
        meancSim = mean(cSim) ;



    stem(cSim,'g') ;
    hold on

    hold on
    plot(cSim,':m')
hold on
    xlim([0 20]) ; ylim([-2 2]) ; refline(0,0) ;refline(0,1) ;
    m = meancSim; hline = refline([0 m]); hline.Color = 'r' ;
    hline.LineStyle = '--' ;


%TRY GENERALISE THE ABOVE (NO PROMPT)...
