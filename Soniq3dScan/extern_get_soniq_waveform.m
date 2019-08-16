function extern_get_soniq_waveform(RData)
    Resource = evalin('base','Resource');
    Trans = evalin('base','Trans');
    lib = Resource.Parameters.soniqLib;
    save_location = Resource.Parameters.filename;
    current_index = Resource.Parameters.current_index;
    if isfield(Resource.Parameters,'scan_mode')
        if Resource.Parameters.scan_mode
            x = getPosition(Resource.Parameters.soniqLib, Resource.Parameters.Axis(1));
            y = getPosition(Resource.Parameters.soniqLib, Resource.Parameters.Axis(2));
            z = getPosition(Resource.Parameters.soniqLib, Resource.Parameters.Axis(3));
            name = [save_location,num2str(current_index),'_',num2str(x),...,
                                '_',num2str(y),'_',num2str(z),'_',num2str(Trans.frequency)];
        end
    else
        stim_freq = Resource.Parameters.stim_freq;
        DC = Resource.Parameters.duty_cycle;
        dur = Resource.Parameters.duration;
        prf = Resource.Parameters.prf;
        v = Resource.Parameters.v_amplitude;
        name = [save_location,num2str(current_index),'_', num2str(stim_freq),...
            '_',num2str(DC),'_',num2str(dur),'_',num2str(prf),'_',num2str(v)];
    end
    
    filename_snq = [name,'.snq'];
    filename_mat = [name,'.mat'];

    calllib(lib,'SetWaveformAutoscale',1);
    calllib(lib,'DigitizeWaveform');
    calllib(lib,'SaveFileAs',filename_snq);

    [t,wv] = readWaveform(filename_snq);

    save(filename_mat,'t','wv');
    delete(filename_snq)
    Resource.Parameters.current_index = current_index + 1;

    assignin('base','Resource',Resource);
    
return