% Inicialización de los procesos de lectura/escritura de la Tajeta NIDAQ USB

global Dispositivos
global Sesion

warning off; %Deshabilitar los mensajes de advertencia
% Inicialización tarjeta adquisición datos
Dispositivos=daq.getDevices;

if isempty(Dispositivos)
    error('No se han detectado dispositivos NIDAQ.');
end

Dispositivos=Dispositivos(1); %El primer dispositivo es la TAD USB-6001

primer_canal_AD=0; % Lectura de la velocidad angular del motor
n_canales_AD=1; %Número de canales para medir

%primer_canal_AD=1; % Lectura de la posición angular del motor

primer_canal_DA=0; % Escritura de la tensión de entrada al motor
n_canales_DA=1; %Número de canales para escribir

%Creación de la sesión
Sesion=daq.createSession(Dispositivos.Vendor.ID);

%Inicialización de los canales de lectura

    for i=primer_canal_AD:primer_canal_AD+n_canales_AD-1
        CanalIn = addAnalogInputChannel(Sesion, Dispositivos.ID, i, 'Voltage');
        CanalIn.InputType = 'SingleEnded';
    end

%Inicialización de los canales de escritura
for i=primer_canal_DA:primer_canal_DA+n_canales_DA-1
    CanalOut = addAnalogOutputChannel(Sesion, Dispositivos.ID, i, 'Voltage');
end


 