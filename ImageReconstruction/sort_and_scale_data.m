function data = sort_and_scale_data(all_data)
    data = struct();
    L = 22.6; %mm
    count = 1;
    for i = 1:length(all_data)
        position = all_data(i).position;
        position(3) = linmap(position(3),[1.8,248.4], [0 177]);
        for j = 1:2
            xyz = arm_position_to_xyz(position, L, j); 
            data(count).v_xyz = xyz;
            data(count).tx = all_data(i).tx(j,:);
            data(count).rx = all_data(i).rx(j,:);
            count = count + 1;
        end
    end
end