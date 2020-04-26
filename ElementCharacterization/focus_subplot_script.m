% for j = 1:5
idx = 4:5:47;%(j-1)*9+1:j*9;
ff = f(idx);

h = figure;
fontSize = 14;
axisFontSize = fontSize;
bgColor = 'w';

cal = get_cal_HNR0500(ff(1));
max_pnp_all = nanmax(mnp_field/cal*1e-6,[],'all');

for i = 1:length(idx)
    subplot(3,3,i)
    cal = get_cal_HNR0500(ff(i));
    field = mnp_field(:,:,idx(i))/cal*1e-6;
    imagesc(y, x, field);
    title([num2str(ff(i)),'MHz']);
    set(gca,'fontsize',axisFontSize-2);
    daspect([1, 1, 1]);
    xlabel('y (mm)');
    ylabel('x (mm)');
    set(gcf,'color',bgColor)
    caxis([0, max_pnp_all]);
    cb = colorbar;
    %cb.Ruler.Exponent = -3;
    ylabel(cb,'PNP (MPa)')
    %Colormap_axis = caxis;
    %set(Colormap_axis, 'YTickLabel', cellstr(num2str(reshape(get(Colormap_axis, 'YTick'),[],1),'%0.3f')) )
end


set(gcf,'color',bgColor);
set(findall(h,'type','text'),'fontSize',fontSize);
% end

data = zeros(1,length(f));
 Z=1.55e6;
for i=1:length(f)
    cal = get_cal_HNR0500(f(i));
    field = mnp_field(:,:,i)/cal;
    
    data(i) =  ((nansum((field.^2)./(2*Z),'all'))*abs(mean(diff(x*1e-3)))*abs(mean(diff(y*1e-3))));
end

h=figure; plot(f,data);
title('2D Field Sum');
xlabel('Frequency (MHz)');
ylabel('Power (W)');
fontSize = 14;
axisFontSize = fontSize;
bgColor = 'w';
set(gcf,'color',bgColor);
set(findall(h,'type','text'),'fontSize',fontSize);