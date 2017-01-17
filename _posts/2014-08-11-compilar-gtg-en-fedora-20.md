---
title:  " Como correr GTG git en Fedora 20 "
categories: Linux Fedora Gnome GTG
---

![Notas y cosas que hacer](/media/memo-150388.png)


Me gusta GTG, pero quiero echarlo a andar en Fedora 20 desde el repo Git. Así es como le hice.

## Instala estas dependencias:

```console
sudo yum install python-cheetah python-markdown python3-nose python3-pyxdg pygobject3 yelp
```

Haz un virtualenv, con python3 y acceso a global `site-packages`

```console
mkvirtualenv --python=/usr/bin/python3 --system-site-packages gtg
```

## Entra al entorno de virtualenv

Si acabas de lanzar el comando anterior entonces no necesitas hacer nada. El prompt se debería ver algo asi:

```console
(gtg)nnieto@wks-nnieto gtg$
```

Pero hay veces que quieres correr otro comando en la consola con el mismo virtualenv o quieres resumir una sesion de trabajo con GTG. Entonces usaras el comando workon. Ve ele ejemplo.

```console
nnieto@wks-nnieto ~$ workon gtg
(gtg)nnieto@wks-nnieto ~$
```

## Instalar `liblarch` en el virtualenv

Esta libreria es una dependencia muy importante. Por fortuna fue facil echarla
a andar. Primero clona el repo de github

```console
git clonegit@github.com:getting-things-gnome/liblarch.git
```

Luego instala la libreria con setuptools:

```console
cd liblarch
python setup.py install
```

Finalmente hay que clonar gtg, instalar y ejecutar

Así clonas:

```console
git clone git@github.com:getting-things-gnome/gtg.git
```

Así instalas

```console
python setup.py install
```

Así lanzas gtg:

```console
gtg
```

Y así se ve:

![GTG git desde Fedora 20GTG git desde la consola de Fedora 20](/media/Screenshot_from_2014_08_11_17_46_09.png)

Fin.

----
Ya no recuerdo de dónde saqué la foto de portada. Si alguien sabe avíseme para
poner bien los créditos.
