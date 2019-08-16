function set_oscope_parameters(lib)
    fname='C:\Users\Verasonics\Documents\MATLAB\TransmitReceive\ElementTesting\OscopeParams.txt';
    calllib(lib,'LoadScopeSettings',fname);
%     calllib(lib,'SetScopeTriggerSource','External');
%     calllib(lib,'SetScopeTriggerLevel',0.5);
end