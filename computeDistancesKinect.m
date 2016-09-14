function obs = computeDistancesKinect(cO)
% Función que obtiene las distancias en linea recta y los angulos respecto
% a la orientación del kinect de cada uno de los obstaculos detectados.
% INPUT:
%   * cO => matriz con las coordenadas en Z y X de todos los obstaculos
%   detectados por kinect. La columna 1 se corresponde con la coordenada en Z
%   y la columna 2 con la coordenada en el eje X.
Z = cO(:,1);
X = cO(:,2);

dists = sqrt(Z.^2 + X.^2);
angles = atan2(X,Z);

obs = [dists, angles];


end