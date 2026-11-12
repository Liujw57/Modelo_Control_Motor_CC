function Ensayo = Ensayos(a)
    if nargin < 1
        error('No se ha indicado ensayo');
    end
    
    %Conexión a la tarjeta
    src = fullfile(fileparts(pwd), 'src');
    addpath(src);
    
    try
        InicializaTarjeta
    catch ME
        error(ME.message);
    end
    
    rmpath(src);
    
    %Selección del ensayo
    switch a
        case 1
            %Doc2_5.1.1
            Tipo_Ensayo = 1; %Bucle abierto
            Intervalo_Muestra = 20; %ms
            Comando =   [0 2  0]; %Valor de la referencia, desde 0 a 10
            Comando_t = [2 16 2]; %Duración de la referencia en s
            Nombre_Resultado = 'Velocidad';
        case 2
            %Doc2_5.1.2
            Tipo_Ensayo = 1; %Bucle abierto
            Intervalo_Muestra = 20; %ms
            Comando =   [0 2   5   8   5 2   0]; %Valor de la referencia, desde 0 a 10
            Comando_t = [2 7.5 7.5 7.5 7.5 7.5 2]; %Duración de la referencia en s
            Nombre_Resultado = 'Velocidad_Incremento';
        case 3
            %Doc2_5.2.2
            Tipo_Ensayo = 2; %Bucle cerrado PID
            Intervalo_Muestra = 20;
            Duracion = 20; % Duración del ensayo en s
            Angulo_Objetivo = 90; % 0V es mirando al frente (90º en el papel) +h -ah
            Kp = 1.5;
            % Ki = 0;
            % Kd = 0;
            Nombre_Resultado = 'Posicion_BC';
         case 4
            %Doc2_5.1.1
            Tipo_Ensayo = 1; %Bucle abierto
            Intervalo_Muestra = 20; %ms
            Comando =   [0 2  0]; %Valor de la referencia, desde 0 a 10
            Comando_t = [2 16 2]; %Duración de la referencia en s
            Nombre_Resultado = 'Posición_BA';
        otherwise
            error("Ensayo no registrado")
    end
    
    %Ejecutar tipo de ensayo
    switch  Tipo_Ensayo
        case 1 %Bucle abierto
            %Validación del ensayo seleccionado
            if length(Comando) ~= length(Comando_t)
                error('Ensayo mal definido');
            end
            
            %Creación del ensayo
            Ref = [];
            
            for i=1:numel(Comando)
                nMuestras = round(Comando_t(i) * 1000 / Intervalo_Muestra);
                Ref = [Ref, Comando(i) * ones(1, nMuestras)];
            end
            
            %Ejecución del ensayo
            t_ini = milisec;
            for i=1:numel(Ref)
                t1=milisec;
                t(i)=t1;
            
                medidas=AD_NIDAQ_USB();
                yk=medidas(1);
            
                DA_NIDAQ_USB(Ref(i))
            
                % Se guardan todos los valores
                Tiempo(i) = (milisec - t_ini) / 1000;
                Referencia(i)=Ref(i);
                Control(i)=Ref(i);
                Lectura(i)=yk;
            
                t2=milisec; % Así sabremos cuanto tiempo ha transcurrido 
                % desde que empezó el periodo (t2-t1) en milisengundos
            
                espera(max(0,Intervalo_Muestra-(t2-t1)));
            end
        case 2 %Bucle cerrado PID
            %Pdte implementar I y D

            %Creación del ensayo
            V_Objetivo = Angulo_Objetivo * (5/90);
            t_ini = milisec;
            Muestras_t = round(Duracion * 1000 / Intervalo_Muestra);
            inicio = 0.1;
            Ref = [0.*ones(1, round(Muestras_t * inicio)) V_Objetivo.*ones(1, round(Muestras_t*(1-inicio)))];
            
            % N_Muestra = 0;
            %Ejecución del ensayo

            % Empleo de while para que
            % la obtención de datos no bloquee el control.
            % Si da problemas emplear bucle for
            % while milisec - t_ini < (Duracion * 1000)
            %     medidas=AD_NIDAQ_USB();
            %     yk=medidas(1);
            %     V_error = yk - V_Objetivo;
            %     Salida = V_error * Kp;
            % 
            %     DA_NIDAQ_USB(Salida)
            % 
            %     if (N_Muestra - 1) * Intervalo_Muestra < milisec - t_ini
            %         Tiempo(N_Muestra) = (milisec - t_ini) / 1000
            %         Referencia(N_Muestra)=V_Objetivo;
            %         Control(N_Muestra)=Salida;
            %         Lectura(N_Muestra)=yk;
            %         N_Muestra = N_Muestra + 1;
            %     end
            % 
            %     if milisec - t_ini > 200000
            %         break %Sale del bucle pasado los 20s por seguridad
            %     end
            % end

            for i=1:numel(Ref)
                t1 = milisec;
                medidas=AD_NIDAQ_USB();
                yk=medidas(1);

                error = yk - Ref(i);
                Salida = error * Kp;

                DA_NIDAQ_USB(Salida)

                Tiempo(i) = (milisec - t_ini) / 1000;
                Referencia(i)=Ref(i);
                Control(i)=Salida;
                Lectura(i)=yk;

                t2=milisec;
                espera(max(0,Intervalo_Muestra-(t2-t1)));
            end
        otherwise
            error("Tipo de ensayo no correcto")
    end

    % Poner la salida a cero
    DA_NIDAQ_USB(0);
    
    %Parar las tareas
    run('PararProcesosTarjeta');
    
    Ensayo = [Tiempo; Referencia; Control; Lectura]';
    
    file_name = string(Nombre_Resultado) + '_' + string(datetime("now","Format","HHmm")) + '.txt';
    save(file_name, "Ensayo", "-ASCII")

end

