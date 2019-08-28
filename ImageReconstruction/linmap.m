function vout = linmap(vin,rin, rout)
% function for linear mapping between two ranges
% inputs:
% vin: the input vector you want to map, range [min(vin),max(vin)]
% rout: the range of the resulting vector
% output:
% vout: the resulting vector in range rout
% usage:
% >> v1 = linspace(-2,9,100);
% >> v2 = linmap(v1,[-5,5]);
%
a = rin(1);
b = rin(2);
c = rout(1);
d = rout(2);
vout = ((c+d) + (d-c)*((2*vin - (a+b))/(b-a)))/2;
end