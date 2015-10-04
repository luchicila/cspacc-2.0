corrV = autocorr(vdir(:,1,8)) ;
corrA = autocorr(adir(:,1,8)) ;

subplot(2,1,1)
stem(corrV,'b')
hold on
plot(corrV,':r')
title('VAF of Cell 8')
ylim([ -1 2]) ;
ylim([ -1 1.5]) ;
ylabel('correlation coefficient \theta')
xlabel('\tau')

subplot(2,1,2)
stem(corrA,'r')
hold on
plot(corrA,':b')
title('AAF of Cell 8')
ylim([ -1 2]) ;
ylim([ -1 1.5]) ;
ylabel('correlation coefficient \theta')
xlabel('\tau')

% test1 has given me vdir(:,1,:) in matrix form via squeeze function
vdirmat = squeeze(vdir(:,1,:)) ;
vdirvec = vdirmat ;
cellpop = vdirvec(:) ;
corrp = autocorr(cellpop) ;
%this is wrong as it just lists cell numbers in sequence

stem(corrp)
hold on
plot(corr,':r')

title('VAF of Cell Population')
ylim([ -1 2]) ;
ylim([ -1 1.5]) ;
ylabel('correlation coefficient \theta')
xlabel('\tau')
