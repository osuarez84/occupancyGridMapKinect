% TEST Programa main
close all; clc;

%% Activamos comunicacion serie
s = serial('COM3');
s.ReadAsyncMode = 'manual';
fopen(s);


%% Configuramos el mapa
map = ones(4000,4000)*0.5;
[m, n] = size(map);
probMap = ones(4000,4000)*0.5;
probMapAux = probMap;

init_coor = [2000; 2000];
init_orientation = deg2rad(0);

%% Parámetros del Kinect
theta = deg2rad(60);    % apertura del sensor
rMax = 2000;    % en mm
epsilon = 50;
kd = 3;

% Configuración de Kinect
k = imaqhwinfo('kinect');

colorVid = videoinput('kinect',1,'RGB_640x480');
depthVid = videoinput('kinect',2,'Depth_640x480');

colorVid.FramesPerTrigger = 1;
depthVid.FramesPerTrigger = 1;

triggerconfig([colorVid depthVid], 'manual');



%%
X = 1:n;
Y = 1:m;
[X,Y] = meshgrid(X,Y);
%a = figure;
%imshow(probMap);

% Descartamos las primeras 5 lecturas por el COM

for i = 1:5
    h = readCOM(s);
    pause(0.5)
    disp('Connecting Arduino...');
end
disp('Connected!');

while(true)
    h = readCOM(s); % Leemos puerto COM3 para IMU
    n = str2heading(h); % Transformamos string de IMU en orientacion de kinect
    coordinatesObstacles = kinect2Dmap(colorVid, depthVid); % Obtenemos coordenadas X y Z de obstaculos vistos por kinect
    obsDA = computeDistancesKinect(coordinatesObstacles); % Obtenemos distancias y angulos de los obstaculos vistos
    [nMap, Ra] = refreshMap(n, init_coor, X, Y,theta,rMax,map); % Visualizamos mapa y zonas exploradas por kinect segun su heading
    [probMap, probMapAux] = probabilisticMap(Ra, epsilon, kd, probMap, probMapAux, obsDA);
    %imshow(nMap)
    imshow(imresize(probMap,0.25));
    %drawnow
end