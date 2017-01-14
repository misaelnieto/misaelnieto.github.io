---
layout: post
title:  "Sublime 3 en Fedora 20"
date:   2014-02-07 19:02:10 -0700
categories: Español Linux Fedora
---

#Sublime 3 en Fedora 20


Quise instalar Sublime 3 sin usar la línea de comandos. Así es como le hice.

##Descargar Sublime

La página oficial de Sublime 3 es http://www.sublimetext.com/3. Tuve que
descargar la versión más reciente. Después descomprimí los archivos en la
carpeta `~/Applications/Sublime3`.


.. figure:: screenshot1.png
   :alt: Asi se ve mi carpeta de sublime 3


Puedo ejecutar Sublime 3 haciendo doble click en el icono lila con nombre
`sublime_text`.

Pero quiero poder lanzarlo desde el catálogo de actividades de GNOME 3.


##Hacer que aparezca en las actividades de GNOME 3

Sublime 3 ya trae un archivo con nombre `sublime_text.desktop`. Lo copié
a la carpeta `~/.local/share/applications` para que GNOME incluya a
Sublime como parte del catálogo de aplicaciones.

.. figure:: screencast1.gif
   :alt: Copiar el archivo `.desktop`

El archivo `.desktop` contiene la ruta hacia el binario ejecutable
`sublime_text` pero tuve que corregirla para que apunte a la carpeta
adecuada. También corregí la ruta al ícono de 255x256 pixeles, para que se vea
bonito.


.. figure:: screencast2.gif
   :alt: Copiar el archivo `.desktop`

Y listo. Ya sólo me falta saber como integrar sublime en el administrador de
archivos de GNOME.

