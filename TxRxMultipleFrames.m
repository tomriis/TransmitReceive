clear all
%% User defined Scan Parameters
NA = 1;
n_frames = 32;
frame_rate = 500;
prf = 500; % Pulse repitition Frequency in Hz
centerFrequency = 0.5; % Frequency in MHz
num_half_cycles = 6; % Number of half cycles to use in each pulse
desiredDepth = 100; % Desired depth in mm
endDepth = desiredDepth;
Vpp = 96; % Desired peak to peak voltage (TPC.hv)

% Specify system parameters
Resource.Parameters.numTransmit = 1; % no. of transmit channels
Resource.Parameters.numRcvChannels = 30; % change to 64 for Vantage 64 system
Resource.Parameters.connector = 1; % trans. connector to use (V 256).
Resource.Parameters.speedOfSound = 1540; % speed of sound in m/sec
%Resource.Parameters.simulateMode = 1; % runs script in simulate mode

% Specify media points
Media.MP(1,:) = [0,0,100,1.0]; % [x, y, z, reflectivity]

% Specify Trans structure array.
Trans.name = 'Custom';
Trans.frequency = centerFrequency; % Lowest transmit frequency is 0.6345 Pg. 60
Trans.units = 'mm';
Trans.lensCorrection = 1;
%Trans.Bandwidth = [1.5,3]; % Set to 0.6 of center frequency by default
Trans.type = 0;
Trans.numelements = 30;
Trans.elementWidth = 24;
Trans.ElementPos = ones(30,5);
Trans.ElementSens = ones(101,1);
Trans.connType = 1;
Trans.Connector = (1:Trans.numelements)';
Trans.impedance = 50;
Trans.maxHighVoltage = Vpp;


wavelength = Resource.Parameters.speedOfSound/(Trans.frequency*1e6);
% Specify Resource buffers.
Resource.RcvBuffer(1).datatype = 'int16';
Resource.RcvBuffer(1).rowsPerFrame =2048; % Num samples per frame
Resource.RcvBuffer(1).colsPerFrame = 30;
Resource.RcvBuffer(1).numFrames = n_frames; % minimum size is 1 frame.
% Specify Transmit waveform structure.
TW(1).type = 'parametric';
TW(1).Parameters = [Trans.frequency,0.67, num_half_cycles, 1]; % A, B, C, D
TW.equalize = 1; % Default value: equalize = 1  

% Specify TX structure array.
TX(1).waveform = 1; % use 1st TW structure.
TX(1).focus = 0;
TX(1).Apod = zeros([1,30]);
TX(1).Apod(1)=1;


TX(1).Delay = computeTXDelays(TX(1));
% Specify TGC Waveform structure.
TGC(1).CntrlPts = ones(1,8)*100; %[500,590,650,710,770,830,890,950];
TGC(1).rangeMax = endDepth;
TGC(1).Waveform = computeTGCWaveform(TGC);
% Specify Receive structure array -
Apod = zeros([1,30]); % if 64ch Vantage, = [ones(1,64) zeros(1,64)];
Apod([1,30])=1;
% Specify Receive structure array -
Receive = repmat(struct(...
    'Apod', Apod, ... 
    'startDepth', 0, ...
    'endDepth', endDepth, ...
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
Receive(i).framenum = i;
end
% Size of each acquisition segment in samples 
%n = 2*(Receive(1).endDepth-Receive(1).startDepth)*Receive(1).samplesPerWave;
%disp(n);
% Specify an external processing event.
Process(1).classname = 'External';
Process(1).method = 'myExternFunction';
Process(1).Parameters = {'srcbuffer','receive',... % name of buffer to process.
'srcbufnum',1,...
'srcframenum',-1,...
'dstbuffer','none'};



SeqControl(1).command = 'timeToNextAcq';
SeqControl(1).argument = 1/(frame_rate)*1e6; % wait time in microseconds
SeqControl(2).command = 'jump';
SeqControl(2).argument = 1;
nsc = 3; % start index for new SeqControl

n = 1; % start index for Events
for i = 1:Resource.RcvBuffer(1).numFrames
    Event(n).info = 'Acquire RF Data.';
    Event(n).tx = 1; % use 1st TX structure.
    Event(n).rcv = i; % use unique Receive for each frame.
    Event(n).recon = 0; % no reconstruction.
    Event(n).process = 0; % no processing
    Event(n).seqControl = [1,nsc]; % set TTNA time and transfer
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


save('C:\Users\Verasonics\Documents\Matlab\TransmitReceive\MatFiles\TxRxMultipleFrames');
return