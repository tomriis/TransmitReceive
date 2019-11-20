function data = set_data_xyz_position(data, L)
    count = 1;
    for i = 1:length(data)
        position = data(i).position;
        %position(3) = linmap(position(3),[4.5,324], [0 324]);
        data(count).v_xyz(1,:) = arm_position_to_xyz(position, L, 1); 
        data(count).v_xyz(2,:) = arm_position_to_xyz(position, L, 2);
        count = count + 1;
    end
end