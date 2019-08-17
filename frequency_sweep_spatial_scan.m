function [pnp_field] = frequency_sweep_spatial_scan(file_base_name)
% Given base file name, parses all mat files and creates data structure
% organized by coordinates in file name

Files=dir([file_base_name,'*','.mat']);
count = 0;
grid_xyf = zeros(length(Files),4);
for i = 1:length(Files)
    g = split(Files(i).name,'.mat');
    f = split(g{1},'_');
    x = str2double(f{length(f)-3});
    y = str2double(f{length(f)-2});
    z = str2double(f{length(f)-1});
    freq = str2double(f{length(f)});
    
    S = load([Files(i).folder,'/',Files(i).name]);
    try
        pnp = findPeakNegativeVoltage(S.wv,15);
    catch
        count = count +1;
        pnp = findPeakNegativeVoltage(S.wv,4);
    end
    grid_xyf(i,:)=[x,y,freq,pnp];
end
disp('Done Scanning files');
disp(['Failed on ', num2str(count), ' of ', num2str(length(Files))]);
x = sort(unique(grid_xyf(:,1)));
y = sort(unique(grid_xyf(:,2)));
f = sort(unique(grid_xyf(:,3)));

pnp_field = zeros(length(x),length(y),length(f));

for i = 1:length(x)
    for j = 1:length(y)
        for k = 1:length(f)
            grid_yf = grid_xyf(grid_xyf(:,1)==x(i),:); 
            grid_f = grid_yf(grid_yf(:,2)==y(j),:);
            tmp = grid_f(grid_f(:,3)==f(k),:);
       try
            pnp_field(i,j,k) = tmp(1,4);
       catch
           disp(['on ', num2str(i), ' of ', num2str(length(x))]);
           disp(num2str(j));
       end
        end
    end
end
end