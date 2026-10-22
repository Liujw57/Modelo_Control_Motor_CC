clear all
cla;
clf;

Nombre_Doc = string({dir(fullfile(pwd, "Ensayos", '*.txt')).name})
N_doc = numel(Nombre_Doc)

for i=1:N_doc
    Doc = fullfile(pwd, "Ensayos", Nombre_Doc(i))
    raw = readmatrix(Doc);
    Tiempo(i) = {raw(:,1)'};
    Ref(i) = {raw(:,2)'};
    Control(i) = {raw(:,3)'};
    Lectura(i) = {raw(:,4)'};
    Nom_doc(i) = Nombre_Doc(i)
end

for i=1:numel(Nom_doc)
    subplot(2,2,i)
    hold on
    plot(Tiempo{i}, Ref{i}, 'r')
    plot(Tiempo{i}, Lectura{i}, 'b')
    title(Nom_doc{i})
    hold off
end
