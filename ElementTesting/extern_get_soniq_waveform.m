function extern_get_soniq_waveform(RData)
    Resource = evalin('base','Resource');
    lib = Resource.Parameters.soniqLib;
    save_location = Resource.Parameters.filename;
    current_index = Resource.Parameters.current_index;
    
    curPos1 = getPosition(Resource.Parameters.soniqLib, Resource.Parameters.Axis(1));
    curPos2 = getPosition(Resource.Parameters.soniqLib, Resource.Parameters.Axis(2));
    name = [save_location,num2str(current_index),'_',num2str(curPos1),'_',num2str(curPos2)];
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