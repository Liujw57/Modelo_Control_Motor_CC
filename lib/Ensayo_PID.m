function [Segundos, Referencia, Control, Sistema, Ctrl] = Ensayo_PID(Ref, Tiempo, Kp, Ti, Td)
%{
Argumentos:
Ref = Velocidad objetivo
Tiempo = Duración de ensayo en s
Kp = Ganancia proporcional
Ti = Tiempo integral
Td = Tiempo derivativo
Si no hay valor integral y derivativo poner 0
%}

%Validación de argumentos de func
    if nargin < 3
        error("La función requiere al menos 3 argumentos (V_obj, Duración, Kp)")
    end
    if nargin < 4 || isempty(Ti)
        Ti = 1;
    end
    if nargin < 5 || isempty(Td)
        Td = 1;
    end

    try
        InicializaTarjeta
    catch ME
        error(ME.message);
    end

%Valor PID en Ctrl
    Ctrl = ones(1,3);
    Ctrl(1) = Kp;
    Ctrl(2) = Ti;
    Ctrl(3) = Td;

%Var para ensayo
    error = zeros(1,3);
    Salida = zeros(1,2);
    time = zeros(1,2);
    Muestra = 20; %cada cuento se guardan los datos
    t_ini = milisec;
    
    for i=1:(Tiempo*1000)/Muestra
        time(1) = milisec;

        Lectura = AD_NIDAQ_USB();
        error(1) = Ref - Lectura;

        %Calculo de acción de control
        Salida(1) = Salida(2) + Ctrl(1)*(error(1) - error(2) + ((Muestra/1000) / Ctrl(2)) * error(2) + (Ctrl(3) / (Muestra/1000)) * (error(1) - 2*error(2) + error(3)));

        %Limitar salida
        if Salida(1) < -10
            Salida(1) = -10;
        end
        if Salida(1) > 10
            Salida(1) = 10;
        end

        %Apicar acción de control
        DA_NIDAQ_USB(Salida(1));

        %Guarda datos
        Segundos(i) = (milisec - t_ini) / 1000;
        Referencia(i)=Ref;
        Control(i)=Salida(1);
        Sistema(i)=Lectura;
  
        %Actualizar var para siguiente iteración
        error = circshift(error, 1);
        Salida = circshift(Salida, 1);
        time(2) = milisec;

        espera(max(0,Muestra-(time(2)-time(1))));
    end

    % Poner la salida a cero
    DA_NIDAQ_USB(0);
    
    %Parar las tareas
    run('PararProcesosTarjeta');

end