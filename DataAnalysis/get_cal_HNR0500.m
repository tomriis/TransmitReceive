function cal = get_cal_HNR0500(frequency)

Hydrophone.model = 'HNR0500';
Hydrophone.serial = '1546';
Hydrophone.calDate = '18-Aug-2008';
Hydrophone.rightAngleConnector = 'true';
Hydrophone.calibrationFile = 'C:\Users\Tom\Documents\MATLAB\TransmitReceive\DataAnalysis\CalFileHNR05001546.txt';
cal = findCalibration(frequency,Hydrophone.calibrationFile,1);

end