% Script for analysing velocity and acceleration of colliding control
% hemocytes. Note that as there is no other reference, the normalisation used is
% with respect to the previous direction of travel.
%
% Author A. Luchici, 2015

%% Initialization and preprocessing
% Add cspacc subdirectories to Matlab path.
addpath(fullfile(pwd, 'iolib'));
addpath(fullfile(pwd, 'graphlib'));
addpath(fullfile(pwd, 'normlib'));
addpath(fullfile(pwd, 'statslib'));

% Load data
[ca, cb, n, nt, dt, col_pt, dpath, ~] = load_tracks_colliding();
dpath = dpath(1:end-12);

% Extract data at 1 minute time intervals
new_res = 6;
dt = dt * new_res;
org = col_pt;
new_org = length(-240:60:0);
[ctrl_ca1, nt1] = new_temp_res(ctrl_ca, n, nt, new_res, org, new_org);
[ctrl_cb1, ~] = new_temp_res(ctrl_cb, n, nt, new_res, org, new_org);

% Normalise with respect to the previous direction of travel.
ctrl_ca1_norm = norm_vprev(ctrl_ca1, n, nt1, dt);
ctrl_cb1_norm = norm_vprev(ctrl_cb1, n, nt1, dt);

%% Global descriptors 
% PDF speed
nbins = 50;
[ctrl_ca1_pdf_speed, ctrl_ca1_x_speed] = pdf_mag(ctrl_ca1_norm(:,4:6,:), n, ...
    nt1, nbins);
[ctrl_cb1_pdf_speed, ctrl_cb1_x_speed] = pdf_mag(ctrl_cb1_norm(:,4:6,:), n, ...
    nt1, nbins);

% PDF direction
[ctrl_ca1_pdf_speed_theta, ctrl_ca1_x_speed_theta, ~, ~] = ...
    pdf_dir(ctrl_ca1_norm(:,4:6,:), n, nt1, nbins);
[ctrl_cb1_pdf_speed_theta, ctrl_cb1_x_speed_theta, ~, ~] = ...
    pdf_dir(ctrl_cb1_norm(:,4:6,:), n, nt1, nbins);

% PDF acceleration magnitude
[ctrl_ca1_pdf_acc, ctrl_ca1_x_acc] = pdf_mag(ctrl_ca1_norm(:,7:9,:), n, nt1, ...
    nbins);
[ctrl_cb1_pdf_acc, ctrl_cb1_x_acc] = pdf_mag(ctrl_cb1_norm(:,7:9,:), n, nt1, ...
    nbins);

% PDF acceleration direction
[ctrl_ca1_pdf_acc_theta, ctrl_ca1_x_acc_theta, ~, ~] = ...
    pdf_dir(ctrl_ca1_norm(:,7:9,:), n, nt1, nbins);
[ctrl_cb1_pdf_acc_theta, ctrl_cb1_x_acc_theta, ~, ~] = ...
    pdf_dir(ctrl_cb1_norm(:,7:9,:), n, nt1, nbins);

%% Local descriptors
% Average speed and variance per frame
ctrl_ca1_vmag = pmean_mag(ctrl_ca1_norm(:,4:6,:), n, nt1);
ctrl_ca1_vmag_var = pvar_mag(ctrl_ca1_norm(:,4:6,:), n, nt1);

% Average direction per frame
ctrl_ca1_vdir_stats = pmean_dir(ctrl_ca1_norm(:,4:6,:), n, nt1);

% Average acceleration magnitude per frame
ctrl_ca1_amag = pmean_mag(ctrl_ca1_norm(:,7:9,:), n, nt1);
ctrl_ca1_amag_var = pvar_mag(ctrl_ca1_norm(:,7:9,:), n, nt1);

% Average acceleration direction per frame
ctrl_ca1_adir_stats = pmean_dir(ctrl_ca1_norm(:,7:9,:), n, nt1);

%% Statistical tests
% Test if velocity components are random or not with 1% confidence. 
mu_x = 0; 
mu_y = 0;
mu_z = 0;
alpha = 0.01;

% Test velocity vectors.
ctrl_pval_vel = ttest_components(ctrl_ca1_norm(:,4:6,:), nt1, ...
    mu_x, mu_y, mu_z, alpha);

% Test acceleration vectors.
ctrl_pval_acc = ttest_components(ctrl_ca1_norm(:,7:9,:), nt1, ...
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
plot_single_vectors(ctrl_ca1_norm(:,4:6,:), n, nt1, plot_prop, path2results);

% Initialize path where to save acceleration vectors
path2results = fullfile(dpath, 'analysis-2015-07-03', 'norm-vprev-60s', ...
    'acceleration');
mkdir(path2results);

% Plot acceleration vectors
plot_single_vectors(ctrl_ca1_norm(:,7:9,:), n, nt1, plot_prop, path2results);

%% Save data
% Velocity
path2results = fullfile(dpath, 'analysis-2015-07-03', 'norm-vprev-60s');
file_name = 'velocity.csv';
save_data(ctrl_ca1_norm(:,4:6,:), path2results, file_name);

% Velocity stats
M = [ctrl_vmag, ctrl_vmag_var, ctrl_vdir_stats];
file_name = 'velocity-stats.csv';
save_data(M, path2results, file_name);

% Velocity PDFs
clear M
M = [ctrl_x_speed', ctrl_pdf_speed', ctrl_x_speed_theta', ctrl_pdf_speed_theta'];
file_name = 'velocity-pdfs.csv';
save_data(M, path2results, file_name);

% Acceleration
file_name = 'acceleration.csv';
save_data(ctrl_ca1_norm(:,7:9,:), path2results, file_name);

% Acceleration stats
clear M
M = [ctrl_amag, ctrl_amag_var, ctrl_adir_stats];
file_name = 'acceleration-stats.csv';
save_data(M, path2results, file_name);

% Acceleration PDFs
clear M 
M = [ctrl_x_acc', ctrl_pdf_acc', ctrl_x_acc_theta', ctrl_pdf_acc_theta'];
file_name = 'acceleration-pdfs.csv';
save_data(M, path2results, file_name);
