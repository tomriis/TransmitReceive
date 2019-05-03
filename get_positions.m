function positions = get_positions(locs1, locs2)  
    positions = zeros([length(locs1(:)),2]);
    for i = 1:length(locs1(:))
        positions(i,:) = [locs1(i), locs2(i)];
    end
end