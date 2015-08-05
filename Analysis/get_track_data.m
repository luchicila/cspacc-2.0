%user go get the file. This file contains the formatted cell movements.
prompt = 'Do you want to load freely moving tracks?';
            result = input(prompt);
            if result == 1;
                [ca, n, nt, dt, dpath, file_name]  = load_tracks_single;
            end

%Have to call functions in different folders so add all these to the path now.
addpath('graphlib','normlib','statslib')

%first column is time
%second column is position (x,y,'z')
%third column is cell number

%takes the x and y components of one cell track, increment the last digit by one
%to change the cell number
x = ca(:,:,1);

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
[ca_new, nt1] = new_temp_res(ca, n, nt, 6, 1, 1);

%computes velocity and acceleration with new time point modification.
ca_norm = norm_vprev(ca_new, n, nt1, 60);

%compute magnitude (speed) of normalized data (4:6 is where the velocity
%is)
vmag = compute_mag(ca_norm(:,4:6,:), n, nt1);

%compute magnitude (speed) of normalized data (7:9 is where the accelration
%is)
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
    vmeanX(i) = mean(ca_norm(i,4,:));
    vmeanY(i) = mean(ca_norm(i,5,:));
%   vmeanZ(i) = mean(ca_norm(i,6,:));
end

%mean x,y,z components of each timepoint
for i = 1:nt1
    ameanX(i) = mean(ca_norm(i,7,:));
    ameanY(i) = mean(ca_norm(i,8,:));
%   ameanZ(i) = mean(ca_norm(i,9,:));
end

%plot of average velocity vectors normaized to previous timepoints (every 60
%seconds)
figure
for i = 1:nt1
  quiver(0,0,vmeanX(i),vmeanY(i))
end

subplot(2,1,1)
%shit fix until it's debugged properly (does pull V vectors)
quiver(0,0,vmeanX(1),vmeanY(1));hold on;quiver(0,0,vmeanX(2),vmeanY(2));...
quiver(0,0,vmeanX(3),vmeanY(3));quiver(0,0,vmeanX(4),vmeanY(4));...
quiver(0,0,vmeanX(5),vmeanY(5));quiver(0,0,vmeanX(6),vmeanY(6));...
quiver(0,0,vmeanX(7),vmeanY(7));hold off;

%axis parameters and plot details go here
legend('tp1','tp2','tp3','tp4','tp5','tp6','tp7')
title('plot of mean velocity vectors at each timepoint - 1 min intervals')
xlim([-2.5 2.5])
ylim([-2.5 2.5])

figure
for i = 1:length(nt1)
  quiver(0,0,ameanX(i),ameanY(i))
end

subplot(2,1,2)
%shit fix until it's debugged properly (does pull V vectors)
quiver(0,0,ameanX(1),ameanY(1));hold on;quiver(0,0,ameanX(2),ameanY(2));...
quiver(0,0,ameanX(3),ameanY(3));quiver(0,0,ameanX(4),ameanY(4));...
quiver(0,0,ameanX(5),ameanY(5));quiver(0,0,ameanX(6),ameanY(6));...
quiver(0,0,ameanX(7),ameanY(7));hold off;

%axis parameters and plot details go here
legend('tp1','tp2','tp3','tp4','tp5','tp6','tp7')
title('plot of mean acceleration vectors at each timepoint - 1 min intervals')
xlim([-5 5])
ylim([-5 5])

%make folder to store data in a .csv
% user chooses where the directory starts
%need to make a direction folder...
path2results = uigetdir
%name the file (something memorable/easy to find)
fileName = 'Velocity Direction';
save_direction(vdir, path2results, fileName)
fileName = 'Acceleration Direction';
save_direction(adir, path2results, fileName)
fileName = 'Mean Vel Direction';
save_direction(vmean_dir, path2results, fileName)
fileName = 'Mean Acc Direction';
save_direction(amean_dir, path2results, fileName)
