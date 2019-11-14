function data_dt = speedUpCalculation(c_data, c_control_data, fs, varargin)
        p = inputParser;
        addOptional(p,'x1',0);
        addOptional(p,'x2',0);
        addOptional(p, 'tx_i',1);
        parse(p, varargin{:})
        if p.Results.x1 == 0
            [x1, x2] = getRxWindow(c_data, c_control_data);
        else
            x1 = p.Results.x1;
            x2 = p.Results.x2;
        end
        
        tx_i = p.Results.tx_i;
        wos_data = c_control_data(1).xdr_2(tx_i, x1:x2);
        for i = 1:length(c_data)
            ws_data = c_data(i).xdr_2(tx_i,x1:x2);
            [ws_data, wos_data] = scale_with_to_without_skull(ws_data,wos_data);
            [c, lags] = xcorr(wos_data, ws_data);
            c = c(lags >=0);
            lags = lags(lags >=0);
            
            [pks, locs] = findpeaks(c);
            if ~isempty(locs)
                [~, c_peak_i] = max(pks); 
                max_i = lags(locs(c_peak_i));
            else
                max_i = 0;
                disp('NO PEAK');
            end
            if max_i < 0
                disp(num2str(i))
            end
            t = max_i*1/fs*1e6; % us
            c_data(i).dt(1) = t;
            c_data(i).di(1) = max_i;
            c_data(i).ws_data = ws_data;
            c_data(i).wos_data = wos_data;
            c_data(i).c = c;
            
%             cost = zeros([1,length(ws_data)]);
%             count = 1;
%             lags2 = -round(length(ws_data)/2):round(length(ws_data)/2);
%             for k = lags2
%                 cost(count) = cost_function_speed_up(k,ws_data, wos_data);
%                 count = count + 1;
%             end
%             [~, rmse_min_i] = min(cost);
%             min_i = lags2(rmse_min_i);
%             c_data(i).di(2) = min_i;
%             c_data(i).dt(2) = min_i*1/fs*1e6;
%             c_data(i).cost = cost;   
        end
        
        % separate into new function
      
        data_dt = zeros(length(c_data),1);
        for i = 1:length(c_data)
            data_dt(i,:) = c_data(i).di(1);
        end
%         inds = abs(data_dt(:,2)) < inf;
%         figure; histogram(data_dt(inds,1)); hold on; histogram(data_dt(inds,2));
        figure; histogram(data_dt)
%         inds = find(data_dt < 0);
%         for i = 1:3
%             k = randi(length(inds));
%             figure; plot(c_data(inds(k)).ws_data,'r'); hold on;
%             %plot(circshift(c_data(inds(k)).ws_data, c_data(inds(k)).di),'DisplayName','With'); hold on;
%             plot(wos_data,'DisplayName', 'Without'); 
%             title(num2str(c_data(inds(k)).di));
%             %figure; plot(lags, c_data(inds(k)).hilbert_c);
%         end         
end