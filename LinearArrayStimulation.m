function LinearArrayStimulation(varargin)
evalin('base','clear');

p = inputParser;
addOptional(p, 'target_position', [0 0 0]);
addOptional(p, 'file_name', 'C:\Users\Verasonics\Documents\VerasonicsScanFiles\el_');
addOptional(p, 'imaging_freq', 8.5);
addOptional(p, 'stim_freq', 8.5);
addOptional(p, 'duty_cycle', 100);
addOptional(p, 'duration', 0.0005);
addOptional(p, 'prf',10000);

parse(p, varargin{:})

output_file_base_name = p.Results.file_name;
%% User defined Scan Parameters
NA = 1;
frames_per_position = 4;
positionerDelay = 150; % Positioner delay in ms
frame_rate = 10;

transmit_channels = 128;% Trans.numelements;
receive_channels = 128;%Trans.numelements;
imaging_prf = 10000; % 'timeToNextAcq' argument [microseconds] 
v_amplitude = 15;
%% Connect to Soniq
lib = loadSoniqLibrary();
openSoniq(lib);
set_oscope_parameters(lib)

n_frames = 4;

%% Setup System
% Since there are often long pauses after moving the positioner
% set a high timeout value for the verasonics DMA system
Resource.VDAS.dmaTimeout = 10000;
% Stim Resource parameters
Resource.Parameters.target_position = p.Results.target_position;
Resource.parameters.imaging_freq = p.Results.imaging_freq;
Resource.Parameters.stim_freq = p.Results.stim_freq;
Resource.parameters.duty_cycle = p.Results.duty_cycle;
Resource.parameters.duration = p.Results.duration;
Resource.parameters.prf = p.Results.prf;

% Movement parameters
Resource.Parameters.soniqLib = lib; 
Resource.Parameters.numTransmit = transmit_channels;
Resource.Parameters.numRcvChannels = receive_channels;
Resource.Parameters.connector = 0;
Resource.Parameters.speedOfSound = 1540; % m/s
Resource.Parameters.Axis = [1,2,0];
Resource.Parameters.numAvg = NA;
Resource.Parameters.filename = output_file_base_name;
Resource.Parameters.scan_mode = 1;
Resource.Parameters.current_index = 1;
Resource.Parameters.position_index = 1;
Resource.Parameters.simulateMode = 0; % runs script with hardware
Resource.Parameters.fakeScanhead = 1;
startDepth = 5;
endDepth = 200;
%Media.MP(1,:) = [0,0,100,1.0]; % [x, y, z, reflectivity]
RcvProfile.AntiAliasCutoff = 10; %allowed values are 5, 10, 15, 20, and 30
%RcvProfile.PgaHPF = 80; %enables the integrator feedback path, 0 disables
%RcvProfile.LnaHPF = 50; % (200, 150,100,50) 200 KHz, 150 KHz, 100 KHz and 50 KHz respectively. 

HVmux_script = 1;
aperture_num = 1;
Trans.name = 'L12-5 50mm';%'L12-5 38mm'; % 'L11-4v';
Trans.units = 'mm';
Trans.frequency = Resource.Parameters.stim_freq; % not needed if using default center frequency
Trans = computeTrans(Trans);
% Trans.name = 'Custom';
% Trans.frequency = Resource.Parameters.stim_freq; % Lowest transmit frequency is 0.6345 Pg. 60
% Trans.units = 'mm';
% Trans.lensCorrection = 1;
% %Trans.Bandwidth = [0,3]; % Set to 0.6 of center frequency by default
% Trans.type = 0;
% Trans.numelements = transmit_channels;
% Trans.elementWidth = 0.1703;
% Trans.ElementPos = ones(transmit_channels,5);
% Trans.ElementSens = ones(101,1);
% Trans.connType = 1;
% Trans.Connector = (1:Trans.numelements)';
% Trans.impedance = 51;
% Trans.maxHighVoltage = v_amplitude;

