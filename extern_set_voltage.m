function extern_set_voltage(RData)
Resource = evalin('base','Resource');
TPC = evalin('base', 'TPC');
TPC(1).hv = Resource.Parameters.voltage_array(Resource.Parameters.voltage_index);

assignin('base','TPC',TPC);

% Control = evalin('base','Control');
% Control.Command = 'update&Run';
% Control.Parameters = {'TPC'};
% assignin('base','Control', Control);
% assignin('base', 'action', 'displayChange');
end