% Esta función obtiene un mapa 2D de los ejes ZX de Kinect.
function [coordObs]= kinect2Dmap(colorVid, depthVid)

start([colorVid, depthVid]);
trigger([colorVid, depthVid]);

[imgColor, ts_color, metadata_color] = getdata(colorVid);
[imgDepth, ts_depth, metadata_depth] = getdata(depthVid);

% OJO Kinect captura las imágenes en modo mirror, por lo que tenemos que
% devolverlas a su origen.
imgColor = flip(imgColor,2);
imgDepth = flip(imgDepth,2);


% Llamamos a la función de computo de XY
[X, Y, Z] = XYKinectCoor(imgDepth);

d = 450; % Distancia del kinect al suelo 
% Seleccionamos los pixeles por encima y por debajo de unos limites
Za = (Y >= -d-300) & (Y <= d-150);
Za = not(Za);
Z(Za) = Inf;
Z(Z==0) = Inf;

% figure;
% imshow(Z, [0 4000]);

% Seleccionamos el elemento a menor distancia de cada columna del array Z
[Z_prime, I] = min(Z);

% Computamos ahora las coordenadas en X para los puntos seleccionados en
% Z como mínimos.
% TODO => X_prime = X(I,:);
for i = 1:size(Z,2)
    X_prime(i) = X(I(i),i);
end

Z_prime = double(Z_prime);
coordObs = [Z_prime; X_prime]';
% Eliminamos ptos fuera del rango de Z y seleccionamos las filas de X
% pertinentes
msk = coordObs(:,1) < 4000;
coordObs = coordObs(msk,:);




% % Ploteamos el mapa 2D
% figure;
% scatter(X_prime, Z_prime,'.');
% axis([-4000 4000 0 40000]);
% title('2D Map from Kinect');
% xlabel('X coordinate (mm)');
% ylabel('Z coordinate (mm)');


end