function [app] = curveFit2DRegion(app)
    app.positions = app.roi.Position;
    xq = 1:size(app.data,2); yq = 1:size(app.data,1);
    [X, Y] = meshgrid(xq,yq);
    xq = reshape(X,[1,size(X,1)*size(X,2)]);
    yq = reshape(Y,[1,size(X,1)*size(X,2)]);
    [in,~] = inpolygon(yq,xq, app.positions(:,2), app.positions(:,1));
    idx = find(app.sliceData(yq(in),xq(in));
    [i, j] = ind2sub(size(plane), idx);
    
    [j, order] = sort(j);
    i = i(order);
    jq = linspace(min(j), max(j)
end