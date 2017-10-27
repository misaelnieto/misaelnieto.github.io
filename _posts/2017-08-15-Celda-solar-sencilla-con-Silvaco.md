---
published: true
title: Celda solar sencilla con TCAD de Silvaco (Parte 1)
mathjax: true
---

![El Sol]({{site.baseurl}}/media/johnny-automatic-old-sun.png)
## Introducción

Esta es una serie de artículos relacionados con la simulación de una celda solar de unión PN con el software [Silvaco TCAD](https://www.silvaco.com/products/tcad.html). Este primer artículo contiene una breve reseña de la empresa Silvaco y su simulador TCAD seguido del diseño de la celda y la descripción general del proceso de simulado.

### Acerca de Silvaco

[Silvaco](https://www.silvaco.com/) es una compania estadounidense con sede en Santa Clara, California (alias Silicon Valley). Silvaco se especializa en software EDA (_Electronic Design Automation_). En mi maestria en ingenieria estoy trabajando con TCAD (Techology Computer Aided Design). Segun la [Wikipedia](https://en.wikipedia.org/wiki/Technology_CAD) TCAD es una rama de EDA especializada en modelar la fabricacion de semiconductores y la operacion de dispositivos.

Para Silvaco, ademas de ser el nombre de la tecnologia, tambien tiene el nombre de un grupo de aplicaciones de software que permiten simular dispositivos semiconductores a nivel de micrones. A partir de ahora, me referire a TCAD como el software que distribuye TCAD.

En TCAD existen dos componentes muy importantes que son los que se encargan principalmente de resolver los diferentes modelos matematicos de la fisica de semiconductores.

* **Athena**: Se encarga pricipalmente de simular los procesos fisicos y quimicos usados en la fabricacion de dispositivos semiconductores.
* **Atlas**: Simula la interaccion de dispositivos semiconductores en diferentes condiciones: iluminacion, polarizacion, corrientes, campos electricos, etc.

![El TCAD de Silvaco contiene varios modulos]({{site.baseurl}}/media/diagrama_silvaco_TCAD.svg)

Cuando instalas Silvaco se instalan un montón de ejemplos de diferentes estructuras y dispositivos semiconductores (`directorio_silvaco/examples`). De todos esos ejemplos, veinte son de simulaciones con dispositivos solares. En esta serie de artículos estarán basados en el primer ejemplo `solarex01.ini`.

## Diseño de la celda

A continuación se muestra un esquema de la estructura final de la celda solar.

![Plan de construcción de la celda solar]({{site.baseurl}}/media/celda_solar_diagramas_pag1.svg)

Ĺas dimensiones de la celda en 2D serán:

- Sustrato: 20 μm de ancho por 50 μm de alto; esto incluye la región **n+**.
- Por el momento, el grosor de la región **n+** es desconocido y el valor de **X<sub>J</sub>** debe ser calculado.
- El contacto de Aluminio en la parte superior del sustrato es de 4μm de ancho y 0.1μm de alto.

En total la estructura tiene altura de 50.1 μm, incluyendo el contacto de Aluminio.

Además de los parámetros anteriores definiremos el sustrato tipo *p* como Silicio cristalino con orientación **<100>** y dopado con impurezas de Boro a una **concentración** de $$ 10^{13} $$ cm-3.

Finalmente la capa n+ será creada mediante [implantación de iones](https://en.wikipedia.org/wiki/Ion_implantation) de fósforo. Es necesario, entonces, calcular los parámetros necesarios para dicho proceso.

### Dimensionamiento del grosor de la capa **n+**.

Para fabricar la capa **n+** simularemos el proceso de implantación de iones que es bien conocido en la industria de la fabricación de semiconductores. Según Jaeger, la implantación ofrece muchas más ventajas sobre la difusión y por eso se ha convertido en el proceso principalmente usado en la industria de la fabricación de dispositivos integrados.

El proceso de implantación de iones consiste en acelerar un haz de impurezas (en nuestro caso, Boro) con energías en el rango de varios keV hasta varios MeV, luego dicho haz se enfoca hacia un blanco, es decir la superficie del semiconductor.

![Implantación de iones]({{site.baseurl}}/media/Implantacion-de-iones.svg "El proceso de implantación de iones")

Conforme las impurezas aceleradas van penetrando el cristal, estas chocan varias veces con la rejilla del cristal perdiendo energía y causando desperfectos en la estructura del cristal. Finalmente las impurezas pierden toda su energía cinética y paran de moverse a cierta profundidad promedio.

El tipo de impureza su energía cinética de implantación, el tipo de estructura cristalina del blanco determinan la profundidad y la dispersión del dopante dentro del cristal semiconductor. De acuerdo a Streetman, el rango de penetración oscila entre entre algunos cientos de Angstroms hasta 1 μm.

Luego, en esta simulación, el grosor y las características de la capa **n+** estan en función del modelo de implantación. Por default, Athena usa el modelo *SIMS-Verified Dual Pearson* (SVDP), pero usaremos el modelo estadístico o *Gaussiano* debido a que es el proceso más conocido en los libros de texto y como su nombre lo indica, es una curva gaussiana donde la concentración de dopantes esta en función de la profundidad en el cristal. Veamos la siguiente gráfica:

![Perfil gaussiano de impurezas]({{site.base_url}}/media/perfil-gaussiano-impurezas.svg "Gráfica de concentración vs profundidad.")

La distribución gaussiana esta modelada en base a la siguiente ecuación

 $$
 N(x) = 
 {\phi \over { \sqrt {2\pi}  \Delta R_p} }

 exp \left[ - {1 \over 2} { { (x -R_p) ^2} \over {\Delta R_p ^2 } } \right]
 $$

Donde:

- $$N(x)$$ es la **concentración** de los iones con respecto a la profundidad en el sustrato (*x*).
- $$\phi$$: es la **dosis** de iones, medida en en cm <sup>2</sup>.
- R <sub>p</sub>: es el rango proyectado y corresponde a la *media* en la curva de gauss. Justo a esa profundidad se encontrará la mayor concentración de dopantes. Así mismo, el rango proyectado está en función de la energía del ion y de la masa atómica y número atómico tanto del ión como del sustrato.
- $$\Delta R_p$$: éste parámetro se llama en inglés *straggle*, que en español sería *rezago* o *extravío* y corresponde con la *desviación estándar* en la curva de gauss. La idea en general es que algunos iones tendrán "suerte" y penetrarán más allá del rango proyectado R<sub>P</sub> mientras que otros no.

Ahora, reconsideremos la capa n+ que deseamos construir. Asumamos que tanto R <sub>p</sub> como $$\Delta R_p$$ serán iguales en Silicio cristalino y SiO2 (Es esto correcto.). Es necesario que, a nivel de la superficie del sustrato tengamos la concentración máxima y que vaya decayendo hasta la profundidad de la union, que es el punto donde la concentracion de fósforo esta en una concentración similar al de del Boro.

Una manera de lograr lo anterior es depositar una capa de SiO<sub>2</sub> sobre el sustrato con el mismo grueso que el grueso deseado de la capa **n+**. Entonces, si deseamos que la capa **n+** mida 0.5 μm deberemos depositar otra capa de SiO<sub>2</sub> con grosor de 0.5 μm. El perfil de concentración deberá quedar de la siguiente manera.

![Perfil de concentracion en union pn]( {{site.base_url}}/media/diseno_capa_n.svg )

Ya tenemos dos parámetros. El grosor de la capa de SiO <sub>2</sub> y el grosor de la capa **n+**. Además el valor esperado de **X<sub>J</sub>** será 0.5 μm. Además, podemos inferir que $$ R_p = 0.5 \mu m$$ (midiendo desde la superficie del SiO <sub>2</sub>).

Recordemos que el perfil de implantación de iones es una curva típica de gauss; como sabemos, la desviación estándar es una medida de dispersión para la curva de gauss y mediante la regla [68-95-99.7](https://en.wikipedia.org/wiki/68%E2%80%9395%E2%80%9399.7_rule) podemos asumir que en un intervalo de 6 desviaciones estándar a partir de la media acumularemos el 99.73% de los iones implantados. Siguiendo esta logica podemos proponer un valor estimado para $$\Delta R_p = 0.5 \mu m /3  = 0.166\mu m $$. Si desearamos mayor precisión podemos proponer valores como $$ 0.5 \mu m/4$$ , $$0.5 \mu m/5 $$ etc..

Como sabemos N <sub>p</sub> es valor máximo de concentración de la implantación y estará ubicada justo en el contacto entre el SiO <sub>2</sub> y el sustrato.Si deseamos que *N<sub>p</sub>* = 10 <sup>18</sup> /cm^{-3}, ¿Qué dosis debemos usar en el proceso de implantación?

La relación entre la dosis y la concentración están dadas por la siguiente ecuación:

$$
Q= \sqrt {2 \pi} N_p \Delta R_p
$$

De tal manera que:

$$
\begin{aligned}

0.166\mu m = 1.66 x10^{-5} cm
\\
Q= \sqrt {2 \pi} \cdot 10^{18}/cm^3 \cdot 1.66 x10^{-5} cm = \sqrt {2 \pi} \cdot  1.66x10 ^{13}/cm ^ 2
\\
Q = 8.833 x10 ^{12} /cm ^ 2
\end{aligned}
$$


- Tiempo: 10 min
- Dosis: 10<sup>6</sup> cm<sup>2</sup> (iones por cm<sup>2</sup>)
- Energía: 30 KeV
- Modelo de implantación: By default, Athena uses SIMS-Verified Dual Pearson (SVDP) implant models
- Inclinación: 7°
- Rotación: 30°
- Impureza: Fósforo
- El silicio es cristalino.

Notas: rate of dopant diffusion is highly dependent on the level of damage in the substrate (2.4.5 Modelling the Correct Substrate Depth)

### Simulación de la fabricación de la Celda.

Usaremos **Athena** para simular las diferentes etapas de fabricación de la celda solar. A manera de pseudocódigo los pasos necesarios para la fabricación, desde el punto de vista del simulador (ya que hay pasos que no son necesarios como, por ejemplo, [limpieza RCA](https://en.wikipedia.org/wiki/RCA_clean) ) son:

1. Definición del sustrato: oblea de Silicio cristalino con orientación **<100>** y dopado con impurezas de Boro a una **concentración** de 
$$ 10^{13} $$ cm-3. Eso lo hace un cristal tipo *P*.

2. Creación de capa protectora de SiO2 de 0.05 μm. Esta capa es necesaria para
el proceso de difusión que será el próxmimo paso.

3. Proceso de dopaje mediante la [implantación de iones](https://en.wikipedia.org/wiki/Ion_implantation) de fósforo seguido de otro proceso de difusión (drive-in) para crear una región *n+* en la parte superior del sustrato.

4. Formación de contacto de aluminio en la parte superior del sustrato/dispositivo. Esto implica algunos pasos más.
    * Perforar una ventana en la capa de SiO2.
    * Depositar una capa de aluminio de 0.1 μm de grosor.
    * Eliminar el exceso de aluminio junto con la capa de SiO2.

5. Conectar electrodos en el contacto de aluminio y en el reverso del sustrato.




### Simulación de la fabricación de la Celda.

### Malla de cálculo

**Athena** es el módulo que nos permitirá simular la construccion de la estructura física de la celda solar. La primera línea del ejemplo es para lanzar el módulo Athena de Silvaco.

```
go athena
```

Despues se define una malla para poder controlar el detalle de la simulación a manera de no desperdiciar tiempo y recursos (como, por ejemplo: procesador). En este ejemplo tan pequeño no nos importa mucho cuántos recursos se usan, pero en simulaciones más grandes y complejas el tiempo de simulación empieza a tomar mucha relevancia. En esta ocasión haremos una malla de 10x50 μm.

![Malla de cálculo]({{site.baseurl}}/media/malla-solarex01.png)

El conjunto de instrucciones que crean esta malla son:

```
line x loc=0.00 spac=1
line x loc=10 spac=1

line y loc=0.00 spac=0.05
line y loc=0.25 spac=0.02
line y loc=1 spac=0.1
line y loc=50 spac=10
```

Nota: por default, la unidad de medida de **line** es de 1 μm.

Vale la pena hacer notar que la malla tiene 4747 puntos o 9200 triángulos (??? Explica bien las implicaciones de tener mas o menos puntos/triangulos???)

### Definición del sustrato

El sustrato es una oblea de Silicio cristalino con orientación **<100>** y dopado con impurezas de Boro a una **concentración** de $$ 10^{13} $$ cm-3. Eso lo hace un cristal tipo P.


```
init silicon c.boron=1.0e13 orientation=100
```


### Capa protectora oxido

Depositamos una capa delgada de SiO2 de 0.05 μm para proteger el sustrato de contaminación.

```
deposit oxide thickness=0.05 div=1
```

No estoy seguro si realmente necesitamos esa protección en el simulador, pero si se fuera a fabricar esta estructura definitivamente requeriríamos esta capa protectora; esta es la razón por la que creo que incluyeron esta capa en la simulación.

Finalmente, podemos ver la capa representada en forma gráfica.

![Capa de SiO2 para protejer el sustrato de Silicio]({{site.baseurl}}/media/solarex01-oxido-protector.png)

En la figura de arriba, la sección amarilla es el sustrato, mientras que la región azul es el SiO2. El eje **y** es la concentración de material. Como vemos, el sustrato de silicio tiene una concentración de dopantes de 10^14 cm-3; como tampoco hemos hecho ningun otro proceso, la concentracion neta de impurezas en el dispositivo es la misma que la del boro.

### Creación de una región de tipo P dentro del sustrato.

Me han dicho que la celda solar más sencilla es un simple **diodo** en sustrato de Silicio. El sustrato de silicio es de tipo P (explicar por que el boro hace un cristal tipo P)

### Referencias

[1] Introduction to Microelectronic Fabrication (2nd Ed.), Richard C. Jaeger, Prentice Hall
[2] Athena Users' Manual, Silvaco Inc., 2015


### Cosas de Copyright

- El dibujo del sol lo tome de https://openclipart.org/detail/553/old-sun
- Silvaco, Athena, Atlas y nombres relacionados son propiedad de Silvaco In.
