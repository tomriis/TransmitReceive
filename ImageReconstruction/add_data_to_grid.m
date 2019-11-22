function [echo_i, echo_ijk] = add_data_to_grid(data,xcorr_signal, XYZ, L, data_length_mm)
    TxEvents = data.TxEvents;
    v = data.v_xyz;
    echo_ijk = zeros(TxEvents,3);
    echo_i = zeros(TxEvents,1);
    for i = 1:TxEvents
        if i <= TxEvents/2
            tx_data = data.xdr_1(i,:);
            v0 = v(1,:);
            vEnd = v(2,:);
        else
            tx_data = data.xdr_2(i,:);
            v0 = v(2,:);
            vEnd = v(1,:);
        end       
    echo_i(i) = findMaxCorrelation(tx_data, xcorr_signal(i,:));
    scalar = echo_i(i)/length(tx_data);
    echo_xyz = v0 + scalar*((vEnd-v0)/L)*data_length_mm;
    echo_ijk(i,:) = coordinates_to_index(XYZ,echo_xyz);
    
    end
end