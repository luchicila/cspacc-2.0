%Have to call functions in different folders so add all these to the path now.
addpath('graphlib','normlib','statslib','Results','iolib','Analysis')


%user go get the file. This file contains the formatted cell tracks.
prompt = 'Do you want to load freely moving tracks?';
            result = input(prompt);
            if result == 1;
                [ca, n, nt, dt, dpath, file_name]  = load_tracks_single;
            end
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
%          yd(i,cn) = ca(i,1,cn) - ca(i-1,1,cn);
%      end
% end

%function that normalizes to previous timepoint
ca_norm = norm_vprev(ca, n, nt, dt);

%format its currently in is in 10 sec intervals. make it 60 secs (dt,
%origin and new origin have been changed). when we are dealing with colliding
%cells the origin and new origin will have to be modified from 1!
[ca_norm, nt1] = new_temp_res(ca, n, nt, 6, 1, 1);

%computes velocity and acceleration with new time point modification.
ca_norm = norm_vprev(ca_norm, n, nt1, 60);

%compute magnitude (speed) of normalized data (4:6 is where the velocity is)
vmag = compute_mag(ca_norm(:,4:6,:), n, nt1);

%compute magnitude (speed) of normalized data (7:9 is where the acceleration is)
amag = compute_mag(ca_norm(:,7:9,:), n, nt1);

%computes direction of velocity normalized to previous direction
vdir = compute_dir(ca_norm(:,4:6,:), n, nt1);

%computes direction of acceleration normalized to previous direction
adir = compute_dir(ca_norm(:,7:9,:), n, nt1);

%magnitude needs to be checked...

%mean direction of normalized velocities
vmean_dir = pmean_dir(ca_norm(:,4:6,:), n, nt1);

%mean direction of normalized acceleration(s)
amean_dir = pmean_dir(ca_norm(:,7:9,:), n, nt1);

%mean x,y,z components of each timepoint
for i = 1:nt1
    vmeanX(i) = mean(ca_norm(i,4,1));
    vmeanY(i) = mean(ca_norm(i,5,1));
%   vmeanZ(i) = mean(ca_norm(i,6,:));
end

%mean x,y,z components of each timepoint
for i = 1:nt1
    ameanX(i) = mean(ca_norm(i,7,:));
    ameanY(i) = mean(ca_norm(i,8,:));
%   ameanZ(i) = mean(ca_norm(i,9,:));
end

%plot of average velocity vectors normalized to previous timepoints (every 60
%seconds)
figure
hold on
for i = 1:nt1
   quiver(0,0,vmeanX(i),vmeanY(i))
end
hold off

%axis parameters and plot details go here
legend('V tp1','V tp2','V tp3','V tp4','V tp5','V tp6','V tp7')
title('Plot of mean velocity vectors at each timepoint - 1 min intervals')
xlim([-2.5 2.5])
ylim([-2.5 2.5])

figure
hold on
 for i = 1:nt1
   quiver(0,0,ameanX(i),ameanY(i))
 end
hold off

%axis parameters and plot details go here
legend('A tp1','A tp2','A tp3','A tp4','A tp5','A tp6','A tp7')
title('Plot of mean acceleration vectors at each timepoint - 1 min intervals')
xlim([-4.5 4.5])
ylim([-4.5 4.5])


%make folder to store data in a .csv
% user chooses where the directory starts
%need to make a direction folder...
path2results = uigetdir;
%name the file (something memorable/easy to find)
fileName = 'Vel_Direction';
save_direction(vdir, path2results, fileName)
fileName = 'Acc_Direction';
save_direction(adir, path2results, fileName)
fileName = 'Mean_Vel_Direction';
save_direction(vmean_dir, path2results, fileName)
fileName = 'Mean_Acc_Direction';
save_direction(amean_dir, path2results, fileName)
