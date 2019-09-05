function p = get_unique_positions(data)
    N = length(data);
    positions = zeros(N,3);
    for i = 1:N
        positions(i,:) = data(i).v_xyz;
    end
    p = {};
    for i = 1:3
        p{i} = sort(unique(positions(:,i)));
    end
end