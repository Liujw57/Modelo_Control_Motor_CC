src = fullfile(pwd, 'src');
addpath(src);
src = fullfile(pwd, 'lib');
addpath(src);
clear src

Mostrar_Ensayo();

% S = stepinfo(Lectura{1}, Tiempo{1}, "SettlingTimeThreshold", 0.02);
% S_mean = (S.SettlingMax + S.SettlingMin) /2;
% S_corte = 0.05

% hold on
% plot(Tiempo{1}, Lectura{1})
% plot(Tiempo{1}, [(S_mean + (S.SettlingMin-S_mean)*S_corte).*ones(1, numel(Tiempo{1}))])
% plot(Tiempo{1}, [(S_mean + (S.SettlingMax-S_mean)*S_corte).*ones(1, numel(Tiempo{1}))])
% xline(S.SettlingTime)
% legend('Lectura','Límite inferior', 'Límite superior')
% xlabel('Tiempo')
% ylabel('Respuesta')
% grid on
% hold off

% ref = polyfit(Tiempo{1}, Lectura{1}, 5)
% ref_l = polyval(ref, Tiempo{1})

% Lectura_s = smoothdata(Lectura{1})
% Lectura2 = [0 diff(Lectura_s)];

% hold on
% plot(Tiempo{1}, Lectura{1}, '--', 'Color', [0.5 0.5 0.5])
% plot(Tiempo{1}, Lectura_s)
% plot(Tiempo{1}, Lectura2)
% 
% range = max(Lectura2)/50;
% i = 1;
% while i <= numel(Lectura2)
%     if abs(Lectura2(i)) <= range
%         plot(Tiempo{1}(i), Lectura2(i), "*r")
%         plot(Tiempo{1}(i), Lectura_s(i), "*r")
%         i = i + 10;
%     else
%         i = i + 1
%     end
% end
% hold off