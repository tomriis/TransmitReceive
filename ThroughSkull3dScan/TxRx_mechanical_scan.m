function TxRx_mechanical_scan(positions, app)
evalin('base','clear');
%% User defined Scan Parameters
TxEvents = 4;
NA = 20;
NA = TxEvents*NA;
nPositions = size(positions,1);
disp(['num positions', num2str(nPositions)]);
nFrames = 2;
prf = 500;
rate = 0.007; % ms delay per step
positioner_delays = get_positioner_delays(app, positions,rate); % Positioner delay in ms
disp('max time');
disp(max(positioner_delays));
f = max(positioner_delays);
centerFrequency = 0.5; % Frequency in MHz
num_half_cycles = 12; % Number of half cycles to use in each pulse
desiredDepth = 155; % Desired depth in mm
endDepth = desiredDepth;
rx_channel = 97;
tx_channel = 82;
Vpp = 40;

%% Setup System
% Since there are often long pauses after moving the positioner
% set a high timeout value for the verasonics DMA system
Resource.VDAS.dmaTimeout = 10000;

% Specify system parameters
Resource.Parameters.numTransmit = rx_channel; % no. of transmit channels
Resource.Parameters.numRcvChannels = rx_channel; % change to 64 for Vantage 64 system
Resource.Parameters.connector = 1; % trans. connector to use (V 256). Use 0 for 129-256
Resource.Parameters.speedOfSound = 1540; % speed of sound in m/sec
Resource.Parameters.app = app;
Resource.Parameters.position_index = 1;
Resource.Parameters.numAvg = NA;
Resource.Parameters.rx_channel = rx_channel;
Resource.Parameters.tx_channel = tx_channel;
Resource.Parameters.positions = positions;
Resource.Parameters.fakeScanhead = 1;
Resource.Parameters.failed = 0;
Resource.Parameters.TxEvents = TxEvents;
Resource.Parameters.NA = NA;
% Resource.Parameters.simulateMode = 1; % runs script in simulate mode
RcvProfile.AntiAliasCutoff = 10; %allowed values are 5, 10, 15, 20, and 30
%RcvProfile.PgaHPF = 80; %enables the integrator feedback path, 0 disables
%RcvProfile.LnaHPF = 50; % (200, 150,100,50) 200 KHz, 150 KHz, 100 KHz and 50 KHz respectively. 

% Specify Transmit waveform structure.
% Specify media points
Media.MP(1,:) = [0,0,100,1.0]; % [x, y, z, reflectivity]

% Specify Trans structure array.
Trans.name = 'Custom';
Trans.frequency = centerFrequency; % Lowest transmit frequency is 0.6345 Pg. 60
Trans.units = 'mm';
Trans.lensCorrection = 1;
%Trans.Bandwidth = [0,3]; % Set to 0.6 of center frequency by default
Trans.type = 0;
Trans.numelements = max(Resource.Parameters.rx_channel, Resource.Parameters.tx_channel);
Trans.elementWidth = 24;
Trans.ElementPos = ones(Trans.numelements,5);
Trans.ElementSens = ones(101,1);
Trans.connType = 1;
Trans.Connector = (1:Trans.numelements)';
Trans.impedance = 50;
Trans.maxHighVoltage = Vpp;

% Specify Resource buffers.
Resource.RcvBuffer(1).datatype = 'int16';
Resource.RcvBuffer(1).rowsPerFrame = NA*2048*4; % this allows for 1/4 maximum range
Resource.RcvBuffer(1).colsPerFrame = Trans.numelements; % change to 256 for V256 system
Resource.RcvBuffer(1).numFrames = nFrames; % minimum size is 1 frame.

% Specify Transmit waveform structure.
TW(1).type = 'parametric';
TW(1).Parameters = [centerFrequency,0.67,num_half_cycles,1]; % A, B, C, D

% Specify TX structure array.
TX(1).waveform = 1; % use 1st TW structure.
TX(1).focus = 0;
TX(1).Apod = zeros([1,Resource.Parameters.rx_channel]);
TX(1).Apod(tx_channel)=1;
assignin('base','Trans',Trans);
assignin('base','Resource',Resource);
TX(1).Delay = computeTXDelays(TX(1));

TW(2).type = 'parametric';
TW(2).Parameters = [0.5,0.67,2,1]; % A, B, C, D

TX(2).waveform = 2; % use 1st TW structure.
TX(2).focus = 0;
TX(2).Apod = zeros([1,Resource.Parameters.rx_channel]);
TX(2).Apod(tx_channel)=1;
TX(2).Delay = computeTXDelays(TX(1));

