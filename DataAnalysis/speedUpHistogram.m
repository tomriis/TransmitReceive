function speedUpHistogram(c_data)
    h = figure;
    data_dt = [];
    for i = 1:length(c_data)
        data_dt = horzcat(data_dt,c_data(i).di(2));
        data_dt = horzcat(data_dt,c_data(i).di(4));
    end
    fs = c_data(1).fs;
    
    histogram(data_dt/fs*1e6,30)
    title('Delays Distribution Beaker');
    xlabel('Delay (microseconds)');
    ylabel('Count');
    makeFigureBig(h);
end