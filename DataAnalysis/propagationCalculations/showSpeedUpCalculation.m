function showSpeedUpCalculation(c_data, c_data_i, tx_i)
    h = figure;
    m_plot = 3;
    n_plot = 1;
    p = 1;
    if tx_i <= c_data(c_data_i).TxEvents/2
        tx_i = 2;
    else
        tx_i = 4;
    end
    disp(c_data_i);
    ws_data = c_data(c_data_i).ws_data(tx_i,:);
    wos_data = c_data(c_data_i).wos_data(tx_i,:);
    ws_data_hilbert = abs(hilbert(ws_data));
    wos_data_hilbert = abs(hilbert(wos_data));
    
    [ws_data, wos_data, scaler] = scale_with_to_without_skull(ws_data,wos_data);
    subplot(m_plot, n_plot, p);
    plot(ws_data,'r-','DisplayName','Skull'); hold on; 
    plot(abs(hilbert(ws_data)), 'r--','DisplayName','Hilbert Skull'); hold on;
    plot(wos_data,'b-','DisplayName','No Skull');
    plot(abs(hilbert(wos_data)),'b--','DisplayName','Hilbert No Skull');
    legend;
    title(['Original Waveforms: Tx Waveform Scaled ', num2str(scaler), 'x'])
    p=p+1;
   
    subplot(m_plot, n_plot, p);
    [corr_data, lags] = xcorr(wos_data_hilbert, ws_data_hilbert);
    di = c_data(c_data_i).di(tx_i);
    plot(lags,corr_data/max(corr_data)); hold on;
    plot(di, 1,'r*');
    title('Correlation')
    ylim([0,1.5]);
    p = p+1;
    
    subplot(m_plot, n_plot, p);
    
    plot(wos_data,'b-'); hold on; 
    plot(abs(hilbert(wos_data)),'b--');
    plot(circshift(ws_data, di),'r-');
    plot(abs(hilbert(circshift(ws_data, di))),'r--');
    dt = di / c_data(c_data_i).fs * 1e6;
    title(['Delay: ',num2str(dt),' microseconds'])
    makeFigureBig(h);
end