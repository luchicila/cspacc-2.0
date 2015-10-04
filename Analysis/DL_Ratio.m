function [MDLR] = DL_Ratio(ca,n,nt)


for i = 1:n
for k = 1:(nt-1)

            % D = beeline distance
            xd(k,i) = ca( k + 1,1,i ) - ca( 1,1,i ) ;
            yd(k,i) = ca( k + 1,2,i ) - ca( 1,2,i ) ;

            %this gives me the difference between tp
            xl(k,i) = ca( k + 1,1,i ) - ca( k,1,i ) ;
            yl(k,i) = ca( k + 1,2,i ) - ca( k,2,i ) ;
            %gives me the length of the the vectors

            D(k,i) =  sqrt((xd(k,i).^2) + (yd(k,i).^2)) ;

            L(k,i) = sum(sqrt((xl(k,i).^2) + (yl(k,i).^2))) ;

            Path = cumsum(L) ;
end
end

ratio =  D./Path ;

MDLR = mean(ratio') ;

figure()
plot(MDLR)
ylim([0 1])
xlabel('Time')
ylabel('Directionality Ratio')

figure()
errorbar(MDLR, std(ratio'))
xlabel('Time')
ylabel('Directionality Ratio')

end
