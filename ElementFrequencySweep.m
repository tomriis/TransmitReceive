function ElementFrequencySweep()
    frequencies = [0.5:0.01:1.5]*1e6;
    for i = 1:length(frequencies)
        VerasonicsHydrophone3DScan(frequencies(i));
        disp(['On ',num2str(i),' of ', num2str(length(frequencies))]);
    end
end
