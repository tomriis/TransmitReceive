function [Vcolor, cAttenuation] = speedUpCalculation3DViz(c_data, V)
    ijk_all = [];
    C = [];
    cAttenuation = [];
    fs = c_data(1).fs;
    for k = 1:size(V,3)
        plane = squeeze(V(:,:,k));
        idx = find(plane>0);
        [ii, jj] = ind2sub(size(plane), idx);
        if ~isempty(idx)
            for m = 1:length(ii)
                ijk = [ii(m), jj(m), k];
                [~,c_data_i, tx_i] = findDataFromIdx(c_data, ijk);
                if c_data(c_data_i).masked(tx_i) == 0
                    ijk_all = vertcat(ijk_all, ijk);
                    if tx_i <= c_data(1).TxEvents
                        C = horzcat(C, c_data(c_data_i).di(2));
                        cAttenuation = horzcat(cAttenuation, c_data(c_data_i).echoAmp(1));
                    else
                        C = horzcat(C, c_data(c_data_i).di(c_data(1).TxEvents/2+2));
                        cAttenuation = horzcat(cAttenuation, c_data(c_data_i).echoAmp(c_data(1).TxEvents/2+1));
                    end
                end
            end
        end
    end
    
    C = C/fs * 1e6;
 cAttenuation = cAttenuation/max(cAttenuation);
    
for i = 1:length(C)
    if C(i) > 5
        C(i)=5;
        disp(i)
    end
    if cAttenuation(i)>0.55
        cAttenuation(i) = 0.55;
    end
end
cAttenuation = 1*(cAttenuation);% + 0.55;
h = figure;    
scatter3(ijk_all(:,1),ijk_all(:,2),ijk_all(:,3),[],C);
axis equal
title('Through Transmit Time Differences')
hc = colorbar;
%caxis([0, max(C)]);
ylabel(hc, 'Delay (us)')
makeFigureBig(h);
axis equal
Vcolor = zeros(size(V));
for m = 1:length(ijk_all)
    Vcolor(ijk_all(m,1), ijk_all(m,2), ijk_all(m,3)) = C(m);
end

h2 = figure;

scatter3(ijk_all(:,1),ijk_all(:,2),ijk_all(:,3),[],cAttenuation);
title('Echo Attenuation')
hc = colorbar;
%caxis([0.4, 1]);
ylabel(hc, 'Relative Amplitude')
makeFigureBig(h2);
axis equal