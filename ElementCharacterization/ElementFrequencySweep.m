function ElementFrequencySweep()
    frequencies = [0.5:0.02:1.4];
    
    for i = 1:length(frequencies)
        disp(['_______________ On ',num2str(i),' of ', num2str(length(frequencies))]);
        ProbeSpatialSweep(frequencies(i));
        %verasonics_3d_scan(lib,[-5, 0, 1],[5, 0, 10],[55,1,50]);
    end
end
