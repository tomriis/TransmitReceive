demo = zeros(size(mask_data));

center = round(size(squeeze(mask_data(:,:,1)))/2);
for i = 1:size(demo,3)
    plane = squeeze(mask_data(:,:,i));
    if sum(plane,'all')
        [~, ~, points] = curveFit2DImage(plane, center, 2);
        for j = 1 : length(points)
            demo(points(j,1), points(j,2), i) = 1;
        end
    end
end
rotationAngle = 36;
s = size(imrotate(demo(:,:,35), rotationAngle));
demo2 = zeros(s(1), s(2), size(demo,3));

for i = 1:size(demo,3)
    demo2(:,:,i) = imrotate(demo(:,:,i), rotationAngle);
end
idx = find(demo2);
pad = 5;
[x, y, z] = ind2sub(size(demo2), idx);
min_i = min(x); max_i =max(x);
min_j = min(y); max_j = max(y);
demo2(max_i+pad:end,:,:) = [];
demo2(:,max_j+pad:end,:) = [];
demo2(1:min_i-pad,:,:) = [];
demo2(:,1:min_j-pad,:) = [];

% Interpolate in XY dimension
for i=(min_j+pad):(max_j-pad)
    [plane, points] = curveFit2DImage(squeeze(demo2(:,i,:)), center2, 0, 'Piecewise',5);
%     for i = length(points)
    for j = 1:length(points)
        demo2(points(j,1),i,points(j,2)) = 1;
    end
end
    