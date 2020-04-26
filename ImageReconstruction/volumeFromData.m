function [V] = volumeFromData(c_data, N)
    V = zeros(N);
    tx = [2,4];
    for i = 1:length(c_data)
        echo_ijk = c_data(i).echo_ijk;
        for j = 1:length(tx)
            V(echo_ijk(tx(j),1), echo_ijk(tx(j),2), echo_ijk(tx(j),3))=1;
        end
    end
end
    