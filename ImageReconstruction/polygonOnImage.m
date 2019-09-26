h = figure;
imagesc(V1(:,:,13));
ax = findall(h, 'type', 'axes');
roi = images.roi.Polygon(ax,'Position',[10 15; 20 25; 30 35; 15 45]);

