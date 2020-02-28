
Hydrophone.calibrationFile = 'C:\Users\Verasonics\Desktop\Taylor\Code\aims\Calibrations\HGL0200 - 03-Sep-2019\HGL0200-1782_AG2010-1199-20_xx_20190129.txt';
cal = findCalibration(0.65,Hydrophone.calibrationFile,0);
saveLocation = 'C:\Users\Verasonics\Box Sync\TransducerCharacterizations\HGL0200\0.65MHz\MatchingLayer3DegassedSmallAmp\cone_none\verasonics\';
Files=dir(fullfile(saveLocation,'*.mat'));
v = zeros(1,length(Files));
wv = zeros(1,length(Files));
for i = 1:length(Files)
    Vars = load([saveLocation,Files(i).name]);
    v(i) = Vars.V;
    wv(i) = max(abs(Vars.wv))/cal*1e-6;
end


figure;
plot(v,wv, 'b^');