TX(3).waveform = 1;
TX(3).focus = 0;
TX(3).Apod = zeros([1,Resource.Parameters.rx_channel]);
TX(3).Apod(rx_channel) = 1;
TX(3).Delay = computeTXDelays(TX(3));

TX(4).waveform = 2;
TX(4).focus = 0;
TX(4).Apod = zeros([1,Resource.Parameters.rx_channel]);
TX(4).Apod(rx_channel) = 1;
TX(4).Delay = computeTXDelays(TX(4));

TPC(1).hv = Vpp;

% Specify TGC Waveform structure.
TGC(1).CntrlPts = ones(1,8)*0;
TGC(1).rangeMax = 1;
TGC(1).Waveform = computeTGCWaveform(TGC);

% Specify Receive structure array -
Apod = zeros([1,Resource.Parameters.rx_channel]); % if 64ch Vantage, = [ones(1,64) zeros(1,64)];
Apod([Resource.Parameters.tx_channel, Resource.Parameters.rx_channel])=1;

firstReceive.Apod = Apod;
firstReceive.startDepth = 0;
% Use user supplied depth to set the depth in wavelengths
firstReceive.endDepth = ceil(desiredDepth*1e-3/(Resource.Parameters.speedOfSound/(centerFrequency*1e6)));
firstReceive.TGC = 1; % Use the first TGC waveform defined above
firstReceive.mode = 0;
firstReceive.bufnum = 1;
firstReceive.framenum = 1;
firstReceive.acqNum = 1;
firstReceive.sampleMode = 'custom';
firstReceive.decimSampleRate = 50*Trans.frequency;
firstReceive.LowPassCoef = [];
firstReceive.InputFilter = [];


for n = 1:NA
    Receive(n) = firstReceive;
    Receive(n).acqNum = n;
end

% Process(1).classname = 'External';
% Process(1).method = 'getVerasonicsWaveform';
% Process(1).Parameters = {'srcbuffer','receive',... % name of buffer to process.
% 'srcbufnum',1,...
% 'srcframenum',1,...
% 'dstbuffer','none'};
Process(1).classname = 'External';
Process(1).method = 'verasonicsWaveform3DScan';
Process(1).Parameters = {'srcbuffer','receive',... % name of buffer to process.
'srcbufnum',1,...
'srcframenum',1,...
'dstbuffer','none'};


% Specify an external processing event.
Process(2).classname = 'External';
Process(2).method = 'movePositionerGridScan';
Process(2).Parameters = {'srcbuffer','receive',... % name of buffer to process.
'srcbufnum',1,...
'srcframenum',-1,...
'dstbuffer','none'};

n = 1;
nsc = 1;

firstEvent.info = 'Acquire RF Data.';
firstEvent.tx = 1; % use 1st TX structure.
firstEvent.rcv = 1; % use 1st Rcv structure.
firstEvent.recon = 0; % no reconstruction.
firstEvent.process = 0; % no processing
firstEvent.seqControl = [1,2];
    SeqControl(nsc).command = 'timeToNextAcq';
    SeqControl(nsc).argument = (1/prf)*1e6;
    nsc = nsc+1;


tx_count = 1;
for ii = 1:NA
    Event(n) = firstEvent;
    Event(n).tx = tx_count;
    if mod(ii, NA/TxEvents)==0
        tx_count=tx_count+1;
    end
    Event(n).rcv = ii;
    Event(n).seqControl = [1,nsc];
     SeqControl(nsc).command = 'transferToHost';
       nsc = nsc + 1;
    n = n+1;
end

Event(n).info = 'Acquire a waveform and move positioner';
Event(n).tx = 0; % no TX structure.
Event(n).rcv = 0; % no Rcv structure.
Event(n).recon = 0; % no reconstruction.
Event(n).process = 1; 
n = n+1;

Event(n).info = 'Jump back to Event first Tx Event.';
Event(n).tx = 0; % no TX structure.
Event(n).rcv = 0; % no Rcv structure.
Event(n).recon = 0; % no reconstruction.
Event(n).process = 0; % no processing
Event(n).seqControl = nsc; % jump back to Event 1
SeqControl(nsc).command = 'jump';
SeqControl(nsc).condition = 'exitAfterJump';
SeqControl(nsc).argument = 1;

% Save all the structures to a .mat file.
svName = 'C:\Users\Verasonics\Documents\MATLAB\TransmitReceive\MatFiles\TxRx_mechanical_scan';
filename = svName;
save(svName);
evalin('base', 'load(''C:\Users\Verasonics\Documents\MATLAB\TransmitReceive\MatFiles\TxRx_mechanical_scan.mat'')');
evalin('base','VSX');
end