---
title: "Cómo correr GTG git en Fedora 20"
summary: "Compilar Getting Things GNOME! desde el repo Git en Fedora 20 con virtualenv."
description: "Pasos para compilar y ejecutar GTG desde el repositorio Git en Fedora 20 usando virtualenv con acceso a los site-packages globales."
date: "2014-08-11"
categories:
  - "Tutoriales"
  - "Linux"
tags:
  - fedora
  - gtg
  - getting-things-gnome
  - virtualenv
  - python
locale: "es_MX"
keywords: "gtg, getting things gnome, fedora 20, virtualenv, liblarch, python"
extra:
  deprecated: true
  deprecated_reason: "Fedora 20 llegó a fin de vida en 2015; las dependencias de GTG modernas son muy distintas (Python 3.11+, meson, GTK4) y python-cheetah está deprecado."
---

![Notas y cosas que hacer](/static/images/posts/compilar-gtg-en-fedora-20/memo-150388.png)

Me gusta GTG, pero quiero echarlo a andar en Fedora 20 desde el repo Git. Así
es como le hice.

## Instala estas dependencias:

```console
sudo yum install python-cheetah python-markdown python3-nose python3-pyxdg pygobject3 yelp
```

Haz un virtualenv, con python3 y acceso a global `site-packages`:

```console
mkvirtualenv --python=/usr/bin/python3 --system-site-packages gtg
```

## Entra al entorno de virtualenv

Si acabas de lanzar el comando anterior entonces no necesitas hacer nada. El
prompt se debería ver algo así:

```console
(gtg)nnieto@wks-nnieto gtg$
```

Pero hay veces que quieres correr otro comando en la consola con el mismo
virtualenv o quieres resumir una sesión de trabajo con GTG. Entonces usarás el
comando `workon`. Ve el ejemplo.

```console
nnieto@wks-nnieto ~$ workon gtg
(gtg)nnieto@wks-nnieto ~$
```

## Instalar `liblarch` en el virtualenv

Esta librería es una dependencia muy importante. Por fortuna fue fácil echarla
a andar. Primero clona el repo de github:

```console
git clone git@github.com:getting-things-gnome/liblarch.git
```

Luego instala la librería con setuptools:

```console
cd liblarch
python setup.py install
```

Finalmente hay que clonar gtg, instalar y ejecutar.

Así clonas:

```console
git clone git@github.com:getting-things-gnome/gtg.git
```

Así instalas:

```console
python setup.py install
```

Así lanzas gtg:

```console
gtg
```

Y así se ve:

![GTG git desde la consola de Fedora 20](/static/images/posts/compilar-gtg-en-fedora-20/screenshot-from-2014-08-11-17-46-09.png)

**FIN**

----
Ya no recuerdo de dónde saqué la foto de portada. Si alguien sabe avíseme para
poner bien los créditos.
