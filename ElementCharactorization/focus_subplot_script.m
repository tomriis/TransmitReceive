for j = 1:5
idx = (j-1)*9+1:j*9;
ff = f(idx);

h = figure;
fontSize = 14;
axisFontSize = fontSize;
bgColor = 'w';
for i = 1:length(ff)
    subplot(3,3,i)
    imagesc(y,x,pnp_field(:,:,idx(i)));
    title([num2str(ff(i)),'MHz']);
    set(gca,'fontsize',axisFontSize-2);
    daspect([1, 1, 1]);
    xlabel('y (mm)');
    ylabel('x (mm)');
    set(gcf,'color',bgColor)
    caxis([0,0.0114]);
    cb = colorbar;
    %cb.Ruler.Exponent = -3;
    ylabel(cb,'PNP (V)')
    %Colormap_axis = caxis;
    %set(Colormap_axis, 'YTickLabel', cellstr(num2str(reshape(get(Colormap_axis, 'YTick'),[],1),'%0.3f')) )
end


set(gcf,'color',bgColor);
set(findall(h,'type','text'),'fontSize',fontSize);
end

data = zeros(1,length(f));
for i=1:length(f)
    data(i) = sum(sum(pnp_field(:,:,i),1));
end

h=figure; plot(f,data);
title('2D Sum');
xlabel('Frequency (MHz)');
ylabel('Intensity (a.u)');
fontSize = 14;
axisFontSize = fontSize;
bgColor = 'w';
set(gcf,'color',bgColor);
set(findall(h,'type','text'),'fontSize',fontSize);