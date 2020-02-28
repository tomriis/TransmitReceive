baseDir = 'C:\Users\Verasonics\Box Sync\TransducerCharacterizations\HGL0200\0.65MHz\';

samples = {'SmallAmpFlatFaceEpotek301',...
            'SmallAmpFlatFaceESolder',...
            'SmallAmpMatchingLayer2',...
            'SmallAmpNoMatching',...
           };
        
names = {'FlatFaceEpotek301', 'FlatFaceESolder', 'MatchingLayer2','NoMatching'};
Tx.frequency = 0.65;        
Hydrophone.calibrationFile = 'C:\Users\Verasonics\Desktop\Taylor\Code\aims\Calibrations\HGL0200 - 03-Sep-2019\HGL0200-1782_AG2010-1199-20_xx_20190129.txt';
cal = findCalibration(Tx.frequency,Hydrophone.calibrationFile,0);

fileBase = 'wv_';
FgParams.nCycles = 8; % Over 4 cycles incurs a different PNP calculation
for i = 1:length(samples)
    folder = [baseDir,samples{i},'\cone_none\efficiencyCurve\'];
    
    [vpp,vIn] = readEfficiencyData(folder,fileBase,FgParams);
    if i == 1
        %Grid.wvPosition = position;
        figure;
        ax = gca;
        colorOrder = ax.ColorOrder;

        h = figure(103);
        clf
        %set(h,'defaultAxesColorOrder',[colorOrder(1,:); colorOrder(1,:)]);
    end
    yyaxis('left')
    plot(vIn,vpp/cal*1e-6,'^','linewidth',3,'markersize',8,'Color',colorOrder(i,:),'DisplayName',names{i}); hold on;
    ax1 = gca;
    ylim1 = get(ax1,'ylim');
    ylabel('Measured PNP (Mpa)','FontSize',18)

%     yyaxis('right')
%     plot(vIn,vpp*1e3,'^','linewidth',3,'markersize',8)
%     ylim(ylim1*cal*1e9);


end
    
    
legend;
xlabel('Input Voltage (mVpp)','FontSize',18)
ylabel('Measured PNV (mV)','FontSize',18,'color',colorOrder(1,:))
title('Efficiency','FontSize',18)
makeFigureBig(h);
axT = gca;
% set(axT,'fontcolor',colorOrder(1,:));
axis('tight')
grid on