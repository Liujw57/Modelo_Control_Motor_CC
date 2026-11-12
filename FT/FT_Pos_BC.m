src = fullfile(pwd, 'src');
addpath(src);
src = fullfile(pwd, 'lib');
addpath(src);
clear src

[Tiempo, Ref, Control, Lectura, Nom_doc] = Datos_Ensayo(2);
%Para ensayo 2: visualmente
Uini = 0 ;Ufin =5;
Yini = -0.4262; Yfin = 5.1423; Ymax = 9.0808;
Tp1p2 = 5.1615-3.0772; Te = 12.2503-2.1361;

K = (Yfin - Yini) / (Ufin - Uini);
O = (Ymax - Yfin) / (Yfin - Yini);
E = sqrt((log(O)^2)/(log(O)^2 + pi^2 ));
Wp = (2 * pi) / Tp1p2;
Wn = Wp / sqrt(1-E^2);

s = tf('s');

Gs = (K*Wn^2) / (s^2 + 2*E*Wn*s + Wn^2)

T = min(Tiempo{1}):0.02:max(Tiempo{1})-0.02;
test = step(5*Gs, T);

n = 100;
test = circshift(test, n);
test(1:n) = 0;

Kc = 1.5;
Gs_mod = 10.24/(s^2 + 0.6646*s + 9.198);
Kp = 10.24 / Kc;
ap = 1;
bp = 0.6646;
cp = 9.198 - (Kc * Kp);

Gm = Kp / (ap*s^2 + bp*s + cp)
Gs2 = (Kc*Gm) / (1 + (Kc*Gm))

test2 = step(5*Gs2, T);
n = 100;
test2 = circshift(test2, n);
test2(1:n) = 0;

test3 = step(5*Gm, T);
n = 100;
test3 = circshift(test2, n);
test3(1:n) = 0;

hold on
plot(Tiempo{1}, Lectura{1})
plot(T, test)
plot(T, test2)
plot(T, test3)
legend("Lectura", "Modelo1", "Modelo2", "Modelo3")
hold off

