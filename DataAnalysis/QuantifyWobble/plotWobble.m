h = figure;
m =4; n = 1;
p=1;
for i = 1:length(amatrix_cell)
    subplot(m,n,p);
    stdshade(amatrix_cell{i}, 0.5, 'b');
    %plot(amatrix_cell{i}');
    ylim([-1000,1000]);
    title(['XDR 1 Tx Event: ', num2str(i)]);
    p=p+1;
end

set(gcf,'color','w')