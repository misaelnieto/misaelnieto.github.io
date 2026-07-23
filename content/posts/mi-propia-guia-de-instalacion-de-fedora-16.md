---
title: "Mi propia guía de instalación de Fedora 16"
date: "2011-10-11"
summary: "El checklist que uso para dejar lista Fedora 16 para desarrollo Python: build-essentials, VCS, bases de datos y editores."
description: "Guía personal de post-instalación de Fedora 16 para desarrollo web con Python: compiladores, virtualenv, VCS, MySQL, VirtualBox y editores."
categories:
  - "Tutoriales"
  - "Linux"
tags:
  - fedora
  - fedora-16
  - setup
  - development
  - yum
locale: "es_MX"
keywords: "fedora 16, instalación, python-devel, virtualenv, mysql, virtualbox, wingide, rpmfusion"
extra:
  deprecated: true
  deprecated_reason: "Fedora 16 es EOL (diciembre 2012); yum fue reemplazado por dnf en Fedora 22+"
---

![Julio Verne](/static/images/posts/mi-propia-guia-de-instalacion-de-fedora-16/julio-verne.jpg)

## Intro

**Actualizaciones:**

* 13-Nov: El repo de Dropbox no funciona bien, problemas con PIL.
* 25-Nov: El paquete de VirtualBox de RPMFusion tiene problemas. Es mejor usar el RPM de la web oficial de VirtualBox.

Esta guía es para relatarle a los 2 lectores de este blog lo que uso para
desarrollar aplicaciones web hechas en Python. En caso de que esos 2 lectores
se den un paseo por `/dev/null`, entonces lo dejo como una guía base para mí
cuando instale "Beefy Miracle" dentro de 1 año.

## Instalar Fedora

Instalar Fedora es muy fácil. Bájate el ISO desde la web de
<http://www.fedoraproject.org>, quémalo en disco o en una USB e instala. No
olvides respaldar tus datos. Tengo una Dell Latitude D610 con 2.5 GB de RAM.
La instalación completa desde una memoria USB tomó alrededor de 20 minutos.

