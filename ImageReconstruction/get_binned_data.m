function binned_data = get_binned_data(data_array, n_bins)
    N = length(data_array);
    samples_per_bin = ceil(N/n_bins);
    binned_data = zeros(1,n_bins);
    for i = 1:n_bins-1
        binned_data(i) = mean(data_array((i-1)*samples_per_bin+1:(i*samples_per_bin)));
    end
    binned_data(n_bins) = mean(data_array(i*samples_per_bin+1:end));
end