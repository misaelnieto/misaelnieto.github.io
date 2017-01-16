---
layout: post
title:  "Preparar Ubuntu 14.04 para correr Django "
categories: Linux Ubuntu Python Django
---

![El pony de Django]({{ site.url }}/media/magic-pony-django-wallpaper.png)


## Instala los paquetes

Primero hay que actualizar el sistema operativo:

```bash
sudo apt-get update && sudo apt-get upgrade
```

Hay que esperar un poco hasta que se descarguen e instalen todos los paquetes.
Tal vez quieras ir por algun cafe o por te o agua.

Hay veces que es necesario reiniciar Ubuntu, pero no siempre. En caso de duda,
reinicalo.

El siguiente paso es instalar algunas librerias de desarrollo y utilidades:


```bash
sudo apt-get install python-pip build-essential python-virtualenv virtualenvwrapper
```

Aca también va a tardar un poco dependiendo de tu internet y un poco de tu
máquina.

## Prueba Django

Vamos a usar
[virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/) para
instalar django en un entorno aislado donde los paquetes de python que
instalemos con pip. Virtualenvwrapper requiere cierta configuración para que
pueda ser usado directamente en la consola, para que la configuración surta
efecto deberás cerrar la consola y abrirla de nuevo.

```bash
mkvirtualenv django
```

Esto es lo que salio en mi consola, en la tuya deberia ocurrir algo parecido

```bash
nnieto@vm001:~$ mkvirtualenv django
New python executable in django/bin/python
Installing setuptools, pip...done.
(django)nnieto@vm001:~$
```

El prompt de mi consola ha cambiado, ahora se le antepone `(django)`. El comando
`mkvirtualenv` inicializa el entorno virtual de python inmediatamente despues de
haberlo creado. La proxima vez que requieras trabajar en ese entorno virtual
de python deberas usar el comando `workon` seguido del nombre del entorno
virtual, que en este caso es `django`. Como ejercicio, cierra la consola y vuelvela
a abrir. Ahora escribe:

```bash
workon django
```

A partir de ahora una vez que hayas entrado en el entorno virtual de python
podras instalar paquetes de python (eggs) sin miedo a causar algun conflicto
con los paquetes de python instalados a nivel del sistema. Eso significa que
podemos tener varios entornos virtuales y en cada uno instalar versiones
diferentes (e incompatibles) en la misma maquina.

Ahora es momento de instalar Django:

```
pip install django
```

`pip` descargará e instalará django. Vamos a seguir los pasos que recomienda el
tutorial de django para probar esta instalacion:

```bash
(django)nnieto@vm001:~$ django-admin.py startproject misitio
(django)nnieto@vm001:~$ cd misitio/
(django)nnieto@vm001:~/misitio$ python manage.py runserver
Validating models...

0 errors found
July 13, 2014 - 02:19:00
Django version 1.6.5, using settings 'mysitio.settings'
Starting development server at http://127.0.0.1:8000/
Quit the server with CONTROL-C.
```

Y listo, ya esta instalado Django dentro de un virtualenv.

-- Fin
