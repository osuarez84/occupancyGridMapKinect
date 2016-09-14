function heading = readCOM(s)
% Hacemos una lectura asincrona del IMU

readasync(s);
heading = fscanf(s);
%disp(heading);

end