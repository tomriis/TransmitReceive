function interpolate3DSurface(volume)
    xyz = [];
    for k = 1:size(volume,3)
        if sum(volume(:,:,k),'all')>0
            [i, j] = getPlaneCoordinates(volume, k);
            xyz = vertcat(xyz,[i,j,repmat(k,size(i))]);
        end
    end
    x = xyz(:,1); y = xyz(:,2); z = xyz(:,3);
    xq = 1:size(volume,1); yq = 1:size(volume,2);zq = 1:size(volume,3);
    
    % Cut data in half to eliminate non unique values and interpolate
    pairs = {[1,2], 1, 1};
    % XY plane
    for k = 1:size(volume,3)
        if sum(volume(:,:,k),'all')>0
            [i, j] = getPlaneCoordinates(volume, k);
            for flipped_flag = 1:2
                if length(i)>20       
                    try
                        [x1, y1, x2, y2] = interpolateIJ(i,j,flipped_flag);

                        for p = 1:length(x1)
                            volume(x1(p), y1(p), k) = 1;
                        end
                        for p = 1:length(x2)
                            volume(x2(p), y2(p), k) = 1;
                        end
                    catch e
                        disp(e.message)
                    end
                end
            end
        end
    end
    % YZ Plane
    for k = 1:size(volume,2)   
        if sum(volume(:,k,:),'all')>0
            plane = squeeze(volume(:,k,:));
            idx = find(plane);
            [i, j] = ind2sub(size(plane), idx);
            for flipped_flag = 1 
                if length(i)>20
                    [x1, y1, x2, y2] = interpolateIJ(i,j,flipped_flag);
                    for p = 1:length(x1)
                            volume(x1(p),k, y1(p)) = 1;
                    end
                    for p = 1:length(x2)
                            volume(x2(p), k, y2(p)) = 1;
                    end
                end
            end
        end
    end
end


            