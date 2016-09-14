function [X, Y, Z] = XYKinectCoor(imgDepth)

Z = imgDepth;
[m, n] = size(Z);
[xa, ya] = meshgrid(1:n, 1:m);
M = 0.003501;            %3.501.^-3;

% X
X = (xa - (n/2)) * (320/n) * M .* double(Z);

% Y
Y = (ya - (m/2)) * (240/m) * M .* double(Z);





end