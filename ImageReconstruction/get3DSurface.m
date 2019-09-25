function surface = get3DSurface(volume)
    idx = find(volume);
    [x, y, z] = ind2sub(size(volume), idx);

    K = convhull(x,y,z);
    figure;
    trisurf(K,x,y,z,'Facecolor','cyan');
end

