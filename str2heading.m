function num = str2heading(str)
% Funci�n para convertir la string recibida por el COM en un dato num�rico
% de la orientaci�n

% Eliminamos de los datos espacios en blanco y letras
str = regexprep(str,'[NSEW ]','');
num = str2num(str); % Convertimos string a numero

end
