function p = get_unique_positions(data)
    N = length(data)*size(data(1).v_xyz,1);
    positions = zeros(N,3);
    count = 1;
    for i = 1:length(data)
        for k = 1:size(data(1).v_xyz,1)
            positions(count,:) = data(i).v_xyz(k,:);
            count = count +1;
        end
    end

    
    p = {};
    for i = 1:3
        p{i} = sort(unique(positions(:,i)));
    end
end