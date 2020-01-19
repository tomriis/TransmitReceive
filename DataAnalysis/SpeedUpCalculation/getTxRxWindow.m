function [x1, x2] = getTxRxWindow(xdr_1_data, xdr_2_data, xdr_1_i, xdr_2_i)
    h = figure;
    if isstruct(xdr_2_data)
        for i = 1:length(xdr_2_data)
            plot(xdr_2_data(i).xdr_2(xdr_2_i,:),'black-'); hold on;
        end
    else
        plot(xdr_2_data);  hold on;
    end
    if isstruct(xdr_1_data)
        for i = 1:length(xdr_1_data)
            plot(xdr_1_data(i).xdr_1(xdr_1_i,:)); hold on;
        end
    else
        plot(xdr_2_data);
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