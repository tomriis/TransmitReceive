function positions = get_positions(locs1, locs2, locs3)  
    positions = zeros([length(locs1(:)),3]);
    for i = 1:length(locs1(:))
        positions(i,:) = [locs1(i), locs2(i),locs3(i)];
    end
    %positions = reorder_pos(positions);
end