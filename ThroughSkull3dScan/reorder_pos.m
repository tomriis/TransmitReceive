function n_pos = reorder_pos(positions)
    curr_dist = norm(diff(positions,1));
    n_pos = positions;
    count = 2;
    for i = 30:30:size(positions,1)-30
        if mod(count,2)==0
            n_pos(i+1:i+30,:) = flipud(positions(i+1:i+30,:));
            count = 1;
        else
            count = 2;
        end
    end
        
end