function n_pos = reorder_pos(positions)
    curr_dist = norm(diff(positions,1));
    n_pos = positions;
    count = 2;
    N = 70;
    for i = N:N:size(positions,1)-N
        if mod(count,2)==0
            n_pos(i+1:i+N,:) = flipud(positions(i+1:i+N,:));
            count = 1;
        else
            count = 2;
        end
    end
        
end