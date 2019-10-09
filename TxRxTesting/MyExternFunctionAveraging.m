function MyExternFunctionAveraging(RData)
    persistent myHandle
    persistent myHandleReceive
    Resource = evalin('base','Resource');
    Receive = evalin('base','Receive');
    if isempty(myHandle) || ~ishandle(myHandle)
        figure;
        myHandle = axes('NextPlot','replacechildren');
    end
    if isempty(myHandleReceive) || ~ishandle(myHandleReceive)
        figure;
        myHandleReceive = axes('NextPlot','replacechildren');
    end
    tx_channel = Resource.Parameters.tx_channel;
    data = getTxRxData(RData, Resource, Receive);
    
    title(myHandle, strcat(['Channel ', num2str(tx_channel)]));
    
    plot(myHandle, data.tx_data(1,:));

    rx_channel = Resource.Parameters.rx_channel;
    title(myHandleReceive, strcat(['Channel ', num2str(rx_channel)]));
    plot(myHandleReceive, data.rx_data(1,:));

    drawnow;
    return
end