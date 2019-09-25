function c_data = slice_data(data)
    c_data = data;
    x1 = 600;
    x2 = 2550;
    if isstruct(c_data)
        for i = 1:length(data)
            c_data(i).tx = c_data(i).tx(x1:x2);
        end
    else
        c_data = c_data(x1:x2);
    end
end