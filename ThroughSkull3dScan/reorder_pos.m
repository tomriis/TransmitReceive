function n_pos = reorder_pos(positions, varargin)
    pos_diff = diff(positions,1);
    %Find which column is most consistant excluding constant column
    [~,inds] = sort(sum(pos_diff==0));
    if isempty(varargin)
        axis = inds(end-1);
    else
        axis = varargin{1};
    end
    disp(num2str(axis))
    transition_points = find(pos_diff(:,axis));
    n_pos = positions;
    if ~isempty(transition_points)
        N = transition_points(1);
    else
        return
    end
    
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