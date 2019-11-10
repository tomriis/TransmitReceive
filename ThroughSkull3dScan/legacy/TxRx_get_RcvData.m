function TxRx_get_RcvData(RcvData)
    Resource = evalin('base','Resource');
    Receive = evalin('base','Receive');
    app =Resource.Parameters.app;
    position_steps = app.position_steps;
    
    data = getTxRxData(RcvData, Resource, Receive);
    data.positions = Resource.Parameters.positions;
    data.failed = Resource.Parameters.failed;
    %data.positions_steps = position_steps(end-size(data.positions,1)-1:end,:);
    
    save(filename_mat,'t','wv');
end