function Vcolor = speedUpCalculation3DViz(c_data, V)
    ijk_all = [];
    C = [];
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
                        C = horzcat(C, c_data(c_data_i).di(1));
                    else
                        C = horzcat(C, c_data(c_data_i).di(c_data(1).TxEvents/2+1));
                    end
                end
            end
        end
    end
    C = C/fs * 1e6; 
h = figure;    
scatter3(ijk_all(:,1),ijk_all(:,2),ijk_all(:,3),[],C);
axis equal
title('Through Transmit Time Differences')
hc = colorbar;
caxis([0, max(C)]);
ylabel(hc, 'Delay (us)')
makeFigureBig(h);

Vcolor = zeros(size(V));
for m = 1:length(ijk_all)
    Vcolor(ijk_all(m,1), ijk_all(m,2), ijk_all(m,3)) = C(m);
end