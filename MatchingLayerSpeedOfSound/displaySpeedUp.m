% diAll = [1,1,43, 45;
%     1, 2, 43, 43;
%     1, 3, 43, 43;
%     1, 4, 42, 44;
%     2, 1, 41, -1;
%     2, 2, 40, -1;
%     2, 3, 40, 40;
%     2, 4, 40, 42];

 d = 0.00955; cw = 1487.6;
baseName = 'Tx10Data_';
index = [1,21,41,61];
diAll = zeros(4,14);
for i = 1:14    
    for ind = 1:4
        if ind <= 2
            load('ControlData.mat');
            control = rx_data(index(ind),:);
            load([baseName,num2str(i),'.mat']);
            ml = rx_data(index(ind),:);
            
        else
            load('ControlData.mat');
            control = tx_data(index(ind),:);
            load([baseName,num2str(i),'.mat']);
            ml = tx_data(index(ind),:);
        end
        x_cut = 948;
        ml(1:x_cut) = 0;
        control(1:x_cut) = 0;
        [r,lags] = xcorr(control, ml);
        [~,max_i] = max(r);
        diAll(ind, i) = lags(max_i);
    end
end

% uc = mean(diAll(:,3)); stdc = std(diAll(:,3));
% matchI = diAll(:,4)>0;
% up = mean(diAll(matchI,4)); stdp = std(diAll(matchI,4));
% stdcmsp = calcSpeed(uc+stdc, fs, d, cw)-calcSpeed(uc, fs, d, cw);
% stdpmsp = calcSpeed(up+stdp, fs, d, cw)-calcSpeed(up, fs, d, cw);
% 
% speed = (1/(1/cw-dt/d));
% disp(['~ ', num2str(calcSpeed(uc, fs, d, cw)),' +/- ', num2str(stdcmsp)]);
% disp(['~ ', num2str(calcSpeed(up, fs, d, cw)),' +/- ', num2str(stdpmsp)]);

