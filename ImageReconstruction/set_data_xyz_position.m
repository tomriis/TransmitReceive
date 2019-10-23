function data = set_data_xyz_position(data, L)
    count = 1;
    for i = 1:length(data)
        position = data(i).position;
        %position(3) = linmap(position(3),[4.5,324], [0 324]);
        xyz = arm_position_to_xyz(position, L, 1); 
        data(count).v_xyz = xyz;
        count = count + 1;
    end
end