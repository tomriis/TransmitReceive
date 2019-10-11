function TxRx_get_RcvData(RcvData)
    Resource = evalin('base','Resource');
    Receive = evalin('base','Receive');
    app =Resource.Parameters.app;
    data = getTxRxData(RcvData, Resource, Receive);
    data.positions = Resource.Parameters.positions;
    data.positions_calc = zeros(size(data.positions));
    % Calculate positions from steps
    position_steps = app.position_steps;
    for i = 0:size(data.positions,2)-1
        data.positions_calc(end-i,:) = Resource.Parameters.app.positions(1,:) + sum(position_steps(2:end-i,:),1).*app.scale;
    end
    assignin('base','data',data);
end