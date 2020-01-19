function [i, j] = getPlaneCoordinates(data, i)
    plane = squeeze(data(:,:,i));
    idx = find(plane>1);
    [i, j] = ind2sub(size(plane), idx);       
end