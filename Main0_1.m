src = fullfile(pwd, 'src');
addpath(src);
src = fullfile(pwd, 'lib');
addpath(src);
clear src

[Tiempo, Ref, Control, Lectura, Nom_doc] = Datos_Ensayo(2);
Mostrar_Ensayo(2);