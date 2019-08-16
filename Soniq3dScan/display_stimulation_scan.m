function display_stimulation_scan(file_base_name,cal)
% Given base file name, parses all mat files and creates data structure
% organized by coordinates in file name

Files=dir([file_base_name,'*','.mat']);
v_in = [];
data = zeros(length(Files),2);
for i = 1:length(Files)
    g = split(Files(i).name,'.mat');
    f = split(g{1},'_');
    n = str2double(f{2});
    freq = str2double(f{length(f)-4});
    dur = str2double(f{length(f)-2})*1e6;
    v = str2double(f{length(f)});
    v_in(end+1)=v;
    S = load([Files(i).folder,'\',Files(i).name]);
    pnp = findPeakNegativeVoltage(S.wv,4)/cal*1e-6;
    data(i,:)=[v,pnp];
end
disp('Done Scanning files');
v_in = sort(unique(v_in));
v_stats = zeros(length(v_in),2);

for i = 1:length(v_in)
       v_out = data(data(:,1)==v_in(i),2); 
       v_stats(i,1) = median(v_out);
       v_stats(i,2) = std(v_out);
end

h=figure; errorbar(v_in,v_stats(:,1),v_stats(:,2),'^');
title("Probe 8.5 MHz Stimulation (3.6 us Duration)");
xlabel('Verasonics Driving Amplitude (V)');
ylabel('Pressure (Mpa)')
xlim([0,55]);
fontSize = 14;
axisFontSize = fontSize;
bgColor = 'w';
set(gcf,'color',bgColor)
set(findall(h,'type','text'),'fontSize',fontSize);
end