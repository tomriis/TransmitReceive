function extern_get_soniq_waveform(RData)
    Resource = evalin('base','Resource');
    lib = Resource.Parameters.soniqLib;
    save_location = Resource.Parameters.filename;
    current_index = Resource.Parameters.current_index;

    filename_snq = [save_location,num2str(current_index),'.snq'];
    filename_mat = [save_location,num2str(current_index),'.mat'];


    calllib(lib,'SetWaveformAutoscale',1);
    calllib(lib,'DigitizeWaveform');

    calllib(lib,'SaveFileAs',filename_snq);

    [t,wv] = readWaveform(filename_snq);

    save(filename_mat,'t','wv');

    Resource.Parameters.current_index = current_index +1;

    assignin('base','Resource',Resource);
    
return