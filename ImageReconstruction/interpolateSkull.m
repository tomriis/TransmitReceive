demo = data;
demo = zeros(128, 128, (size(data,3)-1)*3+1);
for i = 1:size(data,3)
    ind = (i-1)*3+1;
    [plane, points] = curveFit2DImage(squeeze(data(:,:,i)), center, 2);
    for j = 1 : length(points)
        demo(points(j,1), points(j,2), ind) = 1;
    end
end
demo2 = zeros(176, 177, (size(data,3)-1)*3+1);

for i = 1:size(demo,3)
    demo2(:,:,i) = imrotate(demo(:,:,i),30);
end
idx = find(demo2);
[x, y, z] = ind2sub(size(demo2), idx);
min_i = min(x); max_i =max(x);
min_j = min(y); max_j = max(y);
demo2(max_i+1:end,:,:) = [];
demo2(:,max_j+1:end,:) = [];
demo2(1:min_i-1,:,:) = [];
demo2(:,1:min_j-1,:) = [];

pad = 30;
for i=(min_j+pad):(max_j-pad)
    [plane, points] = curveFit2DImage(squeeze(demo2(:,i,:)), center2, 0, 'Piecewise',5);
%     for i = length(points)
    for j = 1:length(points)
        demo2(points(j,1),i,points(j,2)) = 1;
    end
end
    