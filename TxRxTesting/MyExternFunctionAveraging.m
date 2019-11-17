function MyExternFunctionAveraging(RData)
    persistent myHandle
    persistent myHandleReceive
    persistent myHandle2
    persistent myHandleReceive2
    persistent myFigureHandle
    persistent myFigureHandleReceive
    persistent myFigureHandle2
    persistent myFigureHandleReceive2
    N = 41;
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
    
    if isempty(myHandle2) || ~ishandle(myHandle2)
        myFigureHandle2 = figure;
        myHandle2 = axes('NextPlot','replacechildren');
    end
    if isempty(myHandleReceive2) || ~ishandle(myHandleReceive2)
        myFigureHandleReceive2 = figure;
        myHandleReceive2 = axes('NextPlot','replacechildren');
    end
    
    tx_channel = Resource.Parameters.tx_channel;
    [rx_data, tx_data] = get_frame_acq(RData, Resource, Receive, 1);

    
    movegui(myFigureHandle,[100 500]);
    title(myHandle, strcat(['Channel ', num2str(tx_channel)]));
    plot(myHandle, tx_data(1,:));

    rx_channel = Resource.Parameters.rx_channel;
    movegui(myFigureHandleReceive, [600 500]);
    title(myHandleReceive, strcat(['Channel ', num2str(rx_channel)]));
    plot(myHandleReceive, rx_data(1,:));
    
    movegui(myFigureHandle2,[100 0]);
    title(myHandle2, strcat(['Channel ', num2str(tx_channel)]));
    plot(myHandle2, tx_data(N,:));
    
    movegui(myFigureHandleReceive2,[600 0]);
    title(myHandleReceive2, strcat(['Channel ', num2str(rx_channel)]));
    plot(myHandleReceive2, rx_data(N,:));
    
    drawnow;
    return
end