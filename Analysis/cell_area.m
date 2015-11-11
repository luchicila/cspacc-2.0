function cell_area(Nt, erode_BW1)

area = zeros(length(Nt),1);
number_of_ones = zeros(length(Nt),1);

% Find the area of the cell
number_of_ones= find(erode_BW1 == 1);
area(k) = number_of_ones(end,1) * 0.1^2;
areap = area/max(area);
mean_areap = mean(areap(2:end)-areap(1:end-1));
plot(area/max(area))
set(gca,'YLim',[0, 1])
title('Cell Area Normalised to Max Area')
xlabel('Frame Number')
ylabel('Area in Pixels')

end
