function ElementFrequencySweep()
    frequencies = [0.62:0.02:1.4];
    
    for i = 1:length(frequencies)
        disp(['_______________ On ',num2str(i),' of ', num2str(length(frequencies))]);
        ProbeSpatialSweep(frequencies(i));
        
    end
end
