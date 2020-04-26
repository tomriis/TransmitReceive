function [J] = cost_function_speed_up(dx, v_ws, v_wos)
    u = mean(v_ws);
    v_ws = circshift(v_ws, dx);
    if dx > 1
        v_ws(1:dx) = u;
    else
        v_ws(end-dx:end) = u;
    end
    J = sum(sqrt((v_ws-v_wos).^2));
end