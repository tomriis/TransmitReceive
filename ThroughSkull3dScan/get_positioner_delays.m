function positioner_delays = get_positioner_delays(app, positions, rate)
    scale = [0.025, 0.025, 0.04];%min(app.scale);
    disp(positions)
    d_steps = round(diff(positions,1)./scale);
    positioner_delays = sum(abs(d_steps),2)*rate;
end