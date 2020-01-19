function save_meta_data(c_data, filename)
fields = {'position','TxEvents','NA','fs','v_xyz','c','L','offset','x1','x2',...
    'echo_i','echo_ijk','masked'};
meta_data = struct();
for i = 1:length(c_data)
    for j = 1:length(fields)
        meta_data(i).(fields{j}) = c_data(i).(fields{j});
    end
end

save(filename, 'meta_data');

end