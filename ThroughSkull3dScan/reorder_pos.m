function n_pos = reorder_pos(positions)
    pos_diff = diff(positions,1);
    %Find which column is most consistant excluding constant column
    [~,inds] = sort(sum(pos_diff==0));
    axis = inds(end-1);
    transition_points = find(pos_diff(:,axis));
    N = transition_points(1);
    n_pos = positions;
    count = 2;
    for i = N:N:size(positions,1)-N
        if mod(count,2)==0
            n_pos(i+1:i+N,:) = flipud(positions(i+1:i+N,:));
            count = 1;
        else
            count = 2;
        end
    end
end