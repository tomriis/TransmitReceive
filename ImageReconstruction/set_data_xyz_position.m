function data = set_data_xyz_position(all_data, L)
    data = struct();
    
    count = 1;
    for i = 1:length(all_data)
        position = all_data(i).position;
        %position(3) = linmap(position(3),[4.5,324], [0 324]);
        
        xyz = arm_position_to_xyz(position, L, 1); 
        data(count).v_xyz = xyz;
        data(count).tx = all_data(i).xdr_1(1,:);
        data(count).rx = all_data(i).xdr_2(1,:);
        count = count + 1;
    end
end