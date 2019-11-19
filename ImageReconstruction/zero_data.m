function c_data = zero_data(data, x1, x2)
    c_data = data;
    if isstruct(c_data)
        for i = 1:length(data)
            c_data(i).xdr_1(:, 1:x1) = 0;
            c_data(i).xdr_1(:, x2:end) = 0;
            c_data(i).xdr_2(:, 1:x1) = 0;
            c_data(i).xdr_2(:, x2:end) = 0;
        end
    else
        c_data(1:x1) = 0;
        c_data(x2:end) = 0;
    end
end