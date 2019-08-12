function pnp_field = display_spatial_scan(file_base_name)
% Given base file name, parses all mat files and creates data structure
% organized by coordinates in file name

Files=dir([file_base_name,'*','.mat']);


grid_xy = zeros(length(Files),3);
for i = 1:length(Files)
    g = split(Files(i).name,'.mat');
    f = split(g{1},'_');
    x = str2double(f{length(f)-2});
    y = str2double(f{length(f)-1});
    z = f{length(f)};
    
    S = load([Files(i).folder,'\',Files(i).name]);
    pnp = findPeakNegativeVoltage(S.wv,4);
    grid_xy(i,:)=[x,y,pnp];
end
disp('Done Scanning files');
x = sort(unique(grid_xy(:,1)));
y = sort(unique(grid_xy(:,2)));

pnp_field = zeros(length(x),length(y));

for i = 1:length(x)
    for j = 1:length(y)
       grid_y = grid_xy(grid_xy(:,1)==x(i),:); 
       tmp = grid_y(grid_y(:,2)==y(j),:);
       try
            pnp_field(i,j) = tmp(1,3);
       catch
           disp(['on ', num2str(i), ' of ', num2str(length(x))]);
           disp(num2str(j));
       end
    end
end

figure; imagesc(x,y,pnp_field');
f = split(file_base_name,'\');
title(f{end-1});
xlabel('x (mm)');
ylabel('y (mm)');

end