* **Nota:** Checa [LiveUSB Creator](http://www.linuxliveusb.com/) para hacer discos de instalación de USB.
* **Nota:** Lo instalé también en una Toshiba Satellite L645. Tuvimos problemas al particionar el disco duro. ¡Aguas!

## Instalar actualizaciones

Siempre se necesitan, justo después de instalar.

```bash
yum update -y
```

## Instalar librerías de desarrollo

Se necesitan compiladores y versiones de desarrollo de varias librerías. Y,
como esto será una máquina de desarrollo de aplicaciones y sitios web con
Python, también se instalan las librerías de desarrollo,
[virtualenv](http://pypi.python.org/pypi/virtualenv),
[pip](http://www.pip-installer.org/) y
[docutils](http://docutils.sourceforge.net/).

```bash
yum install -y python-devel python-setuptools python-virtualenv python-pip python-docutils make automake gcc gcc-c++ zlib-devel libxslt-devel openssl-devel ncurses-devel ncurses-devel mysql-devel libpng-devel libjpeg-turbo-devel
```

## Herramientas de colaboración (para desarrolladores)

Ya son imprescindibles. Uso varias de ellas:
[Mercurial](http://mercurial.selenic.com/),
[Subversion](http://subversion.apache.org/), [Git](http://git-scm.com/) y
[Bazaar](http://bazaar.canonical.com/en/).
También uso [RapidSVN](http://www.rapidsvn.org/) para ayudarme con algunos
comandos de Subversion.

Por último, [Meld](http://meld.sourceforge.net/) es una excelente herramienta
para checar diferencias y hacer mezclas de código. Se integra muy bien con
Mercurial, Subversion y Git.

```bash
yum install -y mercurial subversion git bzr rapidsvn meld
```

## Bases de datos

Por el momento sólo uso MySQL. MySQL Workbench es una
[fabulosa herramienta](http://www.mysql.com/products/workbench/) para
administrar la base de datos. Otra opción sería instalar phpMyAdmin, pero
necesitaría instalar todo el stack LAMP, así que mejor nos quedamos con MySQL
Workbench.

```bash
yum install -y mysql-server mysql-workbench
```

## VirtualBox

Uso VirtualBox para correr una copia pirata de Windoze XP y finalmente sacar
los bugs del infame Internet Explorer. Dentro de Windows uso el
[IETester](http://www.my-debugbar.com/wiki/IETester/HomePage) y me ayuda
mucho.

Primero, para evitar problemas, es necesario instalar las librerías de
desarrollo del Kernel. De lo contrario, VirtualBox reportará muchos problemas.

```bash
yum install -y dkms kernel-devel kernel-headers
```

Después, instala el RPM de VirtualBox desde la web oficial de
<http://VirtualBox.org>.

**Nota:** No estamos usando el VirtualBox-OSE que ofrece RPMFusion, porque
hasta el día de hoy (25-Nov-2011), el RPM está mal formado y no incluye varios
archivos importantes, por ende el paquete no sirve para nada. El bug
[ya está reportado](https://bugzilla.rpmfusion.org/show_bug.cgi?id=1979).

## Herramientas de consola

Como editor, uso [Emacs](http://www.gnu.org/s/emacs/) para editar archivos en
la terminal. Para navegar por carpetas, a veces uso el
[Midnight Commander](https://www.midnight-commander.org/).

```bash
yum install -y mc emacs-nox
```

## Editores de texto y WingIDE

* [ghex](http://live.gnome.org/Ghex) como editor de texto hexadecimal.
* [Scribes](/blog/scribes-a-beautiful-and-simple-text-editor-written-in-python) se tiene que instalar aparte desde <http://scribes.sourceforge.net/download.html>
* [gedit](http://projects.gnome.org/gedit/) ya viene instalado.
* Emacs ya quedó instalado.
* Además de los editores anteriores, uso [WingIDE](http://wingware.com/) para mis proyectos en Python. Se instala aparte y, por desgracia, es de paga pero es muy bueno para desarrollar apps en Python.

## Colaboración oficinesca y cosas en la nube

Sólo los voy a listar, porque se instalan desde sitios externos (excepto el
xchat y el Déjà Dup que ya viene incluido):

* [Dropbox](https://www.dropbox.com/) (aunque Fedora ya trae [Déjà Dup](http://live.gnome.org/DejaDup/), que ofrece respaldo en la nube con tus propios recursos — por ejemplo, Amazon S3, Rackspace u otra máquina por FTP, SSH, WebDAV o carpeta local).
* [Skype](http://www.skype.com/)
* xchat o xchat-gnome

```bash
yum install -y xchat
```

## Chuleando el GNOME 3

El tema Adwaita de GNOME 3.2 se ve un poco más pulido. O tal vez es que ya me
acostumbré. Por otra parte, no recuerdo de dónde saqué estos paquetes que
estaban instalados en F15, pero los listo por si alguna vez se me antoja
chulear el shell.

* `faenza-icon-theme`
* `gnome-shell-extensions`
* `gnome-tweak-tool`

## Navegadores

* Google Chrome o Chromium. No parece que Chromium esté disponible por default en los repos de Fedora 16. Mejor pásate por la [página oficial](http://www.google.com.mx/chrome) y descarga el RPM.
* Midori y/o [Epiphany](http://projects.gnome.org/epiphany/). Por ahí leí que Epiphany te permitiría anclar páginas web como si fueran aplicaciones con su ventana independiente.

## Oficina y gráficos

De vez en cuando uso [LibreOffice](http://www.libreoffice.org/),
[Gimp](http://www.gimp.org/),
[Inkscape](http://inkscape.org/),
[Shutter](http://shutter-project.org/),
[Hamster](http://projecthamster.wordpress.com/),
[RecordMyDesktop](http://recordmydesktop.sourceforge.net/) y
[Getting Things GNOME](http://gtg.fritalk.com/).
A continuación el comando para instalar todo eso.

```
yum group install -y "Oficina y Productividad" && yum install -y gimp gimp-data-extras gimpfx-foundry inkscape shutter hamster-applet gtd gtk-recordmydesktop
```

**Nota:** A veces uso el *Screen Recorder* que GNOME Shell ya trae
instalado. Se activa con `Ctrl` + `Alt` + `Shift` + `R` y se desactiva con
la misma combinación de teclas. Pero a veces es muy lento.

## Soluciones a problemas específicos en Fedora 16

### Dropbox

Dropbox tiene un problema menor de compatibilidad con F16: no existe
repositorio para F16 en Dropbox y la gran mayoría de las operaciones con
paquetes fallarán. En el foro de Dropbox
[ya se supo](http://forums.dropbox.com/topic.php?id=47652&replies=4) de esto.
Y ya se está a la espera de que lo corrijan. Por mientras, pongo la solución
al español.

Por el momento se soluciona deshabilitando el repo de Dropbox al editar el
archivo `/etc/yum.repos.d/dropbox.repo` y añadiendo la línea `enabled=0`.

### PIL (Python Imaging Library) y archivos jpeg

Plone hace uso intensivo de PIL y generalmente instalo PIL 1.6 mediante
`zc.buildout`. Es por eso que es necesario que estén instaladas las librerías
de desarrollo que le dan soporte a JPG y PNG. No recuerdo si en Fedora 15
todavía se usaba el paquete `libjpeg-dev`, pero en Fedora 16 parece que ha
desaparecido ese paquete y en su lugar se puede usar `libjpeg-turbo-devel`.

## Activar RPMFusion

Las directivas de Fedora prohíben incluir software que no es completamente
libre. Las restricciones se atañen principalmente a las leyes de copyright de
Estados Unidos. Pero hay cierto software que no es Open Source, pero que es
útil. RPMFusion ofrece una colección de paquetes de software compatibles para
F16.

Sigue las instrucciones en [esta página](http://rpmfusion.org/Configuration).

**FIN**
