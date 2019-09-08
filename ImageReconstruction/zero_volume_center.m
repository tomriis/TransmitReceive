function V = zero_volume_center(V,R)

center = floor(size(V)/2);
center_vol=cell(1,3);
for i = 1:2
center_vol{i} = center(i)-R:center(i)+R;
end
center_vol{3} = 1:size(V,3);
[X,Y,Z]= ndgrid(center_vol{1}, center_vol{2},center_vol{3});

for i = 1:length(X(:))
    V(X(i), Y(i),Z(i)) = 0;
end

end