src = fullfile(pwd, 'src');
addpath(src);
src = fullfile(pwd, 'lib');
addpath(src);
clear src

[Tiempo, Ref, Control, Lectura, Nom_doc] = Datos_Ensayo(1);
Mostrar_Ensayo(1);
p1 = [2.61303 -2.5901];

p0 = [2.23232 -2.5901];
p2 = [3.39392 -6.76969];
p3 = [3.55396 -8.42683];

du = 2;

mt = (p3(2)-p2(2)) / (p3(1)-p2(1));
bt = p2(2) - (mt * p2(1));
t1 = (p0(2) - bt) / mt;

K = m / du;

s = tf('s');

G2 = -5.177/(2.99*s^2 + s)