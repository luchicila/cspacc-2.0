dpathFrames = uigetdir() ;
dpathmag = uigetdir() ;

mkdir(dpathFrames,'Direction')
mkdir(dpathmag,'Magnitude')

file_name1 = 'vdir.csv' ;
file_name2 = 'adir.csv' ;

file_name3 = 'vmag.csv' ;
file_name4 = 'amag.csv' ;

fullfile(dpathFrames,'Direction',file_name1) ;
imwrite(fullfile(dpath,'Direction',file_name1),vdir)

fullfile(dpathFrames,'Direction',file_name2) ;
csvwrite(fullfile(dpath,'Direction',file_name2),adir)

fullfile(dpathmag,'Direction',file_name3) ;
csvwrite(fullfile(dpath,'Direction',file_name1),vmag)

fullfile(dpathmag,'Direction',file_name2) ;
csvwrite(fullfile(dpath,'Direction',file_name2),amag)
