% Script for analysing velocity and acceleration of non-colliding dia5
% mutant hemocytes. Note that as there is no other reference, the
% normalisation used is with respect to the previous direction of travel.
%
% Author A. Luchici, 2015

%% Initialization and preprocessing
% Add cspacc subdirectories to Matlab path.
addpath(fullfile(pwd, 'iolib'));
addpath(fullfile(pwd, 'graphlib'));
addpath(fullfile(pwd, 'normlib'));
addpath(fullfile(pwd, 'statslib'));

% Load data
[dia5_ca, n, nt, dt, dpath, fname] = load_tracks_single();
dpath = dpath(1:end-12);

% Extract data at 1 minute time intervals
new_res = 6;
dt = new_res * dt;
org = 1;
new_org = 1;
[dia5_ca1, nt1] = new_temp_res(dia5_ca, n, nt, new_res, org, new_org);


% Normalise with respect to the previous direction of travel.
dia5_ca1_norm = norm_vprev(dia5_ca1, n, nt1, dt);

%% Global descriptors 
nbins = 50;
% PDF speed
[dia5_pdf_speed, dia5_x_speed] = pdf_mag(dia5_ca1_norm(:,4:6,:), n, nt1, nbins);

% PDF direction
[dia5_pdf_speed_theta, dia5_x_speed_theta, ~, ~] = ...
    pdf_dir(dia5_ca1_norm(:,4:6,:), n, nt1, nbins);

% PDF acceleration magnitude
[dia5_pdf_acc, dia5_x_acc] = pdf_mag(dia5_ca1_norm(:,7:9,:), n, nt1, nbins);

% PDF acceleration direction
[dia5_pdf_acc_theta, dia5_x_acc_theta, ~, ~] = ...
    pdf_dir(dia5_ca1_norm(:,7:9,:), n, nt1, nbins);

%% Local descriptors
% Average speed and variance per frame
dia5_vmag = pmean_mag(dia5_ca1_norm(:,4:6,:), n, nt1);
dia5_vmag_var = pvar_mag(dia5_ca1_norm(:,4:6,:), n, nt1);

% Average direction per frame
dia5_vdir_stats = pmean_dir(dia5_ca1_norm(:,4:6,:), n, nt1);

% Average acceleration magnitude per frame
dia5_amag = pmean_mag(dia5_ca1_norm(:,7:9,:), n, nt1);
dia5_amag_var = pvar_mag(dia5_ca1_norm(:,7:9,:), n, nt1);

% Average acceleration direction per frame
dia5_adir_stats = pmean_dir(dia5_ca1_norm(:,7:9,:), n, nt1);

%% Statistical tests
% Test if velocity components are random or not with 0.1% confidence. 
mu_x = 0; 
mu_y = 0;
mu_z = 0;
alpha = 0.001;

% Test velocity vectors.
dia5_pval_vel = ttest_components(dia5_ca1_norm(:,4:6,:), nt1, ...
    mu_x, mu_y, mu_z, alpha);

% Test acceleration vectors.
dia5_pval_acc = ttest_components(dia5_ca1_norm(:,7:9,:), nt1, ...
    mu_x, mu_y, mu_z, alpha);

%% Visualisation 
% Initialize plot properties 
plot_prop.axis_size = [-8 8 -8 8 -8 8];
plot_prop.imres = '-r300';
plot_prop.dimensions = 2;

% Initialize path where to save velocity vectors 
path2results = fullfile(dpath, 'analysis-2015-07-03','norm-vprev-60s', ...
    'velocity');
mkdir(path2results);

% Plot velocity vectors
plot_single_vectors(dia5_ca1_norm(:,4:6,:), n, nt1, plot_prop, path2results);

% Initialize path where to save acceleration vectors
path2results = fullfile(dpath, 'analysis-2015-07-03', 'norm-vprev-60s', ...
    'acceleration');
mkdir(path2results);

% Plot acceleration vectors
plot_single_vectors(dia5_ca1_norm(:,7:9,:), n, nt1, plot_prop, path2results);

%% Save data
% Velocity
path2results = fullfile(dpath, 'analysis-2015-07-03', 'norm-vprev-60s');
file_name = 'velocity.csv';
save_data(dia5_ca1_norm(:,4:6,:), path2results, file_name);

% Velocity stats
M = [dia5_vmag, dia5_vmag_var, dia5_vdir_stats];
file_name = 'velocity-stats.csv';
save_data(M, path2results, file_name);

% Velocity PDFs
clear M
M = [dia5_x_speed', dia5_pdf_speed', dia5_x_speed_theta', dia5_pdf_speed_theta'];
file_name = 'velocity-pdfs.csv';
save_data(M, path2results, file_name);

% Acceleration
file_name = 'acceleration.csv';
save_data(dia5_ca1_norm(:,7:9,:), path2results, file_name);

% Acceleration stats
clear M
M = [dia5_amag, dia5_amag_var, dia5_adir_stats];
file_name = 'acceleration-stats.csv';
save_data(M, path2results, file_name);

% Acceleration PDFs
clear M 
M = [dia5_x_acc', dia5_pdf_acc', dia5_x_acc_theta', dia5_pdf_acc_theta'];
file_name = 'acceleration-pdfs.csv';
save_data(M, path2results, file_name);
