function extern_set_frequency(RData)
Resource = evalin('base','Resource');
TPC = evalin('base', 'TPC');
TW(1).Parameters(1) = Resource.Parameters.frequency_array(Resource.Parameters.frequency_index);

assignin('base','TW',TW);

% Control = evalin('base','Control');
% Control.Command = 'update&Run';
% Control.Parameters = {'TW'};
% assignin('base','Control', Control);
% assignin('base', 'action', 'displayChange');
end