function ProbeStimParametersSweep()
    scans = {'C:\Users\Verasonics\Documents\VerasonicsScanFiles\stimulation\stim_'};
    pause_time = 3;
%     try
    lib = loadSoniqLibrary();
    openSoniq(lib);
    set_oscope_parameters(lib)
    
    v_amplitude = [50:-5:5];
    duration = [3.6e-6];
    for i = 1:length(v_amplitude)
        for j = 1:length(duration)
            LinearArrayStimulation(lib,'file_name',scans{1},...,
                'v_amplitude', v_amplitude(i),'duration',duration(j));
            pause(pause_time);
        end
    end
%     catch e
%         disp(e.message);
%         exit
%     end

end