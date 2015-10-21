dpathdir = uigetdir() ;
dpathmag = uigetdir() ;

mkdir(dpathdir,'Direction')
mkdir(dpathmag,'Magnitude')

file_name1 = 'vdir.csv' ;
file_name2 = 'adir.csv' ;

file_name3 = 'vmag.csv' ;
file_name4 = 'amag.csv' ;

fullfile(dpathdir,'Direction',file_name1) ;
csvwrite(fullfile(dpath,'Direction',file_name1),vdir)

fullfile(dpathdir,'Direction',file_name2) ;
csvwrite(fullfile(dpath,'Direction',file_name2),adir)

fullfile(dpathmag,'Direction',file_name3) ;
csvwrite(fullfile(dpath,'Direction',file_name1),vmag)

fullfile(dpathmag,'Direction',file_name2) ;
csvwrite(fullfile(dpath,'Direction',file_name2),amag)
