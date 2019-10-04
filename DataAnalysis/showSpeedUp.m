function [speed_up]=showSpeedUp(data, ws_rx_data, wos_rx_data, fs)
         h = figure;
        t = (1:length(ws_rx_data))*1/fs*1e6;
        plot(ws_rx_data);
        hold on;
        plot(wos_rx_data);
        hold off;
        legend;
        title('Create search area and press any key to continue');
        xlabel('Sample Number');
        rect = drawrectangle();
        while true
            w = waitforbuttonpress;
            if w==1
                break;
            end
        end
        positions = rect.Position;
        close(h);
        x1 = fix(positions(1)); x2 = fix(positions(1)+positions(3));
        speed_up = zeros(2,length(data));
        for k = 1:length(data)
            ws_rx_data = data(k).rx;
            ws_rx = ws_rx_data(x1:x2);
            wos_rx = wos_rx_data(x1:x2);
            %t = t(x1:x2);
            [ws_rx,wos_rx] = scale_with_to_without_skull(ws_rx, wos_rx);
            % remove DC offset
            ws_rx = ws_rx-mean(ws_rx);
            wos_rx = wos_rx-mean(wos_rx);

            % Calculate RMSE cost function over overlap range

            cost = zeros([2,length(ws_rx)]);
            for i = 1:length(ws_rx)
                cost(:,i) = cost_function(i,ws_rx, wos_rx);
            end
            %figure; plot(cost./max(cost));
            [~,i] = min(cost(1,:));
            [~, ir] = max(cost(2,:));
            u_ws = mean(ws_rx);
            new_ws_rx_data = circshift(ws_rx, i);
            new_ws_rx_data(1:i) = u_ws;

            d_t_i = i*1/fs*1e6;
            d_t_r = ir*1/fs*1e6;
            speed_up(:,k) = [d_t_i,d_t_r];
        end
        
%         h = figure; 
%         plot(t,new_ws_rx_data,'DisplayName', 'Skull'); hold on; plot(t, wos_rx,'DisplayName','No Skull');
%         xlabel('time (us)');
%         set(gca,'ytick',[]);
%         legend;
%         makeFigureBig(h);
%         h = figure;
%         plot(t, abs(hilbert(new_ws_rx_data)),'DisplayName', 'Skull'); hold on; plot(t, abs(hilbert(wos_rx)), 'DisplayName','No Skull');
%         xlabel('time (us)');
%         set(gca,'ytick',[]);
%         legend
%         makeFigureBig(h);
        
end

function [J,r] = cost_function(dx, v_ws, v_wos)
    u = mean(v_ws);
    v_ws = circshift(v_ws, dx);
    if dx > 1
        v_ws(1:dx) = u;
    else
        v_ws(end-dx:end) = u;
    end
    J = sum(sqrt((v_ws-v_wos).^2));
    r = xcorr(v_ws,v_wos);
end
        
        