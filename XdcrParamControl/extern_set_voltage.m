function extern_set_voltage(RData)
Resource = evalin('base','Resource');
TPC = evalin('base', 'TPC');
% TPC(1).hv = Resource.Parameters.voltage_array(Resource.Parameters.voltage_index);
% 
% assignin('base','TPC',TPC);
% 
% if mod(Resource.Parameters.voltage_index + 1, length(Resource.Parameters.voltage_array)) == 0
%     Resource.Parameters.voltage_index = 1;
% else
%     Resource.Parameters.voltage_index = mod(Resource.Parameters.voltage_index + 1, length(Resource.Parameters.voltage_array));
% end
% assignin('base','Resource',Resource);
% Control = evalin('base','Control');
% Control.Command = 'update&Run';
% Control.Parameters = {'TPC'};
% assignin('base','Control', Control);
% assignin('base', 'action', 'displayChange');
%disp('Ran V now');
end