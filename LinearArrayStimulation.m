function LinearArrayStimulation(varargin)
evalin('base','clear');

p = inputParser;
% addRequired(p, 'lib');
addOptional(p, 'target_position', [0 0 23]);
addOptional(p, 'file_name', 'C:\Users\Verasonics\Documents\VerasonicsScanFiles\el_');
addOptional(p, 'imaging_freq', 5.5);
addOptional(p, 'stim_freq', 5.5);
addOptional(p, 'duty_cycle', 100);
addOptional(p, 'duration', 0.0005);
addOptional(p, 'prf',10000);
addOptional(p, 'v_amplitude',5);
parse(p, varargin{:})

output_file_base_name = p.Results.file_name;
%% User defined Scan Parameters
NA = 1;
frames_per_position = 20;
positionerDelay = 1000; % Positioner delay in ms
frame_rate = 10;

transmit_channels = 128;% Trans.numelements;
receive_channels = 128;%Trans.numelements;
imaging_prf = 10000; % 'timeToNextAcq' argument [microseconds] 
v_amplitude = p.Results.v_amplitude;
%% Connect to Soniq

positions = zeros(8,3);
lib = 1; %p.Results.lib;

n_positions = length(positions);
n_frames = frames_per_position * n_positions;

%% Setup System
% Since there are often long pauses after moving the positioner
% set a high timeout value for the verasonics DMA system
Resource.VDAS.dmaTimeout = 10000;
% Stim Resource parameters
Resource.Parameters.target_position = p.Results.target_position;
Resource.Parameters.imaging_freq = p.Results.imaging_freq;
Resource.Parameters.stim_freq = p.Results.stim_freq;
Resource.Parameters.duty_cycle = p.Results.duty_cycle;
Resource.Parameters.duration = p.Results.duration;
Resource.Parameters.prf = p.Results.prf;
Resource.Parameters.v_amplitude = v_amplitude;
% Movement parameters
Resource.Parameters.soniqLib = lib; 
Resource.Parameters.numTransmit = transmit_channels;
Resource.Parameters.numRcvChannels = receive_channels;
Resource.Parameters.connector = 0;
Resource.Parameters.speedOfSound = 1540; % m/s
Resource.Parameters.Axis = [1,2,0];
Resource.Parameters.numAvg = NA;
Resource.Parameters.filename = output_file_base_name;
Resource.Parameters.positions = positions;
Resource.Parameters.current_index = 1;
Resource.Parameters.position_index = 1;
Resource.Parameters.simulateMode = 0; % runs script with hardware
startDepth = 5;
endDepth = 200;
%Media.MP(1,:) = [0,0,100,1.0]; % [x, y, z, reflectivity]
RcvProfile.AntiAliasCutoff = 10; %allowed values are 5, 10, 15, 20, and 30
%RcvProfile.PgaHPF = 80; %enables the integrator feedback path, 0 disables
%RcvProfile.LnaHPF = 50; % (200, 150,100,50) 200 KHz, 150 KHz, 100 KHz and 50 KHz respectively. 

HVmux_script = 1;
aperture_num = 64;
Trans.name = 'L12-5 50mm';%'L12-5 38mm'; % 'L11-4v';
Trans.units = 'mm';
Trans.frequency = Resource.Parameters.stim_freq; % not needed if using default center frequency
Trans = computeTrans(Trans);

Resource.RcvBuffer(1).datatype = 'int16';
Resource.RcvBuffer(1).rowsPerFrame = 4096; % this allows for 1/4 maximum range
Resource.RcvBuffer(1).colsPerFrame = Trans.numelements; % change to 256 for V256 system
Resource.RcvBuffer(1).numFrames = n_frames; % minimum size is 1 frame.

% Specify Transmit waveform structure for focusing.
TW(1).type = 'parametric';
wavelengths = 40;%floor(Resource.Parameters.duration*Trans.frequency*1e6)
TW(1).Parameters = [Trans.frequency,.67,2*wavelengths,1];

% Specify TX structure array.
TX = repmat(struct('waveform', 1, ...
                   'Origin', [0.0,0.0,0.0], ...
                   'aperture', aperture_num, ...
                   'Apod', ones(1,Resource.Parameters.numTransmit), ...
                   'focus', 0.0, ...
                   'Steer', [0.0,0.0], ...
                   'Delay', zeros(1,Resource.Parameters.numTransmit)), 1, 1);
% % % TX(2).aperture = 65;  % Use the tx aperture that starts at element 65.
% % % TX(3).aperture = 129; % Use the tx aperture that starts at element 129.
% if sum(Resource.Parameters.target_position) ~= 0
% delays = compute_linear_array_delays(Trans.ElementPos,...,
%     Resource.Parameters.target_position,...,
%     Resource.Parameters.speedOfSound*1000);
% TX(1).Delay = delays(Trans.HVMux.ApertureES(:,aperture_num)~=0);
% end
assignin('base','Trans',Trans);
assignin('base','Resource',Resource);
TX(1).FocalPtMm = Resource.Parameters.target_position;
TX(1).Delay = computeTXDelays(TX);

