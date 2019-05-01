function myExternFunction(RData)
persistent myHandle
persistent myHandleReceive

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
title(myHandleReceive, "Channel 29");
plot(myHandleReceive, RData(:,29));

drawnow;
return

    