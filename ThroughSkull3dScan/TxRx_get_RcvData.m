function TxRx_get_RcvData(RcvData)
    Resource = evalin('base','Resource');
    Receive = evalin('base','Receive');
    data = getTxRxData(RcvData, Resource, Receive);
    data.positions = Resource.Parameters.positions;
    assignin('base','data',data);
end