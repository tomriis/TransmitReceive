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
title(myHandle, "Channel 1");
plot(myHandle, RData(:,1));
%subplot(2,1,2);
rx_channel = Resource.Parameters.rx_channel;
title(myHandleReceive, strcat(['Channel ', num2str(rx_channel)]));
plot(myHandleReceive, RData(:,rx_channel));

drawnow;
return

    