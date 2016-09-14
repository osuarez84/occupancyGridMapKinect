function [nMap, Ra] = refreshMap(h,p,X,Y,theta,rMax,map)
% Recogemos la info de orientación del IMU y calculamos los valores para el
% refresco del mapa. Para ello utilizamos los parametros del Kinect.

orientation = deg2rad(h);
pos = p;

% En este caso debemos de sumar la orientación para que el giro del IMU
% coincida con el del calculado por atan2. El IMU aumenta al girar counter
% clockwise y los angulos calculados por atan2 iban al revés. Al sumarlo se
% invierte el del IMU y coincide el real del IMU y el reflejado en el mapa.
PHI = atan2(X-pos(2,1), Y-pos(1,1)) + orientation;
PHI = atan2(sin(PHI), cos(PHI));
R = sqrt((X - pos(2,1)).^2 + (Y - pos(2,1)).^2);
mask1 = abs(PHI)<theta/2 ;
mask2 = (R < rMax).*mask1;
% En mask2 tenemos todas las rejillas del mapa que están en el rango de
% distancia y angulo del Kinect.


% CREO QUE TENEMOS QUE LLAMAR A LA FUNCION QUE COMPUTA EL NUEVO MAPA DESDE
% AQUI, PARA QUE SE COMPUTEN LAS NUEVAS PROBABILIDADES.
nMap = map.*(1-mask2);
Ra = R.*mask2;


end