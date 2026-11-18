src = fullfile(pwd, 'src');
addpath(src);
src = fullfile(pwd, 'lib');
addpath(src);
clear src

[Tiempo, Ref, Control, Lectura, Nom_doc] = Datos_Ensayo(1);

dlectura = [diff(Lectura{1}) 0];
limit = max(abs([max(dlectura) min(dlectura)]));
limitLectura = max(Lectura{1}) - min(Lectura{1});
vuelta = 0;
out = 0;
salida = zeros(length(Lectura{1}));
for i=1:length(dlectura)
    if dlectura(i) >= limit/3 && out == 0
        vuelta = vuelta - 1;
        out = 1;
    elseif dlectura(i) <= -limit/3 && out == 0
        vuelta = vuelta + 1;
        out = 1;
    else
        out = 0;
    end
    salida(i) = Lectura{1}(i) + vuelta*limitLectura + dlectura(i);
end

clf
hold on
plot(Tiempo{1}, Lectura{1})
plot(Tiempo{1}, dlectura)
plot(Tiempo{1}, salida)
yline(limit/3)
yline(-limit/3)
legend("lectura", "DL", "Absoluto", "limit+", "limit-")
hold off

