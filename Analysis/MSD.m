
%1) get normalised V and A with respect to previous direction of travel.
vdir

adir


%2)
%i) Plot histogram with cell speed and fit a PDF to the data.
%ii) How is speed distributed?
%iii) How does the distribution vary with changes in time point intervals.
%3)Repeat 2) for cell direction, mag of A, and dir of A.
%4)
%i) write a function that produces MSD of the cell



% displacement of x and y
% cn (cell number) is initialised
% %displacement of x and y

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NON OVERLAPPING - PROBABLY USELESS
tau = 1;

for tau = 1:nt-1

    m = 1;

    clear sd

    for cn = 1:n

          for k = 2:tau:nt

            xd = ca(k,1,cn) - ca(k-1,1,cn);
            yd = ca(k,1,cn) - ca(k-1,1,cn);
            sd(m) = xd^2 + yd^2;
            m = m + 1;


          end

    end

    msd(tau) = mean(sd);

end
plot(msd,'-or')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OVERLAPPING - PROBABLY LESS USELESS

%initialise time step
tau = 0;
%this time step applies to the max length of track
for tau = 1:nt-1
%initialise time step increment
    p = 1;
%we don't need to store the sd values anywhere.
    clear sd
%cn is the cell number
    for cn = 1:n
%take index k and pass it over the track length in steps = tau + p
          for k = 2:tau + p:nt
%displacement in X and Y
            xd = ca(k,1,cn) - ca(k-1,1,cn);
            yd = ca(k,1,cn) - ca(k-1,1,cn);
%this establishes the squared dsplacements (A^2 + B^2 = C^2) =>(sd(p))
            sd(p) = xd^2 + yd^2;
%increment the time step to increase level of sampling
            p = p + 1;
          end
    end
%this is what we want
    msd(tau) = mean(sd);
end
plot(msd,'--ok')

% plot(msd,'or')
% hold on
plot(msd2,'ob')

if something = 1 then just multiply that by the gap

% need to increment 'm' somehow. It's already ascending by 1 each iteration

% %1) get normalised V and A with respect to previous direction of travel.
% vdir
%
% adir

% %2)
% %i) Plot histogram with cell speed and fit a PDF to the data.
% %ii) How is speed distributed?
% %iii) How does the distribution vary with changes in time point intervals.
% %3)Repeat 2) for cell direction, mag of A, and dir of A.
% %4)
% %i) write a function that produces MSD of the cell

% %ii) What parameters are important for quantifying the MSD of a sample of
% %trajectories
%
