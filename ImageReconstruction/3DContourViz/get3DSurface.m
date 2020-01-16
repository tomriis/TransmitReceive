function surface = get3DSurface(volume)
    idx = find(volume);
    [x, y, z] = ind2sub(size(volume), idx);

    K = convhull(x,y,z);
    figure;
    trisurf(K,x,y,z,'Facecolor','cyan');
    
    i = round(size(volume,3)/2);
    plane = squeeze(volume(:,:,1));
    idx = find(plane);
    [x, y] = ind2sub(size(plane), idx);
    k = convhull([x,y]);
    figure; imagesc(plane); hold on; plot(y(k),x(k));
end