% TPC(1).inUse = 0;
% TPC(5).inUse = 1;
TPC(1).hv = v_amplitude;

% Specify TGC Waveform structure.
TGC(1).CntrlPts = [300,450,575,675,750,800,850,900];
TGC(1).rangeMax = endDepth;
TGC(1).Waveform = computeTGCWaveform(TGC);
% Specify Receive structure array -
Receive = repmat(struct(...
'Apod', zeros(1, receive_channels), ...
'startDepth', 0, ...
'endDepth', 200, ...
'TGC', 1, ...
'mode', 0, ...
'bufnum', 1, ...
'framenum', 1, ...
'acqNum', 1, ...
'sampleMode', 'NS200BW', ...
'LowPassCoef',[],...
'InputFilter',[]),...
1,Resource.RcvBuffer(1).numFrames);
% - Set event specific Receive attributes.

for i = 1:Resource.RcvBuffer(1).numFrames
    Receive(i).Apod = ones(1, receive_channels);
    Receive(i).framenum = i;
    if HVmux_script
        Receive(i).aperture = aperture_num;
    end
end


%% Event and Process Code

% Process(1).classname = 'External';
% Process(1).method = 'extern_exit_loop';
% Process(1).Parameters = {'srcbuffer','receive',...
% 'srcbufnum',1,...
% 'srcframenum',-1,...
% 'dstbuffer','none'};
% 
% Process(2).classname = 'External';
% Process(2).method = 'extern_get_soniq_waveform';
% Process(2).Parameters = {'srcbuffer','receive',...
% 'srcbufnum',1,...
% 'srcframenum',-1,...
% 'dstbuffer','none'};
% 
% Process(3).classname = 'External';
% Process(3).method = 'continue_scan_3d';
% Process(3).Parameters = {'srcbuffer','receive',... 
% 'srcbufnum',1,...
% 'srcframenum',-1,...
% 'dstbuffer','none'};

SeqControl(1).command = 'timeToNextAcq';
SeqControl(1).argument = 11;%/(frame_rate)*1e6; 

SeqControl(2).command = 'jump';
SeqControl(2).condition = 'exitAfterJump';
SeqControl(2).argument = 2*Resource.RcvBuffer(1).numFrames+1;

SeqControl(3).command = 'triggerOut';
nsc = 4; % start index for new SeqControl

n = 1;
for i = 1:n_positions
    for j = 1:frames_per_position
        for k = 1:1%length(Resource.parameters.TW)
            Event(n).info = 'Acquire RF Data.';
            Event(n).tx = 1; % use 1st TX structure.
            Event(n).rcv = 0; % use 1st Rcv structure for frame.
            Event(n).recon = 0; % no reconstruction.
            Event(n).process = 0; % no processing
            if k == 1
                Event(n).seqControl = [1,3]; 
            end
            n = n+1;
        end

%         Event(n).info = 'Call external Processing function 2.';
%         Event(n).tx = 0; % no TX structure.
%         Event(n).rcv = 0; % no Rcv structure.
%         Event(n).recon = 0; % no reconstruction.
%         Event(n).process = 2; % call processing function
%         Event(n).seqControl = 0;
%         n = n+1;
    end
%     Event(n).info = 'Exit';
%     Event(n).tx = 0; 
%     Event(n).rcv = 0;
%     Event(n).recon = 0;
%     Event(n).process = 1;
    % Need to sync or the verasonics system will acquire data faster 
    % than the positioner moves
%         Event(n).seqControl = nsc; 
%             SeqControl(nsc).command = 'sync';
%             nsc = nsc+1;
%     n = n+1;

    Event(n).info = 'Wait';
    Event(n).tx = 0; 
    Event(n).rcv = 0;
    Event(n).recon = 0;
    Event(n).process = 0;
    Event(n).seqControl = nsc;
        SeqControl(nsc).command = 'noop';
        SeqControl(nsc).argument = (positionerDelay*1e-3)/200e-9;
        SeqControl(nsc).condition = 'Hw&Sw';
        nsc = nsc+1;
    n = n+1;
end

Event(n).info = 'Jump back to Event 1.';
Event(n).tx = 0; 
Event(n).rcv = 0; 
Event(n).recon = 0; 
Event(n).process = 0; 
Event(n).seqControl = 2;

% EF(1).Function = {'extern_exit_loop(RData)',...
%     'Resource = evalin(''base'',''Resource'');',...
%     'current_index = Resource.Parameters.current_index;',...
%     'if current_index >= Resource.RcvBuffer(1).numFrames',...
%     'VsClose',...
%     'end',...
%     'return'};

filename = 'C:\Users\Verasonics\Documents\MATLAB\TransmitReceive\MatFiles\LinearArrayStimulation';

ws = [filename, '.mat'];
save(filename);
evalin('base', 'load(''C:\Users\Verasonics\Documents\MATLAB\TransmitReceive\MatFiles\LinearArrayStimulation.mat'')');
evalin('base','VSX');

end