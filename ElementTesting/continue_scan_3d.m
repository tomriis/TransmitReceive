function continue_scan_3d(RData)

    Resource = evalin('base','Resource');

    % Make sure relevant fields are present
    if ~isfield(Resource.Parameters,'soniqLib')
        error('You must provide a MATLAB alias to the Soniq library in Resource.Parameters.soniqLib')
    end
    if ~isfield(Resource.Parameters,'Axis')
        error('You must provide the scan axis in Resource.Parameters.Axis')
    end
    if ~isfield(Resource.Parameters,'positions')
        error('You must provide grid locations in Resource.Parameters.positions')
    end

    positions = Resource.Parameters.positions;
    next_pos = Resource.Parameters.position_index + 1;

    % Move to the next position
    axis = Resource.Parameters.Axis;
    soniqLib = Resource.Parameters.soniqLib;

    movePositionerAbs(soniqLib, axis(1), positions(next_pos, 1));
    movePositionerAbs(soniqLib, axis(2), positions(next_pos, 2));
    movePositionerAbs(soniqLib, axis(3), positions(next_pos, 3));

    Resource.Parameters.position_index = next_pos;
    assignin('base','Resource',Resource);
    % pause(Resource.Parameters.positionerDelay/1e3);
    % 
    % [wv,t] = getSoniqWaveform(soniqLib,[Resource.Parameters.fileLocation,'wv_',...
    %     num2str(axis(1)),'_',num2str(locs1(curIdx+1)),'_',num2str(axis(2)),'_',num2str(locs2(curIdx+1)),'.snq']);
    % figure(100)
    % plot(t*1e3,wv*1e3,'linewidth',2);
    % ylabel('voltage (mV)')
    % xlabel('time (ms)');
    return