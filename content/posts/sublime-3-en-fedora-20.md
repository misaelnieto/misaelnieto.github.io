---
title: "Sublime 3 en Fedora 20"
date: "2014-02-07"
summary: "Instalar Sublime 3 sin tocar la terminal en Fedora 20."
description: "Cómo instalar Sublime 3 en Fedora 20 sin usar la terminal, integrándolo en el catálogo de aplicaciones de GNOME 3."
categories:
  - "Linux"
tags:
  - fedora
  - sublime-text
  - sublime-text-3
  - gnome
locale: "es_MX"
keywords: "sublime text 3, fedora 20, gnome 3, escritorio, instalacion"
extra:
  deprecated: true
  deprecated_reason: "Fedora 20 es EOL; Sublime Text 4 actual tiene instalador nativo y se distribuye vía Snap/dnf en distros modernas."
---

Quise instalar Sublime 3 sin usar la línea de comandos. Así es como le hice.

## Descargar Sublime

La página oficial de Sublime 3 es <http://www.sublimetext.com/3>. Tuve que
descargar la versión más reciente. Después descomprimí los archivos en la
carpeta `~/Applications/Sublime3`.

![Así se ve mi carpeta de sublime 3](/static/images/posts/sublime_3_en_fedora_20/screenshot1.png)

Puedo ejecutar Sublime 3 haciendo doble click en el icono lila con nombre
`sublime_text`. Pero quiero poder lanzarlo desde el catálogo de actividades de
GNOME 3.


## Hacer que aparezca en las actividades de GNOME 3

Sublime 3 ya trae un archivo con nombre `sublime_text.desktop`. Lo copié
a la carpeta `~/.local/share/applications` para que GNOME incluya a
Sublime como parte del catálogo de aplicaciones.

![Copiar el archivo .desktop](/static/images/posts/sublime_3_en_fedora_20/screencast1.gif)

El archivo `.desktop` contiene la ruta hacia el binario ejecutable
`sublime_text` pero tuve que corregirla para que apunte a la carpeta adecuada.
También corregí la ruta al ícono de 255×256 pixeles, para que se vea bonito.


![Copiar el archivo .desktop](/static/images/posts/sublime_3_en_fedora_20/screencast2.gif)

Y listo. Ya solo me falta saber cómo integrar Sublime en el administrador de
archivos de GNOME.

**FIN**
