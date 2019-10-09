function data = findDataFromIdx(c_data, XYZ, ijk)
    idx2xyz = [XYZ{1}(ijk(1)), XYZ{2}(ijk(2)), XYZ{3}(ijk(3))];
    f = fieldnames(c_data)';
    f{2,1} = {};
    plane_data = struct(f{:});
    
    count = 1;
    xyz = zeros(length(c_data),3);
    for i = 1:length(c_data)
        xyz(i,:) = c_data(i).v_xyz;
    end
    
    z_unique = sort(unique(xyz(:,3)));
    [~,k] = min(abs(z_unique-idx2xyz(3))); 
    
    for i = 1:length(c_data)
        if c_data(i).v_xyz(3) == z_unique(k)
            plane_data(count) = c_data(i);
            count = count + 1;
        end
    end
    disp(['count is ', num2str(count)])
    min_dist = inf;
    min_idx = 1;
    for i = 1:length(plane_data)
        curr_dist =sum(abs(plane_data(i).v_xyz-idx2xyz));
        if curr_dist < min_dist
            min_dist = curr_dist;
            min_idx = i;
        end
    end
    
    data = plane_data(min_idx);
end
    
