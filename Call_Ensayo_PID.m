src = fullfile(pwd, 'src');
addpath(src);
src = fullfile(pwd, 'lib');
addpath(src);
clear src

Kp = 2
S1 = 5
S2 = 3.5

P = -Kp * (S1 + S2)
I = (S1 + S2) / (S1 * S2)
D = 1 / (S1 + S2)

[Tiempo, Ref, Control, Lectura, Ctrl] = Ensayo_PID(1, 5, P, I, D);
hold on
plot(Tiempo, Ref)
plot(Tiempo, Lectura)
plot(Tiempo, -Control)
plot(Tiempo, Ref + Ref*0.043)
plot(Tiempo, Ref - Ref*0.043)
legend('Ref', 'Lectura', 'Control','Lim sup sobreOsc','Lim inf sobreOsc')


