function amatrix_cell = quantifyWobble(data,x1,x2)
    %x1 = 653, x2 = 6072
    random_i = randi(length(data),50,1);
    h = figure;
    m_rows = 4;
    n_columns = 1;
    p = 1;
    amatrix=cell(m_rows);
    for n = 1:data(1).TxEvents
        subplot(m_rows,n_columns,p)
        amatrix = [];
        for i = 1:length(random_i)
        ii = random_i(i); 
            for j = 1:1%data(ii).NA
                idx = (n-1)*data(ii).NA+j;
                %amatrix= vertcat(amatrix, data(ii).filt_xdr_1(idx,x1:x2));
                plot(data(ii).filt_xdr_2(idx,x1:x2)); hold on;
            end
        end
        %stdshade(amatrix, 0.5, 'b'); hold on;
        amatrix_cell{n} = amatrix;
        p=p+1;
    end
    makeFigureBig(h);
end
    