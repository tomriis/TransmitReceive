% verasonics3dScan sets up the nessecary parameters to do a 1 dimensional
% scan on the verasonics system. Inputs are optional - if none are provided
% then the user will be prompted for the relevant parameters. If some are
% provided all must be provided
% 
% @INPUTS
%   axis: a 2 x 1 vector specifying the axes along which to do the scan
%      (0:left/right,1:front/back,2:up/down)
%   sl: a 2 x 1 vector of start locations (in absolute coordinates)
%   el: a 2 x 1 vector of end location (in absolute coordinates)
%   np: a 2 x 1 vector of number of points to scan
% 
% @OUTPUTS
%   lib: MATLAB alias of the opened Soniq DLL
%   axis: axis on which to perform scan
%   LOCS1: matrix of scan locations for the first axis
%   LOCS2: matrix of scan locations for the third axis

function [axis,positions] = verasonics_3d_scan(lib, sl,el,np)
    axis = [1 2 0];
    if nargin ~= 4 && nargin ~= 0
        error('Must provide all four grid parameters or none!')
    end

    % User already supplied input - error check it
    for ii = 1:3
        if ~withinLimits(lib,axis(ii),sl(ii))
            error(['Start location ', num2str(ii), ' is outside of limits!'])
        end
        if ~withinLimits(lib,axis(ii),el(ii))
            error(['End location ', num2str(ii), ' is outside of limits!'])
        end
    end

    %% Set up grid
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