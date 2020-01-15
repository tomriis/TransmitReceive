function appl = selectNextPeak(appl,c_data_i,tx_i, direction) 
    disp('called selectNextPeak');
    if direction > 0
        M = find((appl.oversight.peak_i - appl.c_data(c_data_i).echo_i(tx_i)>0)); 
        if ~isempty(M)
            appl.c_data(c_data_i).echo_i(tx_i) = appl.oversight.peak_i(M(1));
        end
    else
        M = find((appl.c_data(c_data_i).echo_i(tx_i) - appl.oversight.peak_i >0));
        if ~isempty(M)
            appl.c_data(c_data_i).echo_i(tx_i) = appl.oversight.peak_i(M(end));
        end
    end
end