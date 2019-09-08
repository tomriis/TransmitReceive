function c_data = slice_data(data)
    c_data = data;
    x1 = 620;
    x2 = 2500;
    for i = 1:length(data)
        c_data(i).tx = c_data(i).tx(x1:x2);
    end
end