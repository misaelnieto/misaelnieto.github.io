---
title: "Preparar Ubuntu 14.04 para correr Django"
summary: "Instalación de Django 1.6 sobre Ubuntu 14.04 con virtualenvwrapper."
description: "Guía paso a paso para instalar Django en Ubuntu 14.04 usando python-pip, build-essential, python-virtualenv y virtualenvwrapper; crea el primer proyecto con django-admin.py startproject."
date: "2014-07-12"
categories:
  - "Tutoriales"
  - "Linux"
tags:
  - django
  - ubuntu
  - python
  - virtualenv
  - virtualenvwrapper
  - installation
locale: "es_MX"
keywords: "django, ubuntu 14.04, virtualenvwrapper, pip, python, instalación"
extra:
  deprecated: true
  deprecated_reason: "Ubuntu 14.04 llegó a fin de vida (LTS ESM terminó en 2022); instala python-pip de Python 2, que se removió en Ubuntu moderno. Django 1.6 también es EOL. El concepto de virtualenv sigue siendo válido, hoy con venv nativo de Python 3."
---

![El pony de Django](/static/images/posts/prepara_ubuntu_1404_para_django/magic-pony-django-wallpaper.png)


## Instala los paquetes

Primero hay que actualizar el sistema operativo:

```bash
sudo apt-get update && sudo apt-get upgrade
```

Hay que esperar un poco hasta que se descarguen e instalen todos los paquetes.
Tal vez quieras ir por algún café, o por té, o agua.

Hay veces que es necesario reiniciar Ubuntu, pero no siempre. En caso de duda,
reinícialo.

El siguiente paso es instalar algunas librerías de desarrollo y utilidades:


```bash
sudo apt-get install python-pip build-essential python-virtualenv virtualenvwrapper
```

Acá también va a tardar un poco dependiendo de tu internet y un poco de tu
máquina.

## Prueba Django

Vamos a usar
[virtualenvwrapper](https://virtualenvwrapper.readthedocs.io/en/latest/) para
instalar django en un entorno aislado donde los paquetes de Python que
instalemos con pip. Virtualenvwrapper requiere cierta configuración para que
pueda ser usado directamente en la consola; para que la configuración surta
efecto deberás cerrar la consola y abrirla de nuevo.

```bash
mkvirtualenv django
```

Esto es lo que salió en mi consola, en la tuya debería ocurrir algo parecido:

```bash
nnieto@vm001:~$ mkvirtualenv django
New python executable in django/bin/python
Installing setuptools, pip...done.
(django)nnieto@vm001:~$
```

El prompt de mi consola ha cambiado, ahora se le antepone `(django)`. El comando
`mkvirtualenv` inicializa el entorno virtual de Python inmediatamente después
de haberlo creado. La próxima vez que requieras trabajar en ese entorno virtual
de Python deberás usar el comando `workon` seguido del nombre del entorno
virtual, que en este caso es `django`. Como ejercicio, cierra la consola y
vuélvela a abrir. Ahora escribe:

```bash
workon django
```

A partir de ahora, una vez que hayas entrado en el entorno virtual de Python
podrás instalar paquetes de Python (*eggs*) sin miedo a causar algún conflicto
con los paquetes de Python instalados a nivel del sistema. Eso significa que
podemos tener varios entornos virtuales y en cada uno instalar versiones
diferentes (e incompatibles) en la misma máquina.

Ahora es momento de instalar Django:

```bash
pip install django
```

`pip` descargará e instalará Django. Vamos a seguir los pasos que recomienda el
tutorial de Django para probar esta instalación:

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

Y listo, ya está instalado Django dentro de un virtualenv.

**FIN**
