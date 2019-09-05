function positioner_delays = get_positioner_delays(app, positions, rate)
    scale = min(app.scale);
    d_steps = round(diff(positions,1)/scale);
    positioner_delays = sum(abs(d_steps),2)*rate;
end