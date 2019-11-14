function [x1, x2] = getRxWindow(ws_data, wos_data)
    h = figure;
    if isstruct(ws_data)
        for i = 1:length(ws_data)
            plot(ws_data(i).xdr_2(1,:)); hold on;
        end
    else
        plot(ws_data);  hold on;
    end
    if isstruct(wos_data)
        for i = 1:length(wos_data)
            plot(wos_data(i).xdr_2(1,:),'black-'); hold on;
        end
    else
        plot(wos_data);
    end
    hold off;
    title('Create search area and press any key to continue');
    xlabel('Sample Number');
    rect = drawrectangle();
    while true
        w = waitforbuttonpress;
        if w==1
            break;
        end
    end
    positions = rect.Position;
    close(h);
    x1 = fix(positions(1)); x2 = fix(positions(1)+positions(3));
end