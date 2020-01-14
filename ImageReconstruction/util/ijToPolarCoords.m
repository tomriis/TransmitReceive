function [polar_coords, order] = ijToPolarCoords(i,j, center)
    polar_coords = zeros(length(i), 2);
    ip=i - center(1); jp = j - center(2);
    for ind = 1:length(i)
        polar_coords(ind,2) = atan2(ip(ind), jp(ind));
        polar_coords(ind,1) = sqrt(ip(ind)^2+jp(ind)^2);    
    end

    [~, order] = sort(polar_coords(:,2));
    polar_coords = polar_coords(order,:);
end