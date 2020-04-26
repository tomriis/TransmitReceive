function [c_data] = calculateAttenuation(c_data)
    x1 = c_data(1).x1; x2= c_data(1).x2;
    for i = 1:length(c_data)
        for j = 1:c_data(1).TxEvents/2
            idx = j;
            maxAmpEcho = max(abs(c_data(i).xdr_1(idx,x1:x2)));
            maxAmpThroughTransmit = max(abs(c_data(i).xdr_2(idx,x1:x2)));
            c_data(i).echoAmp(j) = maxAmpEcho;
            c_data(i).throughTransmitAmp(j) = maxAmpThroughTransmit;
            
            idx = j+c_data(1).TxEvents/2;
            maxAmpEcho = max(abs(c_data(i).xdr_2(idx,x1:x2)));
            maxAmpThroughTransmit = max(abs(c_data(i).xdr_1(idx,x1:x2)));
            c_data(i).echoAmp(idx) = maxAmpEcho;
            c_data(i).throughTransmitAmp(idx) = maxAmpThroughTransmit;
        end
    end
end