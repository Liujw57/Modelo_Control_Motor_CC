% Raw = readmatrix("Ejemplo_Ref_Escalon_1213.txt")
% 
% Tiempo = Raw(:,1)'
% Referencia = Raw(:,2)'
% Control = Raw(:,3)'
% Lectura = Raw(:,4)'

d_tmp = gradient(Lectura, Tiempo);
d2_tmp = gradient(d_tmp, Tiempo);

for i=1:length(d_tmp)
    if d_tmp(i) == 0 && d2_tmp ~= 0
    
    
    end
end

subplot(3,2,1)
plot(Tiempo, Referencia)
subplot(3,2,2)
plot(Tiempo, Control)
subplot(3,2,3)
plot(Tiempo, Lectura)
subplot(3,2,4)
plot(Tiempo, d_tmp)
subplot(3,2,5)
plot(Tiempo, d2_tmp)


fminsearch()


