function V = zero_volume_center(V,R)

center = floor(size(V)/2);
center_vol=cell(1,3);
for i = 1:2
center_vol{i} = center(i)-R:center(i)+R;
end
center_vol{3} = 1:size(V,3);
[X,Y,Z]= ndgrid(center_vol{1}, center_vol{2},center_vol{3});

threshold = 1;
mean_intensity = mean(V(V>threshold),'all');

for i = 1:length(X(:))
    if V(X(i),Y(i),Z(i)) > threshold
        V(X(i), Y(i),Z(i)) = mean_intensity;
    end
end

end

