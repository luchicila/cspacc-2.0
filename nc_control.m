% Script for analysing velocity and acceleration of non-colliding control
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
[ctrl_ca, n, nt, dt, dpath, fname] = load_tracks_single();

% Extract data at 1 minute time intervals
new_res = 6;
dt = dt * new_res;
org = 1;
new_org = 1;
[ctrl_ca1, nt1] = new_temp_res(ctrl_ca, n, nt, new_res, org, new_org);

% Normalise with respect to the previous direction of travel.
ctrl_ca1_norm = norm_vprev(ctrl_ca1, n, nt1, dt);

%% Global descriptors 
% PDF speed
nbins = 50;
[ctrl_pdf_speed, ctrl_x_speed] = pdf_mag(ctrl_ca1_norm(:,4:6,:), n, nt1, nbins);

% PDF direction
[ctrl_pdf_speed_theta, ctrl_x_speed_theta, ~, ~] = ...
    pdf_dir(ctrl_ca1_norm(:,4:6,:), n, nt1, nbins);

% PDF acceleration magnitude
[ctrl_pdf_acc, ctrl_x_acc] = pdf_mag(ctrl_ca1_norm(:,7:9,:), n, nt1, nbins);

% PDF acceleration direction
[ctrl_pdf_acc_theta, ctrl_x_acc_theta, ~, ~] = ...
    pdf_dir(ctrl_ca1_norm(:,7:9,:), n, nt1, nbins);

%% Local descriptors
% Average speed and variance per frame
ctrl_vmag = pmean_mag(ctrl_ca1_norm(:,4:6,:), n, nt1);
ctrl_vmag_var = pvar_mag(ctrl_ca1_norm(:,4:6,:), n, nt1);

% Average direction per frame
ctrl_vdir_stats = pmean_dir(ctrl_ca1_norm(:,4:6,:), n, nt1);

% Average acceleration magnitude per frame
ctrl_amag = pmean_mag(ctrl_ca1_norm(:,7:9,:), n, nt1);
ctrl_amag_var = pvar_mag(ctrl_ca1_norm(:,7:9,:), n, nt1);

% Average acceleration direction per frame
ctrl_adir_stats = pmean_dir(ctrl_ca1_norm(:,7:9,:), n, nt1);

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
plot_prop.axis_size = [-5 5 -5 5 -5 5];
plot_prop.imres = '-r300';
plot_prop.dimensions = 2;

% Initialize path where to save velocity vectors 
path2results = fullfile(dpath, 'analysis-2015-07-02','norm-vprev-60s', ...
    'velocity');
mkdir(path2results);

% Plot velocity vectors
plot_single_vectors(ctrl_ca1_norm(:,4:6,:), n, nt1, plot_prop, path2results);

% Initialize path where to save acceleration vectors
path2results = fullfile(dpath, 'analysis-2015-07-02', 'norm-vprev-60s', ...
    'acceleration');
mkdir(path2results);

% Plot acceleration vectors
plot_single_vectors(ctrl_ca1_norm(:,7:9,:), n, nt1, plot_prop, path2results);

% Initialize plot properties for time series.
plot_prop.col = 'b';
plot_prop.width = 1.2;
plot_prop.axis_size = [0 nt1+1 0 max(ctrl_vmag)+0.5];
plot_prop.imres = '-r300';
path2results = fullfile(dpath, 'analysis-2015-07-02', 'norm-vprev-60s');

% Plot speed time series
file_name = 'mean-speed-ts.png';
plot_ts(ctrl_vmag, 1:nt1, plot_prop, path2results, file_name);

% Plot speed variance
file_name = 'var-speed-ts.png';
plot_ts(ctrl_vmag_var, 1:nt1, plot_prop, path2results, file_name);

% Plot speed distribution 
plot_prop.axis_size = [0 max(ctrl_x_speed) 0 0.7];
file_name = 'speed-pdf.png';
plot_dist(ctrl_pdf_speed, ctrl_x_speed, plot_prop, path2results, file_name);

% Plot mean acceleration time series
file_name = 'mean-acceleration-magnitude-ts.png';
plot_ts(ctrl_amag, 1:nt1, plot_prop, path2results, file_name);

% Plot acceleration magnitude variance
file_name = 'var-acceleration-magnitude-ts.png';
plot_ts(ctrl_amag_var, 1:nt1, plot_prop, path2results, file_name);

% Plot acceleration distribution 
file_name = 'acceleration-magnitude-pdf.png';
plot_dist(ctrl_pdf_speed, ctrl_x_speed, plot_prop, path2results, file_name);

