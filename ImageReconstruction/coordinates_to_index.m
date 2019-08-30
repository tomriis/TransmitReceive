function [ijk] = coordinates_to_index(XYZ, v)
    n = length(v);
    ijk = zeros(1,n);
    for j = 1:n
        [~,i]=min(abs(XYZ{j}-v(j)));
        ijk(j) = i;
    end
end