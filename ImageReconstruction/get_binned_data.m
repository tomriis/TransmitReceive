function binned_data = get_binned_data(data_array, n_bins)
    N = length(data_array);
    samples_per_bin = ceil(N/n_bins);
    binned_data = zeros(1,n_bins);
    v_filter = ones(1,samples_per_bin);
    
    w_conv = conv(data_array,v_filter,'same')/samples_per_bin;
    
    binned_data = interp1(1:N,w_conv,1:N/n_bins:N);
end