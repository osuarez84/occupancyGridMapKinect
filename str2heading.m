function num = str2heading(str)
% Función para convertir la string recibida por el COM en un dato numérico
% de la orientación

% Eliminamos de los datos espacios en blanco y letras
str = regexprep(str,'[NSEW ]','');
num = str2num(str); % Convertimos string a numero

end
