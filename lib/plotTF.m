function plotTF
    src = fullfile(pwd, 'src');
    addpath(src);
    src = fullfile(pwd, 'lib');
    addpath(src);
    clear src
    
    [Tiempo, Ref, Control, Lectura, Nom_doc] = Datos_Ensayo();
    
    s = tf('s');
    MBa = -5.177/(2.99*s^2 + s);
    %Mbc = 6.827/(s^2 + 0.6646*s);
    Mbc = 6.827/(s^2 + 0.6646*s -1.042);
    Kc = 1.5;
    
    TFBc = (Kc*Mbc) / (1 + (Kc*Mbc));
    TFBa = (Kc*MBa) / (1 + (Kc*MBa));
    %T = 0:max(Tiempo{1})/numel(Tiempo{1}):max(Tiempo{1});
    T = linspace(0, max(Tiempo{1}), numel(Tiempo{1})); % IA
    
    Tbc = step(5*TFBc, T);
    Tba = step(5*MBa, T);
    
    Tba2 = step(-5*Mbc, T);
    Tbc2 = step(-5*TFBa, T);
    
    subplot(1,2,1)
    hold on
    plot(Tiempo{1}, Lectura{2})
    plot(Tiempo{1}, desp(Tbc, 100))
    plot(Tiempo{1}, desp(Tbc2, 100))
    ylim([-20, 20])
    legend("Real", "Modelo Bc", "Modelo Ba")
    title("Modelo BC")
    
    subplot(1,2,2)
    hold on
    plot(Tiempo{1}, Lectura{5})
    plot(Tiempo{1}, desp(Tba, 100))
    plot(Tiempo{1}, desp(Tba2, 100))
    ylim([-300, 300])
    legend("Real", "Modelo Ba", "Modelo Bc")
    title("Modelo BA")
end