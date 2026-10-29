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

K = (Yfin - Yini) / (Ufin - Uini)
O = (Ymax - Yfin) / (Yfin - Yini)
E = sqrt((log(O)^2)/(log(O)^2 + pi^2 ))
Wp = (2 * pi) / Tp1p2
Wn = Wp / sqrt(1-E^2)

s = tf('s');

Gs = (K*Wn^2) / (s^2 + 2*E*Wn*s + Wn^2)



T = min(Tiempo{1}):0.02:max(Tiempo{1})-0.02
test = step(5*Gs, T)

n = 100;
test = circshift(test, n)
test(1:n) = 0
figure
hold on
plot(Tiempo{1}, Lectura{1})
plot(T, test)
hold off