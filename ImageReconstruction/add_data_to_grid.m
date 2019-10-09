function [V2, d] = add_data_to_grid(ijk, data, XYZ, V, N_data)
    V2 = zeros(size(V));
    v = data.v_xyz;
    N = length(XYZ{1});
    %line through center 
    line = [linspace(v(1),-1*v(1), N)',...
        linspace(v(2),-1*v(2), N)'];
    line_ijk = zeros(N, 3);
    for i = 1 : N
        line_ijk(i,:) = coordinates_to_index(XYZ,[line(i,:),v(3)]);
    end
    
    d = get_binned_data( abs(hilbert(data.tx)), N_data);
    d_std = std(d);
    d(d<1*d_std) = 0;
    d(d>0)= log(d(d>0));
    
    [pks,locs] = findpeaks(d);
    
    if ~isempty(locs)
        i = locs(1);
        V2(line_ijk(i,1), line_ijk(i,2), line_ijk(i,3)) = 1;
    end
    
%     for i = 1 : N
%         V2(line_ijk(i,1), line_ijk(i,2), line_ijk(i,3)) = d(i);
%     end
end