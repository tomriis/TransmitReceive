function [c_data] = loadMetaData(c_data, filename)
    S = load(filename);
    fieldnames = fields(S.meta_data);
    for i = 1:length(c_data)
        for j = 1:length(fieldnames)
            c_data(i).(fieldnames{j}) = S.meta_data(i).(fieldnames{j});
        end
    end
end