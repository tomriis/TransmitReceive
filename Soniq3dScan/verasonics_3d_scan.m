% @INPUTS
%   lib: loaded verasonics library
%   sl: a 3 x 1 vector of start locations (in absolute coordinates)
%   el: a 3 x 1 vector of end location (in absolute coordinates)
%   np: a 3 x 1 vector of number of points to scan
% 
% @OUTPUTS
%   lib: MATLAB alias of the opened Soniq DLL
%   axis: axis on which to perform scan
%   positions: N x 3 matrix of scan positions 

function [axis,positions] = verasonics_3d_scan(lib, sl,el,np)
    axis = [1 2 0];
    for ii = 1:3
        if ~withinLimits(lib,axis(ii),sl(ii))
            error(['Start location ', num2str(ii), ' is outside of limits!'])
        end
        if ~withinLimits(lib,axis(ii),el(ii))
            error(['End location ', num2str(ii), ' is outside of limits!'])
        end
    end

    locs1 = linspace(sl(1),el(1),np(1));
    locs2 = linspace(sl(2),el(2),np(2));
    locs3 = linspace(sl(3),el(3),np(3));
    
    if isempty(locs1)
        locs1 = sl(1);
    end
    if isempty(locs2)
        locs2=sl(2);
    end
    if isempty(locs3)
        locs3=sl(3);
    end
    [LOCS1,LOCS2,LOCS3] = ndgrid(locs1,locs2,locs3);
    positions = get_positions(LOCS1,LOCS2,LOCS3);
    %% Move to start location
    movePositionerAbs(lib, axis(1), locs1(1));
    movePositionerAbs(lib, axis(2), locs2(1));
    movePositionerAbs(lib, axis(3), locs3(1));