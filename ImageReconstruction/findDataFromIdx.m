function [data, min_idx, tx_i] = findDataFromIdx(c_data, ijk)
    min_dist = inf;
    min_idx = 1;
    for i = 1:length(c_data)       
        curr_dist =min(sum(abs(c_data(i).echo_ijk-ijk),2));
        if curr_dist < min_dist
            min_dist = curr_dist;
            min_idx = i;
        end
    end
    
    data = c_data(min_idx);
    
    [~, tx_i] =  min(sum(abs(c_data(min_idx).echo_ijk-ijk),2));
    % TODO remove this hard coding to select certain echo
    if tx_i == 1
        tx_i = 2;
    elseif tx_i == 3
        tx_i = 4;
    end
end
    
