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
    
    disp(['min_idx is ', num2str(min_idx)])
    [~, tx_i] =  min(sum(abs(c_data(min_idx).echo_ijk-ijk),2));
end
    
