clear all
%% User defined Scan Parameters
NA = 1;
nFrames = 10;
positionerDelay = 100; % Positioner delay in ms
frame_rate = 5;
centerFrequency = 0.500; % Frequency in MHz
num_half_cycles = 4; % Number of half cycles to use in each pulse
desiredDepth = 155; % Desired depth in mm
endDepth = desiredDepth;
rx_channel = 24;
tx_channel = 126;
Vpp =2.3;
Resource.Parameters.voltage_array = linspace(1.6, Vpp, 10);
Resource.Parameters.voltage_index = 1;
Resource.Parameters.frequency_array = linspace(0.5,4, 20);
Resource.Parameters.frequency_index = 1;
%% Setup System
% Since there are often long pauses after moving the positioner
% set a high timeout value for the verasonics DMA system
Resource.VDAS.dmaTimeout = 10000;

% Specify system parameters
Resource.Parameters.numTransmit = tx_channel; % no. of transmit channels
Resource.Parameters.numRcvChannels = rx_channel; % change to 64 for Vantage 64 system
Resource.Parameters.connector = 1; % trans. connector to use (V 256). Use 0 for 129-256
Resource.Parameters.speedOfSound = 1540; % speed of sound in m/sec
Resource.Parameters.numAvg = NA;
Resource.Parameters.rx_channel = rx_channel;
Resource.Parameters.tx_channel = tx_channel;
Resource.Parameters.filename = 'C:\Users\Verasonics\Documents\VerasonicsScanFiles\verasonics_scan';
Resource.Parameters.current_index = 1;
Resource.Parameters.fakeScanhead = 1;
%Resource.Parameters.simulateMode = 1; % runs script in simulate mode

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

TX(1).waveform = 1; % use 1st TW structure.
TX(1).focus = 0;
TX(1).Apod = zeros([1,Resource.Parameters.rx_channel]);
TX(1).Apod(tx_channel)=1;
TX(1).Delay = computeTXDelays(TX(1));

TPC(1).hv = Vpp;

% Specify TGC Waveform structure.
TGC(1).CntrlPts = ones(1,8)*0;
TGC(1).rangeMax = 1;
TGC(1).Waveform = computeTGCWaveform(TGC);

% Specify Receive structure array -
Apod = zeros([1,Resource.Parameters.rx_channel]); % if 64ch Vantage, = [ones(1,64) zeros(1,64)];
Apod([Resource.Parameters.tx_channel, Resource.Parameters.rx_channel])=1;

% Specify Receive structure array -
Receive = repmat(struct(...
    'Apod', Apod, ... 
    'startDepth', 0, ...
    'endDepth', ceil(desiredDepth*1e-3/(Resource.Parameters.speedOfSound/(centerFrequency*1e6))), ...
    'TGC', 1, ...
    'mode', 0, ...
    'bufnum', 1, ...
    'framenum', 1, ...
    'acqNum', 1, ...
    'sampleMode', 'custom', ...
    'decimSampleRate', 25,...
    'LowPassCoef',[],...
    'InputFilter',[]),...
    1,Resource.RcvBuffer(1).numFrames);

% - Set event specific Receive attributes.
for i = 1:Resource.RcvBuffer(1).numFrames
    Receive(i).framenum = i;
end

% Specify an external processing event.
Process(1).classname = 'External';
Process(1).method = 'myExternFunction';
Process(1).Parameters = {'srcbuffer','receive',... % name of buffer to process.
'srcbufnum',1,...
'srcframenum',-1,...
'dstbuffer','none'};

Process(2).classname = 'External';
Process(2).method = 'extern_set_voltage';
Process(2).Parameters = {'srcbuffer','receive',... % name of buffer to process.
'srcbufnum',1,...
'srcframenum',-1,...
'dstbuffer','none'};

SeqControl(1).command = 'timeToNextAcq';
SeqControl(1).argument = 1/(frame_rate)*1e6; % wait time in microseconds

SeqControl(2).command = 'jump';
SeqControl(2).condition = 'exitAfterJump';
SeqControl(2).argument = 2*Resource.RcvBuffer(1).numFrames+1;

SeqControl(3).command = 'triggerOut';

nsc = 4; % start index for new SeqControl

n = 1; % start index for Events
for i = 1:Resource.RcvBuffer(1).numFrames
    Event(n).info = 'Acquire RF Data.';
    Event(n).tx = 1; % use 1st TX structure.
    Event(n).rcv = i; % use unique Receive for each frame.
    Event(n).recon = 0; % no reconstruction.
    Event(n).process = 0; % no processing
    Event(n).seqControl = [1,3,nsc]; % set TTNA time and transfer
    SeqControl(nsc).command = 'transferToHost';
    nsc = nsc + 1;
    n = n+1;
    
    Event(n).info = 'Call external Processing function.';
    Event(n).tx = 0; % no TX structure.
    Event(n).rcv = 0; % no Rcv structure.
    Event(n).recon = 0; % no reconstruction.
    Event(n).process = 1; % call processing function
    Event(n).seqControl = 0;
    n = n+1;
    
%     Event(n).info = 'Call external Processing function 2.';
%     Event(n).tx = 0; % no TX structure.
%     Event(n).rcv = 0; % no Rcv structure.
%     Event(n).recon = 0; % no reconstruction.
%     Event(n).process = 2; % call processing function
%     Event(n).seqControl = 0;
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

for i = 1:Resource.RcvBuffer(1).numFrames
    Event(n).info = 'Acquire RF Data.';
    Event(n).tx = 1; % use 1st TX structure.
    Event(n).rcv = i; % use unique Receive for each frame.
    Event(n).recon = 0; % no reconstruction.
    Event(n).process = 0; % no processing
    Event(n).seqControl = [1,3,nsc]; % set TTNA time and transfer
    SeqControl(nsc).command = 'transferToHost';
    nsc = nsc + 1;
    n = n+1;
    
    Event(n).info = 'Call external Processing function.';
    Event(n).tx = 0; % no TX structure.
    Event(n).rcv = 0; % no Rcv structure.
    Event(n).recon = 0; % no reconstruction.
    Event(n).process = 1; % call processing function
    Event(n).seqControl = 0;
    n = n+1;
end

Event(n).info = 'Jump back to Event 1.';
Event(n).tx = 0; % no TX structure.
Event(n).rcv = 0; % no Rcv structure.
Event(n).recon = 0; % no reconstruction.
Event(n).process = 0; % no processing
Event(n).seqControl = 2; % jump back to Event 1.

svName ='C:\Users\Verasonics\Documents\Matlab\TransmitReceive\MatFiles\TxRxMultipleFrames';
save(svName);

filename = svName;
VSX
return