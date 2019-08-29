function xyz = arm_position_to_xyz(position, arm_length, xdr_num)
    xdr_sign = [1,-1];
    xyz = zeros(1,3);
    xyz(1) = xdr_sign(xdr_num)*arm_length*cos(deg2rad(position(3)));
    xyz(2) = position(1)+xdr_sign(xdr_num)*arm_length*sin(deg2rad(position(3)));
    xyz(3) = position(2);
end