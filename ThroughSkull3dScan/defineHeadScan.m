function app = defineHeadScan(app, locs)
   positions = app.ND_scan.positions;
   positions(:,3) = app.theta*ones(1, size(positions,1));
   app.positions_cell{1} = positions;
   positions(:,3) = 180*ones(size(positions,1), 1) + positions(:,3);
   app.positions_cell{3} = positions;

   x_center = locs{1}(floor(app.ND_scan.steps(1)/2));
   scanAngle = 55;
   theta_range = linspace(scanAngle,(90-scanAngle)*2+scanAngle, 15);
   [LOCS1,LOCS2,LOCS3] = ndgrid(x_center,locs{2},theta_range);
   positions = reorder_pos(get_positions(LOCS1,LOCS2,LOCS3));
   app.positions_cell{2} = positions;

   [LOCS1,LOCS2,LOCS3] = ndgrid(x_center,locs{2},180+theta_range);
   positions = get_positions(LOCS1,LOCS2,LOCS3);
   app.positions_cell{4} = positions; 
end