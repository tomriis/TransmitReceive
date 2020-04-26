function [c_data, data_dt] = speedUpCalculation(c_data, c_control_data, varargin)
        p = inputParser;
        addOptional(p,'x1',0);
        addOptional(p,'x2',0);
        parse(p, varargin{:})
        if p.Results.x1 == 0
            [x1, x2] = getTxRxWindow(c_data, c_control_data,3,1);
        else
            x1 = p.Results.x1;
            x2 = p.Results.x2;
        end
        
        for i = 1:length(c_data)
            for j = 1:c_data(1).TxEvents/2
       
                wos_data =  c_control_data(i).xdr_2(j,x1:x2);
                ws_data = c_data(i).xdr_2(j, x1:x2);
            
                [c_data] = calculateSpeedUp(ws_data, wos_data, c_data, i, j);
                
                wos_data = c_control_data(i).xdr_1(j+c_data(1).TxEvents/2,x1:x2);
                ws_data = c_data(i).xdr_1(j+c_data(1).TxEvents/2,x1:x2);
                
                [c_data] = calculateSpeedUp(ws_data, wos_data, c_data,i, j+c_data(1).TxEvents/2);
                c_data(i).corr_window = [x1,x2];
            end
        end
        data_dt = zeros(length(c_data),1);
        for i = 1:length(c_data)
            data_dt(i,:) = c_data(i).di(2);
        end
        figure; histogram(data_dt)

end

function [c_data] = calculateSpeedUp(ws_data, wos_data, c_data,c_data_i, count)
%     [ws_data, wos_data] = scale_with_to_without_skull(ws_data,wos_data);
    [~, max_wos_i] = max(wos_data);
    [~, max_ws_i] = max(ws_data);
    
    ws_data_hilbert = abs(hilbert(ws_data));
    wos_data_hilbert = abs(hilbert(wos_data));
    [c, lags] = xcorr(wos_data_hilbert, ws_data_hilbert);
%     c = c(lags >=0);
%     lags = lags(lags >=0);

    [pks, locs] = findpeaks(c);
    if ~isempty(locs)
        [~, c_peak_i] = max(pks); 
        max_i = lags(locs(c_peak_i));
    else
        [~, max_wos_i] = max(wos_data_hilbert);
        [~, max_ws_i] = max(ws_data_hilbert);
        [~,max_i] = max(c);
        
    end
    
    c_data(c_data_i).di(count) = max_i;
    c_data(c_data_i).ws_data(count,:) = ws_data;
    c_data(c_data_i).wos_data(count,:) = wos_data;
    c_data(c_data_i).corr2{count} = c;
end