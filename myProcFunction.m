function myProcFunction(RData)
persistent myHandle

channel = 2;

if isempty(myHandle) || ~ishandle(myHandle)
    figure;
    myHandle = axes('XLim',[0,2048],'YLim',[-16384 16384],...,
        'NextPlot','replacechildren');
end
subp
plot(myHandle, RData(:,channel));
disp('called');
drawnow;
return

    