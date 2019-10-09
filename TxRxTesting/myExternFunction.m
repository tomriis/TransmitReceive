function myExternFunction(RData)
persistent myHandle
persistent myHandleReceive
Resource = evalin('base','Resource');
if isempty(myHandle) || ~ishandle(myHandle)
    figure;
    myHandle = axes('NextPlot','replacechildren');
end
if isempty(myHandleReceive) || ~ishandle(myHandleReceive)
    figure;
    myHandleReceive = axes('NextPlot','replacechildren');
end
tx_channel = Resource.Parameters.tx_channel;
title(myHandle, strcat(['Channel ', num2str(tx_channel)]));
plot(myHandle, RData(:,tx_channel));

rx_channel = Resource.Parameters.rx_channel;
title(myHandleReceive, strcat(['Channel ', num2str(rx_channel)]));
plot(myHandleReceive, RData(:,rx_channel));

drawnow;
return

    