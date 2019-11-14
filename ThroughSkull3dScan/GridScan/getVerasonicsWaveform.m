function getVerasonicsWaveform(RData)
    Resource = evalin('base','Resource');
    Receive = evalin('base','Receive');
    
    position_index = Resource.Parameters.position_index;
    
    data = getTxRxData(RData, Resource, Receive);
    data.positions = Resource.Parameters.positions(position_index,:);
    
    filename = Resource.Parameters.app.output_filename_base;
    filename_mat = [filename, '_',num2str(position_index),'_','.mat'];
    save(filename_mat,'data');
    
return