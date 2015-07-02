function pop_stat = pstat_single(vec, n, nt)
pstat.vmean_mag = pmean_mag(vec, n, nt);
pstat.vstd_mag = pstd_mag(vec, n, nt);

pstat.vmean_dir = pmean_dir(vec, nt);
pstat.vdisp_dir = pdisp_dir(vec, nt);
end




% Find empirical distribbution of magnitude

% Find empirical distribution of direction