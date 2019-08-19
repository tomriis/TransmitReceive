function VerasonicsHydrophone3DScan(varargin)
evalin('base','clear');
p = inputParser;
addRequired(p, 'positions');
addRequired(p, 'lib');
addOptional(p, 'frequency', 0.5);
parse(p, varargin{:})

output_file_base_name = ['C:\Users\Verasonics\Documents\VerasonicsScanFiles\ElResponse\el_',];
%% User defined Scan Parameters
NA = 1;
frames_per_position = 1;
positionerDelay = 10; % Positioner delay in ms
frame_rate = 5;
centerFrequency = p.Results.frequency; % Frequency in MHz
num_half_cycles = 30; % Number of half cycles to use in each pulse
desiredDepth = 100; % Desired depth in mm
endDepth = desiredDepth;
rx_channel = 100;
tx_channel = 1;
Vpp =20;

%% Connect to Soniq
lib = p.Results.lib;
%[axis,positions] = verasonics_3d_scan(lib, [-40,1,1],[60,55,85],[250,4,1]);
axis = [1,2,0];
positions = p.Results.positions;
if mod(length(positions),2)~=0
    positions(end,:)=[];
end
n_positions = length(positions);
n_frames = frames_per_position * n_positions;

%% Setup System
% Since there are often long pauses after moving the positioner
% set a high timeout value for the verasonics DMA system
Resource.VDAS.dmaTimeout = 10000;

Resource.Parameters.soniqLib = lib;
Resource.Parameters.scan_mode = 1;
Resource.Parameters.numTransmit = tx_channel; 
Resource.Parameters.numRcvChannels = rx_channel; 
Resource.Parameters.connector = 1; 
Resource.Parameters.speedOfSound = 1540; % m/s
Resource.Parameters.Axis = axis;
Resource.Parameters.numAvg = NA;
Resource.Parameters.rx_channel = rx_channel;
Resource.Parameters.tx_channel = tx_channel;
Resource.Parameters.filename = output_file_base_name;
Resource.Parameters.positions = positions;
Resource.Parameters.current_index = 1;
Resource.Parameters.position_index = 1;
Resource.Parameters.fakeScanhead = 1;
%Resource.Parameters.simulateMode = 1; % runs script in simulate mode
%Media.MP(1,:) = [0,0,100,1.0]; % [x, y, z, reflectivity]
RcvProfile.AntiAliasCutoff = 10; %allowed values are 5, 10, 15, 20, and 30
%RcvProfile.PgaHPF = 80; %enables the integrator feedback path, 0 disables
%RcvProfile.LnaHPF = 50; % (200, 150,100,50) 200 KHz, 150 KHz, 100 KHz and 50 KHz respectively. 

Trans.name = 'Custom';
Trans.frequency = centerFrequency; % Lowest transmit frequency is 0.6345 Pg. 60
Trans.units = 'mm';
Trans.lensCorrection = 1;
%Trans.Bandwidth = [0,3]; % Set to 0.6 of center frequency by default
Trans.type = 0;
Trans.numelements = Resource.Parameters.rx_channel;
Trans.elementWidth = 24;
Trans.ElementPos = ones(Resource.Parameters.rx_channel,5);
Trans.ElementSens = ones(101,1);
Trans.connType = 1;
Trans.Connector = (1:Trans.numelements)';
Trans.impedance = 50;
Trans.maxHighVoltage = Vpp;

Resource.RcvBuffer(1).datatype = 'int16';
Resource.RcvBuffer(1).rowsPerFrame = 4096; % this allows for 1/4 maximum range
Resource.RcvBuffer(1).colsPerFrame = Trans.numelements; % change to 256 for V256 system
Resource.RcvBuffer(1).numFrames = n_frames; % minimum size is 1 frame.

TW(1).type = 'parametric';
TW(1).Parameters = [centerFrequency,0.67,num_half_cycles,1]; % A, B, C, D

TX(1).waveform = 1; % use 1st TW structure.
TX(1).focus = 0;
TX(1).Apod = zeros([1,Resource.Parameters.rx_channel]);
TX(1).Apod(tx_channel)=1;
assignin('base','Trans',Trans);
assignin('base','Resource',Resource);
TX(1).Delay = computeTXDelays(TX(1));

TPC(1).hv = Vpp;

TGC(1).CntrlPts = ones(1,8)*0;
TGC(1).rangeMax = 1;
TGC(1).Waveform = computeTGCWaveform(TGC);

Apod = zeros([1,Resource.Parameters.rx_channel]); 
Apod([Resource.Parameters.tx_channel,Resource.Parameters.rx_channel])=1;

Receive = repmat(struct(...
    'Apod', Apod, ... 
    'startDepth', 0, ...
    'endDepth', ceil(desiredDepth*1e-3/(Resource.Parameters.speedOfSound/(0.5*1e6))), ...
    'TGC', 1, ...
    'mode', 0, ...
    'bufnum', 1, ...
    'framenum', 1, ...
    'acqNum', 1, ...
    'sampleMode', 'custom', ...
    'decimSampleRate', 50*Trans.frequency,...
    'LowPassCoef',[],...
    'InputFilter',[]),...
    1,Resource.RcvBuffer(1).numFrames);

for i = 1:Resource.RcvBuffer(1).numFrames
    Receive(i).framenum = i;
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
for i = 1:n_positions
    for j = 1:frames_per_position
        idx = (i-1)*frames_per_position+j;
        Event(n).info = 'Acquire RF Data.';
        Event(n).tx = 1; 
        Event(n).rcv = 1; 
        Event(n).recon = 0; 
        Event(n).process = 0; 
        Event(n).seqControl = [1,3,nsc]; 
        SeqControl(nsc).command = 'transferToHost';
        nsc = nsc + 1;
        n = n+1;

        Event(n).info = 'Call external Processing function 2.';
        Event(n).tx = 0; % no TX structure.
        Event(n).rcv = 0; % no Rcv structure.
        Event(n).recon = 0; % no reconstruction.
        Event(n).process = 2; % call processing function
        Event(n).seqControl = 0;
        n = n+1;
    end
    Event(n).info = 'Move Positioner.';
    Event(n).tx = 0; 
    Event(n).rcv = 0;
    Event(n).recon = 0;
    Event(n).process = 3;
    % Need to sync or the verasonics system will acquire data faster 
    % than the positioner moves
%         Event(n).seqControl = nsc; 
%             SeqControl(nsc).command = 'sync';
%             nsc = nsc+1;
    n = n+1;

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

filename = 'C:\Users\Verasonics\Documents\MATLAB\TransmitReceive\MatFiles\VerasonicsHydrophone3DScan';

ws = [filename, '.mat'];
save(filename);
evalin('base', 'load(''C:\Users\Verasonics\Documents\MATLAB\TransmitReceive\MatFiles\VerasonicsHydrophone3DScan.mat'')');
evalin('base','VSX');
end