---
published: false
---
## Celda solar sencilla con TCAD de Silvaco (Parte 1)

![El Sol]({{site.baseurl}}/media/johnny-automatic-old-sun.png)

### Acerca de Silvaco

[Silvaco](https://www.silvaco.com/) es una compania estadounidense con sede en Santa Clara, California (alias Silicon Valley). Silvaco se especializa en software EDA (_Electronic Design Automation_). En mi maestria en ingenieria estoy trabajando con TCAD (Techology Computer Aided Design). Segun la [Wikipedia](https://en.wikipedia.org/wiki/Technology_CAD) TCAD es una rama de EDA especializada en modelar la fabricacion de semiconductores y la operacion de dispositivos.

![El TCAD de Silvaco contiene varios modulos]({{site.baseurl}}/media/Diagrama Silvaco TCAD.png)

Cuando instalas Silvaco se instalan un montón de ejemplos de diferentes estructuras y dispositivos semiconductores (`directorio_silvaco/examples`). De todos esos ejemplos, veinte son de simulaciones con dispositivos solares.

Tomaré el primer ejemplo `solarex01.ini` e intentaré agregar un poco más de información que la que viene en los comentarios del programa.

### Acerca de las celdas solares

Algun resumen en un futuro no lejano.

### Malla de calculo

**Athena** es el módulo que nos permitirá simular la construccion de la estructura física de la celda solar. La primera línea del ejemplo es para lanzar el módulo Athena de Silvaco.

```
go athena
```

Despues se define una malla para poder controlar el detalle de la simulación a manera de no desperdiciar tiempo y recursos (como, por ejemplo: procesador). En este ejemplo tan pequeño no nos importa mucho cuántos recursos se usan, pero en simulaciones más grandes y complejas el tiempo de simulación empieza a tomar mucha relevancia.

```
line x loc=0.00 spac=1
line x loc=10 spac=1

line y loc=0.00 spac=0.05
line y loc=0.25 spac=0.02
line y loc=1 spac=0.1
line y loc=50 spac=10
```

Cuando no ha sido especificado la unidad de medida de **line** es micrones o micrometros. Estas instrucciones hacen una malla de 10x50 μm. Graficamente, la malla se vería de esta manera.

![Malla de cálculo]({{site.baseurl}}/media/malla-solarex01.png)

### Definición del sustrato

La siguiente instrucción inicializa el sustrato del dispositivo.

```
init silicon c.boron=1.0e14 orientation=100
```

El sustrato será de Silicio cristalino con orientación **<100>** y dopado con impurezas de Boro a una concentración de 10^14 cm-3.

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

La celda solar más sencilla es un simple **diodo**.


### Cosas de Copyright

El dibujo del sol lo tome de https://openclipart.org/detail/553/old-sun
