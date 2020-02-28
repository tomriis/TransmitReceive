function extern_set_frequency(RData)
Resource = evalin('base','Resource');
TW = evalin('base', 'TW');
TW(1).Parameters(1) = Resource.Parameters.frequency_array(Resource.Parameters.frequency_index);

assignin('base','TW',TW);
if mod(Resource.Parameters.frequency_index + 1, length(Resource.Parameters.frequency_array)) == 0
    Resource.Parameters.frequency_index = 1;
else
    Resource.Parameters.frequency_index = mod(Resource.Parameters.frequency_index + 1, length(Resource.Parameters.frequency_array));
end
assignin('base','Resource',Resource);
Control = evalin('base','Control');
Control.Command = 'update&Run';
Control.Parameters = {'TW'};
assignin('base','Control', Control);
assignin('base', 'action', 'displayChange');
disp('ran now');
end