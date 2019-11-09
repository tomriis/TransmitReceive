function plotData1D(data, txFlag, rxFlag, x_axis,i)
figure; 
if txFlag
    plot(x_axis, data(i).tx(1,:)); hold on;
    plot(x_axis, data(i).tx(2,:)); hold on; 
end
if rxFlag
    plot(x_axis, data(i).rx(1,:)); hold on; 
    plot(x_axis, data(i).rx(2,:))
end
end