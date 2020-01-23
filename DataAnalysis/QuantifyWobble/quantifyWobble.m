function quantifyWobble(data)
    random_i = randi(length(data),1,1);
    h = figure;
    m_rows = 2;
    n_columns = 2;
    p = 1;
        ii = random_i;
        
    for n = 1:data(ii).TxEvents
        subplot(m_rows,n_columns,p)
        for j = 1:data(ii).NA
            idx = (n-1)*data(ii).NA+j;
            plot(data(ii).filt_xdr_1(idx,:)); hold on;
        end
        p=p+1;
    end
end
    