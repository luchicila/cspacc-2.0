% This will look at how aligned the vectors are. This ignores magnitude.
% Velocity autocorrelation functions can be built from here.

% definition => av dot bv = abs(av)*abs(bv)*cos(theta)
%               cos(theta) = (av dot bv)/(abs(av)*abs(bv))
%               theta = dot(A,B)/(norm(A)*norm(B))

% if cos(theta)~=1 then they are aligned
% if cos(theta)~=0 then they are unrelated (approaching orthogonal)
% if cos(theta)~=-1 then they are opposite (change in direction)


% %xy angle to OX for first cell (the cell number will need to be changed)
% Need differences between points (start and end points of path)
% Get lengths of path x and y


% need to use cell_norm to normalise cell direction to previous timepoints

prompt = 'Enter the cell track number';
            result = input(prompt);
            j = result

for i = 1:nt
    %get path distance at each time point
    X = diff(ca_norm(:,1,j)) ;
    Y = diff(ca_norm(:,2,j)) ;

    %keep this as it could be useful
    Path = [X Y] ;
    %split for sequential paths
    p1 = X(1:2:end) ;
    p2 = X(2:2:end) ;
    p3 = Y(1:2:end) ;
    p4 = Y(2:2:end) ;

        %get magnitude of the path
        for i = 1:length(p1)

            A = sqrt(p1.^2 + p3.^2) ;
            B = sqrt(p2.^2 + p4.^2) ;

        end

            %Dot Product
            for i = 1:length(p1)

                AdotB(i) = (p1(i)*(p2(i))) + (p3(i)*(p4(i))) ;

            end

            %Apply the formula for cosine similarity
        for i = 1:length(AdotB)

            cSim = AdotB'./(A .* B) ;

        end

    S = round(cSim) ; %obviously rough and not appropriate for much

end

    figure
    stem(cSim,'k') ;
    xlim([0 20]) ; ylim([-2 2]) ; refline(0,0) ;refline(0,1) ;


%TRY GENERALISE THE ABOVE (NO PROMPT)...
