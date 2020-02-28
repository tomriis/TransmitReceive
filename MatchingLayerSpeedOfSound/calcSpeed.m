function speed = calcSpeed(di, fs, d, cw)
    speed = (1./(1/cw-(di./fs)/d));
end