function [x1, x2] = getRxWindow(ws_data, wos_data)
    h = figure;
    plot(ws_data);
    hold on;
    plot(wos_data);
    hold off;
    legend;
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