function extern_get_soniq_waveform(RData)
    Resource = evalin('base','Resource');
    lib = Resource.Parameters.soniqLib;
    save_location = Resource.Parameters.filename;
    current_index = Resource.Parameters.current_index;
    
    x = getPosition(Resource.Parameters.soniqLib, Resource.Parameters.Axis(1));
    y = getPosition(Resource.Parameters.soniqLib, Resource.Parameters.Axis(2));
    z = getPosition(Resource.Parameters.soniqLib, Resource.Parameters.Axis(3));
    
    name = [save_location,num2str(current_index),'_',num2str(x),'_',num2str(y),'_',num2str(z)];
    filename_snq = [name,'.snq'];
    
    filename_mat = [name,'.mat'];


    calllib(lib,'SetWaveformAutoscale',1);
    calllib(lib,'DigitizeWaveform');

    calllib(lib,'SaveFileAs',filename_snq);

    [t,wv] = readWaveform(filename_snq);

    save(filename_mat,'t','wv');

    Resource.Parameters.current_index = current_index +1;

    assignin('base','Resource',Resource);
    
return