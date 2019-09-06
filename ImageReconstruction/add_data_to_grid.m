function V2 = add_data_to_grid(ijk, data, XYZ, V)
    V2 = zeros(size(V));
    v = data.v_xyz;
    N = length(XYZ{1});
    line = [linspace(v(1),-1*v(1), N)',...
        linspace(v(2),-1*v(2), N)'];
    line_ijk = zeros(N, 3);
    for i = 1:N
        line_ijk(i,:) = coordinates_to_index(XYZ,[line(i,:),v(3)]);
    end
    d =get_binned_data( abs(data.tx), N);
    for i = 1:N
        V2(line_ijk(i,1), line_ijk(i,2), line_ijk(i,3)) = d(i);
    end
end