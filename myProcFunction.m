function myProcFunction(RData)
persistent myHandle



if isempty(myHandle) || ~ishandle(myHandle)
    figure;
    myHandle = axes('NextPlot','replacechildren');
end
subplot(2,1,1);
plot(RData(1,:));
subplot(2,1,2);
plot(RData(2,:));
drawnow;
return

    