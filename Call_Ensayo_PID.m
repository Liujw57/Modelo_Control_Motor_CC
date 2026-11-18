src = fullfile(pwd, 'src');
addpath(src);
src = fullfile(pwd, 'lib');
addpath(src);
clear src

[Tiempo, Ref, Control, Lectura, Ctrl] = Ensayo_PID(2,1, 1, 1, 0);
hold on
plot(Tiempo, Ref)
plot(Tiempo, Lectura)
plot(Tiempo, Control)
legend('Ref', 'Lectura', 'Control')
asfdassadf