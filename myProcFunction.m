function myProcFunction(RData)
persistent myHandle

try
    channel = evalin('base','myPlotChnl');
catch
    channel =  1;
end

if isempty(myHandle) || ~ishandle(myHandle)
    figure;
    myHandle = axes('XLim',[0,1500],'YLim',[-16384 16384],...,
        'NextPlot','replacechildren');
end

plot(myHandle, RData(:,channel));
drawnow;
return

    