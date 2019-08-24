function positioner_delays = get_positioner_delays(app, positions, rate)
    d_steps = floor(diff(positions,1)./app.scale);
    positioner_delays = sum(abs(d_steps),2)*rate;
end