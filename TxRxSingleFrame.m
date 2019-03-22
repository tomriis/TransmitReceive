clear all
% Specify system parameters
Resource.Parameters.numTransmit = 1; % no. of transmit channels
Resource.Parameters.numRcvChannels = 30; % change to 64 for Vantage 64 system
Resource.Parameters.connector = 1; % trans. connector to use (V 256).
Resource.Parameters.speedOfSound = 1540; % speed of sound in m/sec
Resource.Parameters.simulateMode = 1; % runs script in simulate mode

% Specify media points
Media.MP(1,:) = [0,0,100,1.0]; % [x, y, z, reflectivity]

% Specify Trans structure array.
Trans.name = 'Custom';
Trans.frequency = 0.5; % Lowest transmit frequency is 0.6345 Pg. 60
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
Trans.maxHighVoltage = 20;


wavelength = Resource.Parameters.speedOfSound/(Trans.frequency*1e6);
% Specify Resource buffers.
Resource.RcvBuffer(1).datatype = 'int16';
Resource.RcvBuffer(1).rowsPerFrame =2048; % Num samples per frame
Resource.RcvBuffer(1).colsPerFrame = 30;
Resource.RcvBuffer(1).numFrames = 1; % minimum size is 1 frame.
% Specify Transmit waveform structure.
TW(1).type = 'parametric';
TW(1).Parameters = [Trans.frequency,0.67,2,1]; % A, B, C, D
TW.equalize = 1; % Default value: equalize = 1  

% Specify TX structure array.
TX(1).waveform = 1; % use 1st TW structure.
TX(1).focus = 0;
TX(1).Apod = zeros([1,30]);
TX(1).Apod(1)=1;

endDepth = 200;
TX(1).Delay = computeTXDelays(TX(1));
% Specify TGC Waveform structure.
TGC(1).CntrlPts = ones(1,8)*950; %[500,590,650,710,770,830,890,950];
TGC(1).rangeMax = endDepth;
TGC(1).Waveform = computeTGCWaveform(TGC);
% Specify Receive structure array -
Receive(1).Apod = zeros([1,30]); % if 64ch Vantage, = [ones(1,64) zeros(1,64)];
Receive(1).Apod([1,30])=1;
Receive(1).startDepth = 0;
Receive(1).endDepth = endDepth;
Receive(1).TGC = 1; % Use the first TGC waveform defined above
Receive(1).mode = 0;
Receive(1).bufnum = 1;
Receive(1).framenum = 1;
Receive(1).acqNum = 1;
Receive(1).sampleMode = 'NS200BW';
Receive(1).LowPassCoef = [];
Receive(1).InputFilter = [];
% Size of each acquisition segment in samples 
%n = 2*(Receive(1).endDepth-Receive(1).startDepth)*Receive(1).samplesPerWave;
%disp(n);
% Specify an external processing event.
Process(1).classname = 'External';
Process(1).method = 'myExternFunction';
Process(1).Parameters = {'srcbuffer','receive',... % name of buffer to process.
'srcbufnum',1,...
'srcframenum',1,...
'dstbuffer','none'};

% Specify sequence events.
Event(1).info = 'Acquire RF Data.';
Event(1).tx = 1; % use 1st TX structure.
Event(1).rcv = 1; % use 1st Rcv structure.
Event(1).recon = 0; % no reconstruction.
Event(1).process = 0; % no processing
Event(1).seqControl = [1,2];
SeqControl(1).command = 'timeToNextAcq';
SeqControl(1).argument = 120000; %50 ms
SeqControl(2).command = 'transferToHost';

Event(2).info = 'Call external Processing function.';
Event(2).tx = 0; % no TX structure.
Event(2).rcv = 0; % no Rcv structure.
Event(2).recon = 0; % no reconstruction.
Event(2).process = 1; % call processing function
Event(2).seqControl = [3,4,5]; % wait for data to be transferred
SeqControl(3).command = 'waitForTransferComplete';
SeqControl(3).argument = 2;
SeqControl(4).command = 'markTransferProcessed';
SeqControl(4).argument = 2;
SeqControl(5).command = 'sync';

Event(3).info = 'Jump back to Event 1.';
Event(3).tx = 0; % no TX structure.
Event(3).rcv = 0; % no Rcv structure.
Event(3).recon = 0; % no reconstruction.
Event(3).process = 0; % no processing
Event(3).seqControl = 6; % jump back to Event 1
SeqControl(6).command = 'jump';
SeqControl(6).argument = 1;

save('C:\Users\Verasonics\Documents\Matlab\TransmitReceive\MatFiles\TxRxSingleFrame');
return


