src = fullfile(pwd, 'src');
addpath(src);
src2 = fullfile(pwd, 'lib');
addpath(src2);

clear all
cla
clf

Resultado = Ensayos(2);

% DA_NIDAQ_USB(0);

Tiempo = Resultado(:,1);
Ref = Resultado(:,2);
Control = Resultado(:,3);
Lectura = Resultado(:,4);

hold on
plot(Tiempo, Ref)
plot(Tiempo, Lectura)
hold off