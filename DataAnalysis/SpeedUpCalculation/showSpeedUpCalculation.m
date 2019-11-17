function showSpeedUpCalculation(data, c_data)
    h = figure;
    m_plot = 3;
    n_plot = 1;
    p = 1;
    
    c_control_data = evalin('base', 'c_control_data');
    subplot(m_plot, n_plot, p);
    plot(c_control_data(1).xdr_2(1,:)); hold on; plot(data.xdr_2(1,:));
    p=p+1;
   
    subplot(m_plot, n_plot, p);
    plot(data.wos_data,'b-','DisplayName','Without'); hold on; plot(data.ws_data,'r-','DisplayName','With');
    title([num2str(data.dt(1)),' us'])
    legend;
    p = p+1;
    
    subplot(m_plot, n_plot, p);
    plot(data.wos_data,'b-'); hold on; plot(circshift(data.ws_data,data.di(1)),'r-');
    title([num2str(data.di(1)),' samples'])

end