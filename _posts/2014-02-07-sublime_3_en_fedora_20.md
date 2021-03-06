---
title:  "Sublime 3 en Fedora 20"
categories: Linux Fedora
redirect_from: /blog/html/2014/02/07/sublime_3_en_fedora_20
---

Quise instalar Sublime 3 sin usar la línea de comandos. Así es como le hice.

## Descargar Sublime

La página oficial de Sublime 3 es http://www.sublimetext.com/3. Tuve que
descargar la versión más reciente. Después descomprimí los archivos en la
carpeta `~/Applications/Sublime3`.

![Asi se ve mi carpeta de sublime 3]({{ site.url }}/media/screenshot1.png)

Puedo ejecutar Sublime 3 haciendo doble click en el icono lila con nombre
`sublime_text`. Pero quiero poder lanzarlo desde el catálogo de actividades de
GNOME 3.


## Hacer que aparezca en las actividades de GNOME 3

Sublime 3 ya trae un archivo con nombre `sublime_text.desktop`. Lo copié
a la carpeta `~/.local/share/applications` para que GNOME incluya a
Sublime como parte del catálogo de aplicaciones.

![Copiar el archivo .desktop]({{ site.url }}/media/screencast1.gif)

El archivo `.desktop` contiene la ruta hacia el binario ejecutable
`sublime_text` pero tuve que corregirla para que apunte a la carpeta adecuada.
También corregí la ruta al ícono de 255x256 pixeles, para que se vea bonito.


![Copiar el archivo .desktop]({{ site.url }}/media/screencast2.gif)

Y listo. Ya sólo me falta saber como integrar sublime en el administrador de
archivos de GNOME.

