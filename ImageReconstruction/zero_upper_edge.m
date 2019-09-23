function V = zero_upper_edge(V, zLower, rInner)
    center = floor(size(V)/2);
    R = center(1)-rInner;
    m = size(V,1); n = size(V,2);
    mask = ones(m, n);
    for i = 1 : m
        for j = 1 : n
            if ((i-center(1))^2+(j-center(2))^2)^(0.5) > R
                mask(i,j) = 0;
            end
        end
    end
    for i = zLower:size(V,3)
        V(:,:,i) = V(:,:,i).*mask;
    end
end