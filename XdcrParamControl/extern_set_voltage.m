function extern_set_voltage(RData)
Resource = evalin('base','Resource');
TPC = evalin('base', 'TPC');

Resource = evalin('base','Resource');
TW = evalin('base','TW');
Trans = evalin('base','Trans');
TPC = evalin('base','TPC');
curIdx = Resource.Parameters.curExcitation;
%Resource.Parameters.num_half_cycles
TW(1).type = 'parametric';
TW(1).Parameters = [Trans.frequency,0.67,curIdx,1]; % A, B, C, D
disp(curIdx);
if curIdx == length(Resource.Parameters.excitationVoltages)
    disp('Attempting to close VSX')
    VSXquit;
    VsClose;
    return
end

TPC(1).hv = Resource.Parameters.excitationVoltages(curIdx);
disp(['Voltage: ',num2str(Resource.Parameters.excitationVoltages(curIdx))]);
curIdx = curIdx+1;


Resource.Parameters.curExcitation = curIdx;
%% Update them in base
assignin('base','TW', TW);
assignin('base','Resource',Resource);
assignin('base','TPC',TPC);
% Set Control command to update TX
Control = evalin('base','Control');
Control.Command = 'update&Run';
Control.Parameters = {'TW','TX','TPC'};
assignin('base','Control', Control);
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
assignin('base', 'action', 'displayChange');
%disp('Ran V now');
end