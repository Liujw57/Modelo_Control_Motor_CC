function [Tiempo, Ref, Control, Lectura, Nom_doc] = Datos_Ensayo(a)
% var "a" viene determinado por el orden alfabetico de la carpeta Ensayos
    Nombre_Doc = string({dir(fullfile(pwd, "Ensayos", '*.txt'), SortOrder="natural").name});
    N_doc = numel(Nombre_Doc);

    if nargin < 1 || isempty(a)
        for i=1:N_doc
            Doc = fullfile(pwd, "Ensayos", Nombre_Doc(i));
            raw = readmatrix(Doc);
            Tiempo(i) = {raw(:,1)'};
            Ref(i) = {raw(:,2)'};
            Control(i) = {raw(:,3)'};
            Lectura(i) = {raw(:,4)'};
            Nom_doc(i) = {replace(extractBefore(Nombre_Doc(i), strlength(Nombre_Doc(i)) - 8), "_", " ")};
        end
    else
        Doc = fullfile(pwd, "Ensayos", Nombre_Doc(a));
        raw = readmatrix(Doc);
        Tiempo(1) = {raw(:,1)'};
        Ref(1) = {raw(:,2)'};
        Control(1) = {raw(:,3)'};
        Lectura(1) = {raw(:,4)'};
        Nom_doc(1) = {replace(extractBefore(Nombre_Doc(a), strlength(Nombre_Doc(a)) - 8), "_", " ")};
    end

end