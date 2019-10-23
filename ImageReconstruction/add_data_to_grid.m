function [V2, max_corr_i, d_ijk] = add_data_to_grid(ijk, data, XYZ, V, N_data,L, xcorr_signal)
    V2 = zeros(size(V));
    v = data.v_xyz;
    N = length(XYZ{1});
    tx_i = 2;
    y_end = v(2)-L*sin(deg2rad(data.position(3)));
    %vector to opposite transducer
    line = [linspace(v(1), -1*v(1), N)',...
            linspace(v(2), y_end, N)'];
    line_ijk = zeros(N, 3);
    for i = 1 : N
        line_ijk(i,:) = coordinates_to_index(XYZ,[line(i,:),v(3)]);
    end
    
%     d = get_binned_data( abs( hilbert( data.xdr_1(tx_i,:) ) ), N_data);
%     d_std = std(d);
%     d(d<1*d_std) = 0;
%     d(d>0)= log(d(d>0));
%     
%     [pks, locs] = findpeaks(d);
%     
%     if ~isempty(locs)
%         i = locs(1);
%         V2(line_ijk(i,1), line_ijk(i,2), line_ijk(i,3)) = 1;
%     end
    
    [ max_corr_i ] = findMaxCorrelation(data.xdr_1(tx_i,:), xcorr_signal(tx_i,:));
    i = round(max_corr_i/length(data.xdr_1(tx_i,:)) * N_data);
    V2(line_ijk(i,1), line_ijk(i,2), line_ijk(i,3)) = 1;
    d_ijk = [line_ijk(i,1), line_ijk(i,2), line_ijk(i,3)];
end