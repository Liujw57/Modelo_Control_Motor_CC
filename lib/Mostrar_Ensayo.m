function Mostrar_Ensayo(a)
% Grafíca los documentos de la carpeta Ensayos
% var "a" viene determinado por el orden alfabetico de la carpeta Ensayos
    if nargin < 1 || isempty(a)
        [Tiempo, Ref, Control, Lectura, Nom_doc] = Datos_Ensayo();
    else
        [Tiempo, Ref, Control, Lectura, Nom_doc] = Datos_Ensayo(a);
    end
    
    for i=1:numel(Nom_doc)
        subplot(ceil(numel(Nom_doc)/2),ceil(numel(Nom_doc)/2),i)
        hold on
        plot(Tiempo{i}, Ref{i}, 'r')
        plot(Tiempo{i}, Lectura{i}, 'b')
        plot(Tiempo{i}, Control{i}, '--', 'Color', [0.5 0.5 0.5])
        legend("Valor Objetivo (V)", "Valor Real (V)", "Valor Contol (V)")
        title(Nom_doc{i})
        hold off
    end
end