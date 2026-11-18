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

fdsgfsgasdasd


- Ensayo de posición en bucle abierto
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
m = -10.3545
$$

$$
K = \frac{m}{\Delta U} \Rightarrow
K = \frac{-10.3545}{2} \Rightarrow
K = -5.177
$$





- Ensayo de posición en bucle cerrado