Resource.RcvBuffer(1).datatype = 'int16';
Resource.RcvBuffer(1).rowsPerFrame = 4096; % this allows for 1/4 maximum range
Resource.RcvBuffer(1).colsPerFrame = Trans.numelements; % change to 256 for V256 system
Resource.RcvBuffer(1).numFrames = n_frames; % minimum size is 1 frame.

% Specify Transmit waveform structure for focusing.
%TW(1).type = 'parametric';
%TW(1).Parameters = [Trans.frequency,.67,10,1];
TW(1).type = 'envelope';
TW = waveform_parameters_to_envelope(Trans.frequency*1e6, 0.50, 20000, 50e-6);
% Specify TX structure array.
TX = repmat(struct('waveform', 1, ...
                   'Origin', [0.0,0.0,0.0], ...
                   'aperture',aperture_num, ...
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
TX.FocalPtMm = Resource.Parameters.target_position;
TX.Delay = computeTXDelays(TX);

TPC(1).hv = v_amplitude;
% TPC(1).inUse = 0;
% TPC(5).inUse = 1;
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

Process(1).classname = 'External';
Process(1).method = 'myExternFunction';
Process(1).Parameters = {'srcbuffer','receive',...
'srcbufnum',1,...
'srcframenum',-1,...
'dstbuffer','none'};

Process(2).classname = 'External';
Process(2).method = 'extern_get_soniq_waveform';
Process(2).Parameters = {'srcbuffer','receive',...
'srcbufnum',1,...
'srcframenum',-1,...
'dstbuffer','none'};

Process(3).classname = 'External';
Process(3).method = 'continue_scan_3d';
Process(3).Parameters = {'srcbuffer','receive',... 
'srcbufnum',1,...
'srcframenum',-1,...
'dstbuffer','none'};

SeqControl(1).command = 'timeToNextAcq';
SeqControl(1).argument = 1/(frame_rate)*1e6; 

SeqControl(2).command = 'jump';
SeqControl(2).condition = 'exitAfterJump';
SeqControl(2).argument = 2*Resource.RcvBuffer(1).numFrames+1;

SeqControl(3).command = 'triggerOut';
nsc = 4; % start index for new SeqControl

n = 1;
for i = 1:Resource.RcvBuffer(1).numFrames
    for j = 1:frames_per_position
        for k = 1:1%length(Resource.parameters.TW)
            Event(n).info = 'Acquire RF Data.';
            Event(n).tx = 1; % use 1st TX structure.
            Event(n).rcv = 0; % use 1st Rcv structure for frame.
            Event(n).recon = 0; % no reconstruction.
            Event(n).process = 0; % no processing
            if j == 1
                Event(n).seqControl = [1,3]; 
            else
                Event(n).seqControl = 1;
            end
            n = n+1;
        end

        Event(n).info = 'Call external Processing function 2.';
        Event(n).tx = 0; % no TX structure.
        Event(n).rcv = 0; % no Rcv structure.
        Event(n).recon = 0; % no reconstruction.
        Event(n).process = 0; % call processing function
        Event(n).seqControl = 0;
        n = n+1;
    end
            Event(n).info = 'Call external Processing function 2.';
        Event(n).tx = 0; % no TX structure.
        Event(n).rcv = 0; % no Rcv structure.
        Event(n).recon = 0; % no reconstruction.
        Event(n).process = 2; % call processing function
        Event(n).seqControl = 0;
        n = n+1;
    
%     Event(n).info = 'Move Positioner.';
%     Event(n).tx = 0; 
%     Event(n).rcv = 0;
%     Event(n).recon = 0;
%     Event(n).process = 3;
%     % Need to sync or the verasonics system will acquire data faster 
%     % than the positioner moves
% %         Event(n).seqControl = nsc; 
% %             SeqControl(nsc).command = 'sync';
% %             nsc = nsc+1;
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

filename = 'C:\Users\Verasonics\Documents\MATLAB\TransmitReceive\MatFiles\LinearArrayStimulation';

ws = [filename, '.mat'];
save(filename);
evalin('base', 'load(''C:\Users\Verasonics\Documents\MATLAB\TransmitReceive\MatFiles\LinearArrayStimulation.mat'')');
evalin('base','VSX');
end