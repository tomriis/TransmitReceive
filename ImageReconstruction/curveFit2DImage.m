function [polar_coords, plane, points] = curveFit2DImage(plane, center, n, varargin)
% Calculate angle of each point to center
if length(varargin)
    piecewise = varargin{2};
else
    piecewise = false;
end

idx = find(plane);
[i, j] = ind2sub(size(plane), idx);
polar_coords = ijToPolarCoords(i,j,center);

min_theta = polar_coords(1,2);
polar_coords(:,2) = polar_coords(:,2) - min_theta;

if n
    front = zeros(n,2);
    back = zeros(n,2);
    for k = 1:n
        end_ind = length(polar_coords)+1-k;
        front(k,1) = polar_coords(end_ind,1);
        back(k,1) = polar_coords(k,1);
        front(k,2) = polar_coords(1,2) - (2*pi - polar_coords(end_ind,2));
        back(k,2) = polar_coords(end,2) + (2*pi+polar_coords(k,2)-polar_coords(end,2));
    end

    polar_coords = vertcat(flipud(front), polar_coords, back);
end

polar_coords(:,2) = polar_coords(:,2)+min_theta;
if n
    theta = linspace(polar_coords(n,2), polar_coords(end-n,2), 2000);
else
    theta = linspace(polar_coords(1,2), polar_coords(end,2), 2000);
end

% yy = zeros(1,length(theta));
% if piecewise
%     for i = 1:length(polar_coords)-piecewise
%         
p = polyfit(polar_coords(:,2),polar_coords(:,1), 11);
yy = polyval(p,theta);

y = center(1) + yy.*sin(theta);
x = center(2) + yy.*cos(theta);
ii = round(x);
jj = round(y);

limits= size(plane);
% ii(ii<1) = []; jj(ii<1) = [];
% ii(ii>limits(1)) = []; jj(ii>limits(1)) = [];
% jj(jj<1) = []; ii(jj<1) = [];
% jj(jj>limits(2)) = []; ii(jj>limits(2)) = [];


points = unique([ii',jj'],'rows');
points(or(points(:,1) > limits(2), points(:,2) > limits(1)),:) = [];
points(or(points(:,1) < 1, points(:,2) < 1),:) = []; 


for k = 1:length(points)
    plane(points(k,2), points(k,1)) = 1;
end
%figure; imagesc(plane); 

end