function n_pos = reorder_pos(positions)
    curr_dist = norm(diff(positions,1));
    n_pos = positions;
    count = 2;
    for i = 95:95:size(positions,1)-95
        if mod(count,2)==0
            n_pos(i+1:i+95,:) = flipud(positions(i+1:i+95,:));
            count = 1;
        else
            count = 2;
        end
    end
        
end