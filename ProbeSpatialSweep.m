function ProbeSpatialSweep(frequency)
    lib = loadSoniqLibrary();
    openSoniq(lib);
    set_oscope_parameters(lib)
    [axis,positions] = verasonics_3d_scan(lib,[-3,46,6],[-1,46,6],[6,1,1]);
    n_positions = length(positions);
    max_positions_per_scan = 500;
    n_scans = floor(n_positions/max_positions_per_scan);
    
    for i = 1:n_scans
        idx = (i-1)*max_positions_per_scan + 1;
        movePositionerAbs(lib, axis(1), positions(idx, 1));
        movePositionerAbs(lib, axis(2), positions(idx, 2));
        movePositionerAbs(lib, axis(3), positions(idx, 3));
        current_positions = positions(idx:idx+max_positions_per_scan-1,:);
        disp(['On ',num2str(idx),' of ', num2str(n_positions)]);
        VerasonicsHydrophone3DScan(current_positions, lib,'frequency',frequency);
%         robo_press(robot)
    end
    if n_scans == 0
        VerasonicsHydrophone3DScan(positions, lib,'frequency',frequency);
%         robo_press(robot)
    else
    idx = idx+max_positions_per_scan;
    if n_positions-idx > 1
        current_positions = positions(idx:end,:);
        VerasonicsHydrophone3DScan(current_positions, lib,'frequency',frequency);
%         robo_press(robot)
    end
    end
%     catch e
%         disp(e.message);
%         exit
%     end

end

function robo_press(robot)
    pause(3);
    robot.keyPress  (java.awt.event.KeyEvent.VK_Y);
    robot.keyRelease  (java.awt.event.KeyEvent.VK_Y);
    robot.keyPress    (java.awt.event.KeyEvent.VK_ENTER);
    robot.keyRelease  (java.awt.event.KeyEvent.VK_ENTER);
end