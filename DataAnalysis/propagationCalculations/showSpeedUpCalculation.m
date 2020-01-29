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
    subplot(m_plot, n_plot, p);
    plot(c_data(c_data_i).ws_data(tx_i,:),'r-','DisplayName','Skull'); hold on; 
    plot(abs(hilbert(c_data(c_data_i).ws_data(tx_i,:))), 'r-'); hold on;
    plot(c_data(c_data_i).wos_data(tx_i,:),'b-','DisplayName','No Skull');
    plot(abs(hilbert(c_data(c_data_i).wos_data(tx_i,:))),'b-');
    legend;
    title('Original Waveforms')
    p=p+1;
   
    subplot(m_plot, n_plot, p);
    corr_data = c_data(c_data_i).corr(tx_i,:);
    di = c_data(c_data_i).di(tx_i);
    plot(corr_data/max(corr_data)); hold on;
    plot(di+1, 1,'r*');
    title('Correlation')
    ylim([0,1.5]);
    p = p+1;
    
    subplot(m_plot, n_plot, p);
    
    plot(c_data(c_data_i).wos_data(tx_i,:),'b-'); hold on; 
    plot(abs(hilbert(c_data(c_data_i).wos_data(tx_i,:))),'b-');
    plot(circshift(c_data(c_data_i).ws_data(tx_i,:), di),'r-');
    plot(abs(hilbert(circshift(c_data(c_data_i).ws_data(tx_i,:),di))),'r-');
    dt = di / c_data(c_data_i).fs * 1e6;
    title(['Delay: ',num2str(dt),' microseconds'])
    makeFigureBig(h);
end