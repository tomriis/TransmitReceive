function speedUpHistogram(data_dt)
    h = figure;
    histogram(data_dt,30)
    title('Speed Up Distribution Beaker');
    xlabel('Delay (microseconds)');
    ylabel('Count');
    makeFigureBig(h);
end