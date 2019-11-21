function verasonicsWaveform3DScan(RData)
    persistent mySingletonFlag
    if isempty(mySingletonFlag)
        mySingletonFlag = 1;
    end
    if mySingletonFlag == 1
        pause(.25)
        mySingletonFlag = 0;
        disp('CLALLJOFJOJSOJ');
    end
    getVerasonicsWaveform(RData);
    MyExternFunctionAveraging(RData)

    movePositionerGridScan(RData)
end