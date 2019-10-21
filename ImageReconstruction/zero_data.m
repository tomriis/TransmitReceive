function c_data = zero_data(data, x1, x2)
    c_data = data;
    if isstruct(c_data)
        for i = 1:length(data)
            c_data(i).tx(1:x1) = mean(c_data(i).tx);
            c_data(i).tx(x2:end) = mean(c_data(i).tx);
        end
    else
        c_data(1:x1) = 0;
        c_data(x2:end) = 0;
    end
end