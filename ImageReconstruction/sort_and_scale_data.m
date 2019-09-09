function data = sort_and_scale_data(all_data)
    data = struct();
    L = 22.6/2; %mm
    count = 1;
    for i = 1:length(all_data)
        position = all_data(i).position;
        position(3) = linmap(position(3),[2.7,359.1], [2.7 359.1]);
        
        xyz = arm_position_to_xyz(position, L, 1); 
        data(count).v_xyz = xyz;
        data(count).tx = all_data(i).xdr_1(1,:);
        %data(count).rx = all_data(i).tx(2,:);
        count = count + 1;
%         xyz = arm_position_to_xyz(position, L, 2); 
%         data(count).v_xyz = xyz;
%         data(count).tx = all_data(i).rx(2,:);
%         data(count).rx = all_data(i).rx(1,:);
%         count = count + 1;
    end
end