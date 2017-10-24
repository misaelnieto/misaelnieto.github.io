---
published: true
title: Celda solar sencilla con TCAD de Silvaco (Parte 1)
mathjax: true
---

![El Sol]({{site.baseurl}}/media/johnny-automatic-old-sun.png)

### Acerca de Silvaco

[Silvaco](https://www.silvaco.com/) es una compania estadounidense con sede en Santa Clara, California (alias Silicon Valley). Silvaco se especializa en software EDA (_Electronic Design Automation_). En mi maestria en ingenieria estoy trabajando con TCAD (Techology Computer Aided Design). Segun la [Wikipedia](https://en.wikipedia.org/wiki/Technology_CAD) TCAD es una rama de EDA especializada en modelar la fabricacion de semiconductores y la operacion de dispositivos.

Para Silvaco, ademas de ser el nombre de la tecnologia, tambien tiene el nombre de un grupo de aplicaciones de software que permiten simular dispositivos semiconductores a nivel de micrones. A partir de ahora, me referire a TCAD como el software que distribuye TCAD.

En TCAD existen dos componentes muy importantes que son los que se encargan principalmente de resolver los diferentes modelos matematicos de la fisica de semiconductores.

* **Athena**: Se encarga pricipalmente de simular los procesos fisicos y quimicos usados en la fabricacion de dispositivos semiconductores.
* **Atlas**: Simula la interaccion de dispositivos semiconductores en diferentes condiciones: iluminacion, polarizacion, corrientes, campos electricos, etc.

![El TCAD de Silvaco contiene varios modulos]({{site.baseurl}}/media/diagrama_silvaco_TCAD.svg)

Cuando instalas Silvaco se instalan un montón de ejemplos de diferentes estructuras y dispositivos semiconductores (`directorio_silvaco/examples`). De todos esos ejemplos, veinte son de simulaciones con dispositivos solares. En esta serie de artículos estarán basados en el primer ejemplo `solarex01.ini`.

### Malla de calculo

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

Vale la pena hacer notar que la malla tiene 4747 puntos o 9200 triangulos (??? Explica bien las implicaciones de tener mas o menos puntos/triangulos???)

### Definición del sustrato

El sustrato es una oblea de Silicio cristalino con orientación **<100>** y dopado con impurezas de Boro a una **concentración** de $$ 10^{13} $$ cm-3. La instrucción para realizar

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

### Cosas de Copyright

- El dibujo del sol lo tome de https://openclipart.org/detail/553/old-sun
- Silvaco, Athena, Atlas y nombres relacionados son propiedad de Silvaco In.
