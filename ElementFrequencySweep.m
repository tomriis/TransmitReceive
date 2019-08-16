function ElementFrequencySweep()
    frequencies = [1.14:0.01:1.5];
    
    for i = 1:length(frequencies)
        disp(['_______________ On ',num2str(i),' of ', num2str(length(frequencies))]);
        ProbeSpatialSweep(frequencies(i));
        
    end
end
