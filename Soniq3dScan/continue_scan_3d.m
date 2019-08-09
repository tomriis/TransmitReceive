function continue_scan_3d(RData)

    Resource = evalin('base','Resource');

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
    axis = Resource.Parameters.Axis;
    soniqLib = Resource.Parameters.soniqLib;
    
    if next_pos > length(positions)
        VsClose;
    else
        movePositionerAbs(soniqLib, axis(1), positions(next_pos, 1));
        movePositionerAbs(soniqLib, axis(2), positions(next_pos, 2));
        movePositionerAbs(soniqLib, axis(3), positions(next_pos, 3));
        disp(['Position ', num2str(next_pos),' of ', num2str(length(positions))]);
    end
    
    Resource.Parameters.position_index = next_pos;
    assignin('base','Resource',Resource);
return