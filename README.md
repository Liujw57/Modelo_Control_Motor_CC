# Modelo Control Motor CC
Se desea crear un modelo de controlador para la velocidad y posición
de un motor de CC en Matlab.

La comunicación entre el ordenador y el motor se realizar empleando
la placa NIDAQ USB y una libreria proporcionada por la
Universidad Politécnica de Valencia. [<sup>1</sup>]()

El objetivo básico es que cumpla con las siguientes especificaciones:
- Tiempo de establecimiento ≤ 3s (t<sub>e</sub> ≤ 3s)
- Sobre oscilación ≤ 4.3% (δ ≤ 4.3%)
- Error nulo ante referencia escalón (e<sub>p</sub> = 0)

## Modelado e identificación del motor

Mediante el uso de la función personalizada [`Ensayos(n)`]() siendo
n el tipo de ensayo, se realizan 3 ensayos:

### Ensayo de velocidad 
<p align="center"> <img src="img/V_ESC.png" alt="Valor del ensayo de velocidad"
style="
    max-height:300px;
    width:auto;">
</p>

En el ensayo se la aplica, partiendo de un tiempo de reposo, una tensión proporcional a una velocidad determinada. En este caso, de incremento de velocidad, se le incrementa la tensión 3V en cada incremento y reducen otros 3V en cada disminución. Luego se obtienen los valores de cada step en el ensayo.

Aún que la gráfica se muestre con curvas, se trata de un sistema de primer orden ya que son saltos simples pero el sistema presenta una curva de estabilización en un tiempo determinado. Para la obtención de los datos simplemente se han contemplado 4 datos ordenados en una matriz: El tiempo de ensayo, la referencia de voltaje, el valor en el control (el motor) y la lectura que tenemos.
La función de transferencia queda definida por:

$$G(s) = \frac{\Delta Y(s)}{\Delta U(s)} = \frac{K}{1 + \tau s}$$

Donde los parámetros que caracterizan cada tramo de la respuesta del sistema son:

* **Ganancia estática ($K$):** Representa la relación entre el incremento de la salida en régimen permanente y el incremento aplicado en la entrada ($K = \frac{\Delta y}{\Delta u}$). Para calcularla en cada salto se mide el valor inicial y final tanto de la señal de entrada ($\Delta u = u_{fin} - u_{ini}$) como de la variable de salida ($\Delta y = y_{fin} - y_{ini}$).
* **Constante de tiempo ($\tau$):** Indica la rapidez de respuesta del sistema ante el cambio en la entrada. Se define como el tiempo que tarda la variable de salida $y(t)$ en alcanzar el **$63\%$ de su incremento total** ($0.63 \cdot \Delta y$) tomando como origen de tiempos el instante exacto en el que se produce el escalón en la entrada.

A partir de esta base teórica, el procedimiento seguido para extraer los valores experimentales de cada escalón y obtener los parámetros medios ($\bar{K}$ y $\bar{\tau}$) ha sido el siguiente:
Además de ignorar los tiempos de reposo inicial y final del ensayo, también se han ignorado los tiempos de estabilización a la hora de obtener la K. Esto se debe a que K representa la referencia estática y no el transitorio entre incrementos.Así que, después de haber definido la cantidad de incrementos o disminuciones que hay en el ensayo, se ha establecido un umbral de diferencia entre cada muestra para saber cuando empieza a ser estable y, ahí obtener todos los valores de la ganancia estática por la relacion ($K = \frac{\Delta y}{\Delta u}$). 
Respecto a Tau, es basicamente el tiempo en el que el salto ha llegado al 63 % del final. Por lo que se ha hecho una media de todos los Tau del ensayo, así como las K para sacar la función de transferencia.

### Ensayo de posición en bucle abierto
<p align="center"> <img src="img/P_BA.png" alt="Valor del ensayo de velocidad"
style="
    max-height:300px;
    width:auto;">
</p>

En el ensayo se aplica una señal de 2V al motor y se obtiende los valores de
la posición.

De la gráfica Posición BA podemos deducir que el comportamiento es de un
sistema de 1º orden con integrador que se puede aproximar mediante la formula:

$$ \frac{\Delta Y(s)}{\Delta U(s)} = G(s) =
\frac{K}{s(1+\tau)}
$$

Por lo que se debe determinar:\
La ganancia $K$ siendo la pendiente de la posición respecto del tiempo ante
el cambio de la señal de control.\
Y la constante de tiempo $\tau$, que representa el tiempo que requiere el sistema
desde que se le proporciona la señar de acción hasta llegar al equilibrio.

De la gráfica Posición BA se puede obtener 3 puntos representativos para
el calculo del sistema:\
P<sub>0</sub> = (2.23232, -2.5901) \
P<sub>1</sub> = (3.39392, -6.76969) \
P<sub>2</sub> = (3.55396, -8.42683) \
El punto P<sub>0</sub> corresponde al valor de la posición cuando se aplica
la señal de control. Y los puntos P<sub>1</sub>, P<sub>2</sub> son puntos
arbitrarios del sistema en estado estable.

Para determinar $K$ siendo este la pendiente respecto de la señar de control
,primero se calcula la pendiente $m$:

$$
m = \frac{Y_2 - Y_1}{X_2 - X_1} \Rightarrow
m = \frac{-8.42683 - (-6.76969)}{3.55396 - 3.39392} \Rightarrow
\underline{m = -10.3545}
$$

$$
K = \frac{m}{\Delta U} \Rightarrow
K = \frac{-10.3545}{2} \Rightarrow
\boxed{K = -5.177}
$$



### Ensayo de posición en bucle cerrado

