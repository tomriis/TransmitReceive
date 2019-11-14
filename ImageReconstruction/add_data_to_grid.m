function [V, max_corr_i, echo_ijk, line_ijk] = add_data_to_grid(ijk, data, XYZ, V, N_data,L, xcorr_signal,tx_i)
    
    v = data.v_xyz;
    N = length(XYZ{1});
    x_end = -v(1);
    y_end = v(2)-L*sin(deg2rad(data.position(3)));
    z_end = v(3);
    %vector to opposite transducer
    line = [linspace(v(1), x_end, N)',...
            linspace(v(2), y_end, N)'];
    line_ijk = zeros(N, 3);
    for i = 1 : N
        line_ijk(i,:) = coordinates_to_index(XYZ,[line(i,:),v(3)]);
    end
    
    
    [ max_corr_i ] = findMaxCorrelation(data.xdr_1(tx_i,:), xcorr_signal(tx_i,:));
    scalar = max_corr_i/length(data.xdr_1(tx_i,:));
    echo_xy = v(1:2) + scalar* [x_end-v(1), y_end-v(2)]*N_data/size(V,1);
    echo_ijk = coordinates_to_index(XYZ,[echo_xy, v(3)]);
    
    V(echo_ijk(1), echo_ijk(2), echo_ijk(3)) = data.di(1);
    
end