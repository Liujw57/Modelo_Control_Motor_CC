src = fullfile(pwd, 'src');
addpath(src);
src = fullfile(pwd, 'lib');
addpath(src);
clear src

s = tf('s');
Mot_V = 0.7293/(0.771*s + 1)
Mot_P = 6.827/(s^2 + 0.6646*s -1.042)

rltool(Mot_P)


