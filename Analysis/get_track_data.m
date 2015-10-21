function [vdir, adir, vmag, amag] = Get_Track_Data ;

%Have to call functions in different folders so add all these to the path now.
addpath('graphlib','normlib','statslib','iolib','Analysis')



%user go get the file. This file contains the formatted cell tracks.
% prompt = 'Do you want to load freely moving tracks?';
%             result = input(prompt);
%             if result == 1;
[ca, n, nt, dt, dpath, file_name]  = load_tracks_single;
%             end
% saveFolder = uigetdir()

%                                               ______
%                                              /|    /
%first column is time                         /_xyz_/|
%second column is position (x,y,'z')        t | |__| /
%third column is cell number                  |/___|/     c#

%takes the x and y components of one cell track, increment the last digit by one
%to change the cell number
%x = ca(:,:,1);

% %displacement of x and y
% for cn = 1:n
%      for i = 2:nt
%          xd(i,cn) = ca(i,1,cn) - ca(i-1,1,cn);
%          yd(i,cn) = ca(i,2,cn) - ca(i-1,2,cn);
%      end
% end

%function that normalizes to previous timepoint
ca_norm = norm_vprev(ca, n, nt, dt) ;

%format its currently in is in 10 sec intervals. make it 60 secs (dt,
%origin and new origin have been changed). when we are dealing with colliding
%cells the origin and new origin will have to be modified from 1!

% when i use 60 second timepoints reistate nt as nt1

[ca_new, nt1] = new_temp_res(ca, n, nt, 6, 1, 1) ;

%computes velocity and acceleration with new time point modification.
ca_norm = norm_vprev(ca_new, n, nt1, 60) ;

%compute magnitude (speed) of normalized data (4:6 is where the velocity is)
vmag = compute_mag(ca_norm(:,4:6,:), n, nt1) ;

%compute magnitude (speed) of normalized data (7:9 is where the acceleration is)
amag = compute_mag(ca_norm(:,7:9,:), n, nt1) ;

%computes direction of velocity normalized to previous direction
vdir = compute_dir(ca_norm(:,4:6,:), n, nt1) ;

%computes direction of acceleration normalized to previous direction
adir = compute_dir(ca_norm(:,7:9,:), n, nt1) ;

%magnitude needs to be checked.

%mean direction of normalized velocities
vmean_dir = pmean_dir(ca_norm(:,4:6,:), n, nt1) ;

%mean direction of normalized acceleration(s)
amean_dir = pmean_dir(ca_norm(:,7:9,:), n, nt1) ;

% when i use 60 second timepoints reinstate nt as nt1
%mean x,y,z components of each timepoint
for i = 1:nt1
    vmeanX(i) = mean(ca_norm(i,4,1) ) ;
    vmeanY(i) = mean(ca_norm(i,5,1) ) ;
    %   vmeanZ(i) = mean(ca_norm(i,6,:) ) ;
end

%mean x,y,z components of each timepoint
for i = 1:nt1
    ameanX(i) = mean(ca_norm(i,7,:) ) ;
    ameanY(i) = mean(ca_norm(i,8,:) ) ;
    %   ameanZ(i) = mean(ca_norm(i,9,:) ) ;
end

% Simply plots all cell tracks from a point of common origin
Origin_Plot(ca,n) ;

% Provides the Overlapping Mean Squared Displacement of the cell tracks
% and plots log-log, linear and errorbar graphs. User bias comes into play when
% looking at the slope so lowest 10% is recommended.
% Slope of 1 is random and a slope of 2 is perfectly directionally persistant
MSD_Overlapping(ca,n,nt) ;

% Directionality Ratio of the cell tracks. Plots the DR ensemble average with
% and without errorbars
DL_Ratio(ca,n,nt) ;

% Directionality Ratio of the cell tracks. Plots stem graph of DR for each track
% and a reference line for the mean D/L index
DL_Ratio2(ca,n)

% Provides the non-overlapping Mean Squared Displacement of the cell tracks,
% our tracks aren't long enough so this won't be used (it can stay here...)
MSD_NonOverlapping(ca,n,nt) ;

% Cosine similarity is terrible atm but I'll go back to it and get it right...

%plot of average velocity vectors normalized to previous timepoints (every 60
%seconds)



figure()
hold on
for i = 1:nt1
    quiver(0,0,vmeanX(i),vmeanY(i))
end
hold off

%axis parameters and plot details go here
str = cellstr(num2str((1:nt1)','Velocity @ t = %d')) ;
legend(str,'Best')
title('Plot of mean velocity vectors at each timepoint - 1 min intervals')
xlim([-2.5 5])
ylim([-5 5])

figure()
hold on
for i = 1:nt1
    quiver(0,0,ameanX(i),ameanY(i))
end
hold off

%axis parameters and plot details go here
str = cellstr(num2str((1:nt1)','Acceleration @ t = %d')) ;
legend(str,'Best')
title('Plot of mean acceleration vectors at each timepoint - 1 min intervals')
xlim([-2.5 5])
ylim([-5 5])

end
