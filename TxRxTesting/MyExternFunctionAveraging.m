function MyExternFunctionAveraging(RData)
    persistent myHandle
    persistent myHandleReceive
    persistent myFigureHandle
    persistent myFigureHandleReceive
    Resource = evalin('base','Resource');
    Receive = evalin('base','Receive');
    if isempty(myHandle) || ~ishandle(myHandle)
        myFigureHandle = figure;
        myHandle = axes('NextPlot','replacechildren');
    end
    if isempty(myHandleReceive) || ~ishandle(myHandleReceive)
        myFigureHandleReceive = figure;
        myHandleReceive = axes('NextPlot','replacechildren');
    end
    tx_channel = Resource.Parameters.tx_channel;
    [rx_data, tx_data] = get_frame_acq(RData, Resource, Receive, 1);

    
    movegui(myFigureHandle,[100 500]);
    title(myHandle, strcat(['Channel ', num2str(tx_channel)]));
    plot(myHandle, tx_data(1,:));

    rx_channel = Resource.Parameters.rx_channel;
    title(myHandleReceive, strcat(['Channel ', num2str(rx_channel)]));
    plot(myHandleReceive, rx_data(1,:));

    drawnow;
    return
end