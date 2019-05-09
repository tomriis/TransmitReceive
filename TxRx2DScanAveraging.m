clear all; close all; clc;

%[lib,axis,locs] = verasonics2dScan(1,-15,15,n_frames);
Dimensions = [1 2];
[lib,axis,LOCS1,LOCS2] = verasonics2dScan(Dimensions,[-1,29]',[1,31]',[2,2]);
positions = get_positions(LOCS1, LOCS2); 
%% User defined Scan Parameters
NA = 100;
nFrames = length(LOCS1(:));
positionerDelay = 1000; % Positioner delay in ms
prf = 500; % Pulse repitition Frequency in Hz
centerFrequency = 0.5; % Frequency in MHz
num_half_cycles = 30; % Number of half cycles to use in each pulse
desiredDepth = 160; % Desired depth in mm
endDepth = desiredDepth;
rx_channel = 228;
tx_channel = 100;
Vpp = 75;

%% Setup System
% Since there are often long pauses after moving the positioner
% set a high timeout value for the verasonics DMA system
Resource.VDAS.dmaTimeout = 10000;

% Specify system parameters
Resource.Parameters.numTransmit = tx_channel; % no. of transmit channels
Resource.Parameters.numRcvChannels = rx_channel; % change to 64 for Vantage 64 system
Resource.Parameters.connector = 0; % trans. connector to use (V 256). Use 0 for 129-256
Resource.Parameters.speedOfSound = 1540; % speed of sound in m/sec
Resource.Parameters.soniqLib = lib;
Resource.Parameters.Axis = axis;
Resource.Parameters.LOCS1 = LOCS1;
Resource.Parameters.LOCS2 = LOCS2;
Resource.Parameters.numAvg = NA;
Resource.Parameters.rx_channel = rx_channel;
Resource.Parameters.tx_channel = tx_channel;
Resource.Parameters.positions = positions;
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
Trans.numelements = Resource.Parameters.rx_channel;
Trans.elementWidth = 24;
Trans.ElementPos = ones(Resource.Parameters.rx_channel,5);
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
TX(1).Delay = computeTXDelays(TX(1));

TPC(1).hv = Vpp;

% Specify TGC Waveform structure.
TGC(1).CntrlPts = ones(1,8)*100;
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
firstReceive.decimSampleRate = 30*Trans.frequency;
firstReceive.LowPassCoef = [];
firstReceive.InputFilter = [];

for ii = 1:nFrames
    for jj = 1:NA
        idx = (ii-1)*NA+jj;
        Receive(idx) = firstReceive;
        Receive(idx).acqNum = jj;
        Receive(idx).framenum = ii;
    end
end

% Specify an external processing event.
Process(1).classname = 'External';
Process(1).method = 'continueScan2d';
Process(1).Parameters = {'srcbuffer','receive',... % name of buffer to process.
'srcbufnum',1,...
'srcframenum',-1,...
'dstbuffer','none'};

Process(2).classname = 'External';
Process(2).method = 'show1dScan';
Process(2).Parameters = {'srcbuffer','receive',... % name of buffer to process.
'srcbufnum',1,...
'srcframenum',0,...
'dstbuffer','none'};

Process(3).classname = 'External';
Process(3).method = 'startScan';
Process(3).Parameters = {'srcbuffer','receive',... % name of buffer to process.
'srcbufnum',1,...
'srcframenum',1,...
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

for ii = 1:nFrames
    for jj = 1:NA
        idx = (ii-1)*NA+jj;
        Event(n) = firstEvent;
        Event(n).rcv = idx;
        Event(n).seqControl = [1,nsc];
         SeqControl(nsc).command = 'transferToHost';
           nsc = nsc + 1;
        n = n+1;
    end
    if ii < nFrames
        Event(n).info = 'Sync before moving';
        Event(n).tx = 0; 
        Event(n).rcv = 0;
        Event(n).recon = 0;
        Event(n).process = 0;
        Event(n).seqControl = nsc; 
            SeqControl(nsc).command = 'sync';
            nsc = nsc+1;
        n = n+1;
        
        Event(n).info = 'Move Positioner.';
        Event(n).tx = 0; 
        Event(n).rcv = 0;
        Event(n).recon = 0;
        Event(n).process = 1;
        % Need to sync or the verasonics system will acquire data faster 
        % than the positioner moves
        Event(n).seqControl = nsc; 
            SeqControl(nsc).command = 'sync';
            nsc = nsc+1;
        n = n+1;
        
        % Set a delay after moving the positioner.
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
end


Event(n).info = 'Call external Processing function.';
Event(n).tx = 0; % no TX structure.
Event(n).rcv = 0; % no Rcv structure.
Event(n).recon = 0; % no reconstruction.
Event(n).process = 0; % call processing function
Event(n).seqControl = [nsc,nsc+1,nsc+2]; % wait for data to be transferred
    SeqControl(nsc).command = 'waitForTransferComplete';
    SeqControl(nsc).argument = 2;
    nsc = nsc+1;
    SeqControl(nsc).command = 'markTransferProcessed';
    SeqControl(nsc).argument = 2;
    nsc = nsc+1;
    SeqControl(nsc).command = 'sync';
    nsc = nsc+1;
n = n+1;

% Save all the structures to a .mat file.
svName = 'C:\Users\Verasonics\Documents\MATLAB\TransmitReceive\MatFiles\TxRx2DScanAveraging';
save(svName);

filename = svName;
VSX
return