---
title: Módulos y paquetes en Python
layout: post
categories: Python
---

![Packages](/media/4772680734_3ab815e07a_n.jpg)

Cuando comenzamos a usar Python, tarde o temprano llegaremos al usar módulos y
paquetes.

En Python, un [módulo](https://docs.python.org/2/tutorial/modules.html)  es un
objeto que sirve como contenedor para organizar codigo en Python. Cada módulo
tiene asignado un espacio de nombres y dentro de ese espacio de nombres puede
haber cualquier cantidad de objetos, y como en Python todo es un objeto, tambien
puede contener otros módulos.

En el siguiente ejemplo se importa el módulo `math`; `math` es el espacio de
nombres para un monton de funciones, clases y valores relacionados con
operaciones matematicas; el nombre `pi` es uno de esos y se encuentra **dentro**
del espacio de nombres `math`.

```python
>>> import math
>>> math.pi
3.141592653589793
>>>
```

En lenguajes como C, lo equivalente es `#include <math.h>`, pero la
diferencia esta en que todas las funciones, variables y constantes de la libreria se
quedan disponibles en el espacio de nombres global. Cuando se incluyen muchas
librerias y el codigo se hace muy grande, se corre el peligro de **contaminar** el
espacio de nombres (**namespace pollution**). Otro problema es la colisión de
nombres (**namespace collision** o **namespace clash**), que en nuestro ejemplo,
ocurriría si alguna otra libreria define una variable o una funcion con el
nombre `pi`.

Con los módulos de Python se matan dos pajaros de un tiro: 1) son una manera de
organizar codigo y 2) se reduce la posibilidad de colisión de nombres y
contaminar el espacio de nombres global.

Ademas de los módulos, Python tiene el concepto de 
[paquetes](https://docs.python.org/2/tutorial/modules.html#packages)
Un paquete es un módulo de Python que contiene otros módulos y/o paquetes. La
diferencia entre un módulo y un paquete es que el paquete contiene un atributo
`__path__` que indica la ruta en el disco duro donde esta almacenado el
paquete.

Aca un ejemplo de un módulo:

```python
>>> import os
>>> os
<module 'os' from '/usr/lib64/python2.7/os.pyc'>
>>> os.__package__

>>>
```

Ahora dos paquetes, `json` y `gtk`:

```python
>>> import gtk
>>> gtk
<module 'gtk' from '/usr/lib64/python2.7/site-packages/gtk-2.0/gtk/__init__.pyc'>
>>> import json
>>> json
<module 'json' from '/usr/lib64/python2.7/json/__init__.pyc'>
```

Notaste alguna diferencia? `os` es un archivo mientras que`gtk` y `json`
son archivos con el nombre `__init__.py` que estan dentro de un directorio con
el mismo nombre del paquete.

**Nota**: `pyc` es la extension para archivos de python compilados. Casi
siempre vienen acompanhados de el archivo `.py` original. Anda y abre los
archivos `.py` correspondientes para que veas que no hay nada mágico.

Tanto módulos como paquetes tienen muchos mas detalles que no voy a cubrir por
el momento, basta con que te quedes con lo siguiente: en Python, los archivos
con extension `.py` son módulos, mientras que cualquier directorio que
contenga un archivo con el nombre `__init__.py` se convierte en un paquete.


## ¿Dónde estan los módulos de Python?

Si en Python tanto los módulos y los paquetes son archivos y directorios con
archivos ¿Te has preguntado de donde saca Python los módulos?

La libreria estándar de Python se encuentra en algun lugar del sistema de
archivos. El lugar depende de si el sistema operativo es Windows, Linux, MacOS y
si el sistema es de 64 bits o de 32.

En un Fedora 20 a 64 bits, la libreria estándar se encuentra en el directorio
`/usr/lib64/python2.7/`. Los paquetes y módulos que no son parte de la
libreria estándar de Python se encuentran en `/usr/lib64/python2.7/site-packages/gtk-2.0/`.
Como ya dije, la ruta depende de el sistema operativo y
nunca debemos de fiarnos de una ruta en especifico, en cambio, debemos hacer
uso del módulo `sys` para saber la ruta actual donde Python entra a buscar
módulos y paquetes.

## El `Python Path`

Al iniciar un interprete de python, [`sys.path`](https://docs.python.org/2/library/sys.html#sys.path)
se inicializa con una lista de los directorios del sistema donde se encuentra
instalado Python y la libreria estándar. La ruta de este directorio varia de
sistema en sistema. Por ejemplo, en mi computadora:

```python
>>> import sys
>>> sys.path
['', '/usr/lib64/python27.zip', '/usr/lib64/python2.7', '/usr/lib64/python2.7/plat-linux2', '/usr/lib64/python2.7/lib-tk', '/usr/lib64/python2.7/lib-old', '/usr/lib64/python2.7/lib-dynload', '/usr/lib64/python2.7/site-packages', '/usr/lib64/python2.7/site-packages/gtk-2.0', '/usr/lib64/python2.7/site-packages/wx-2.8-gtk2-unicode', '/usr/lib/python2.7/site-packages']
```

Y este es el `Python path`. Es una lista de cadenas que le indican a python
a qué lugares del sistema debe ir a buscar módulos.

Esta lista de cadenas se inicializa a partir de la variable de entorno
[`PYTHONPATH`](https://docs.python.org/2/using/cmdline.html#envvar-PYTHONPATH).
Pero lo mas común es que no este definida.

El detalle mas importante del `Python Path` se encuentra en que la estructura de
datos usada para almacenar las cadenas es una [`Lista`](https://docs.python.org/2/tutorial/datastructures.html#more-on-lists)
y las listas son **mutables**. Eso quiere decir que si manipulamos el `Python
Path` podemos indicarle a Python nuevas rutas a donde debe ir a buscar módulos
y paquetes.

Herramientas como [`virtualenv`](https://pypi.python.org/pypi/virtualenv) como
[`Buildout`](http://www.buildout.org/en/latest/) se aprovechan de esta
caracteristica.

---
* La foto es CC By Marc Falardeu <https://www.flickr.com/photos/49889874@N05/4772680734/>
