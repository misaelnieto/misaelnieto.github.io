---
title: Mi propia guía de instalación de Fedora 16
layout: post
---

![Julio Verne](/media/julio_verne.jpg)

## Intro

Actualizaciones:
* 13-Nov: El repo de dropbox no funciona bien, Problemas con PIL.
* 25-Nov: El paquete de VirtualBox de rpmfusion tiene problemas. Es mejor usar
el RPM de la web oficial de VirtualBox.

Esta guía es para relatarle a los 2 lectores de éste blog lo que uso para
desarrollar aplicaciones web hechas en Python. En caso de que esos 2 lectores
se den un paseo por `/dev/null` entonces lo dejo como una guía base para mi
cuando instale "Beefy Miracle" dentro de 1 año.

## Instalar fedora

Instalar Fedora es muy fácil. Bájate el ISO desde la web de
<http://www.fedoraproject.org>, quémalo en disco o en una usb e instala. No olvides
respaldar tus datos. Tengo una Dell Latitude D610 con 2.5 GB de RAM. La
instalación completa desde una memoria USB tomó alrededor de 20 minutos.

* Nota: Checa [LiveUSB Creator](http://www.linuxliveusb.com/) para hacer discos de instalación de USB.
* Nota: Lo instalé también en una Toshiba Satélite L645. Tuvimos problemas al particionar el disco duro. ¡Aguas!

## Instalar actualizaciones

Siempre se necesitan, justo después de instalar.

```bash
yum update -y
```

## Instalar librerías de desarrollo

Se necesitan compiladores y versiones de desarrollo de varias librerías. Y,
como ésto será una máquina de desarrollo de aplicaciones y sitios web con
python, también se instalan las librerías de desarrollo,
[virtualenv](http://pypi.python.org/pypi/virtualenv),
[pip](http://www.pip-installer.org/) y
[docutils](http://docutils.sourceforge.net/).

```bash
yum install -y python-devel python-setuptools python-virtualenv python-pip python-docutils make automake gcc gcc-c++ zlib-devel libxslt-devel openssl-devel ncurses-devel ncurses-devel mysql-devel libpng-devel libjpeg-turbo-devel
```

## Herramientas de colaboración (para desarrolladores)

Ya son imprescindibles. Uso varias de ellas: 
[mercurial](http://mercurial.selenic.com/),
[subversion](http://subversion.apache.org/), [git](http://git-scm.com/) y
[bazaar](http://bazaar.canonical.com/en/).
Tambien uso [rapidsvn](http://www.rapidsvn.org/) para ayudarme con algunos 
comandos de subversion.

Por último, [meld](http://meld.sourceforge.net/), es una excelente herramienta para checar diferencias y hacer
mezclas de código. Se integra muy bien con mercurial, subversion y git.

```bash
yum install -y mercurial subversion git bzr rapidsvn meld
```

## Bases de datos

Por el momento sólo uso MySQL. MySQL Workbench es una [fabulosa herramienta](http://www.mysql.com/products/workbench/)
para administrar la base de datos. Otra opción sería instalar php-myadmin,
pero necesitaría instalar todo el stack LAMP, así que mejor nos quedamos con
MySQL Workbench.

```bash
yum install -y mysql-server mysql-workbench
```

## VirtualBox

Uso VirtualBox para correr una copia pirata de Windoze XP y finalmente sacar
los bugs del infame Internet Explorer. Dentro de windows uso el 
[IETester](http://www.my-debugbar.com/wiki/IETester/HomePage) y me
ayuda mucho.

Primero, para evitar problemas, es necesario instalar las librerías de
desarrollo del Kernel. De lo contrario, el VirtualBox reportará muchos
problemas.

```bash
yum install -y dkms kernel-devel kernel-headers
```

Después, instala el RPM de VirtualBox desde la web oficial de <http://VirtualBox.org>.

*Nota*: No estamos usando el VirtualBox-OSE que ofrece rpmfusion, por que hasta
el dìa de hoy (25-Nov-2011), el rpm está mal formado y no incluye varios
archivos importantes, por ende el paquete no sirve para nada. El bug [ya está
reportado](https://bugzilla.rpmfusion.org/show_bug.cgi?id=1979).

## Herramientas de consola

Como editor, uso [emacs](http://www.gnu.org/s/emacs/) para editar archivos en la terminal. Para navegar por
carpetas, a veces uso el [midnight commander](https://www.midnight-commander.org/).

```bash
yum install -y mc emacs-nox
```

## Editores de texto y WingIDE

* [ghex](http://live.gnome.org/Ghex) como editor de texto hexadecimal.
* [Scribes]({% post_url 2011-07-30-scribes-a-beautiful-and-simple-text-editor-written-in-python %}) se tiene que instalar aparte desde <http://scribes.sourceforge.net/download.html>
* [gedit](http://projects.gnome.org/gedit/) ya viene instalado.
* emacs ya quedó instalado.
* Además de los editores anteriores, uso [WingIDE ](http://wingware.com/) para mis proyectos en Python.
Se instala aparte y, por desgracia, es de paga pero es muy bueno para
desarrollar apps en Python.


## Colaboración oficinesca  y cosas en la nube

Sólo los voy a listar, por que se instalan desde sitios externos (excepto el
xchat y el DèjáDup que ya viene incluido):

* [Dropbox](https://www.dropbox.com/) (Aunque Fedora ya trae [DéjàDup](http://live.gnome.org/DejaDup/), que parece que ofrece respaldo en la nube pero con tus propios recursos (por ejemplo, en Amazon S3, en RackSpace o en otra máquina por FTP, SSH, WebDav o carpeta local).
* [Skype](http://www.skype.com/)
* xchat o xchat-gnome

```bash
yum install -y xchat
```

## Chuleando el GNOME 3

El tema Adawita de Gnome 3.2 se ve un poco más pulido. O tal vez es que ya me
acostumbrè. Por otra parte, no recuerdo de dónde saqué estos paquetes que
estaban instalados en F15, pero los listo por si alguna vez se me antoja
chulear el shell.

* `faenza-icon-theme`
* `gnome-shell-extensions`
* `gnome-tweak-tool`

## Navegadores

* Google Chrome o Chromium. No parece que chromium esté disponible por default en los repos de fedora 16. Pero pasearte por la [página oficial](http://www.google.com.mx/chrome) y descargarte el RPM.
* Midori y/o [Epiphany](http://projects.gnome.org/epiphany/). Por ahí lei que Epiphany te permitiría anclar páginas web como si fueran aplicaciones web con su ventana independiente.

## Oficina y gráficos

De vez en cuando uso [LibreOffice](http://www.libreoffice.org/),
[Gimp](http://www.gimp.org/),
[Inkscape](http://inkscape.org/),
[Shutter](http://shutter-project.org/),
[Hamster](http://projecthamster.wordpress.com/),
[RecordMyDesktop](http://recordmydesktop.sourceforge.net/)
y [Get Things Gnome](http://gtg.fritalk.com/).
A continuaciòn el comando para instalar todo eso.

```
yum group install -y "Oficina y Productividad" && yum install -y gimp gimp-data-extras gimpfx-foundry inkscape shutter hamster-applet gtd gtk-recordmydesktop
```

*Nota*: A veces uso el Screen Recorder que gnome shell ya trae instalado. Se activa
con `Ctrl`+`Alt`+`Shift`+`R` y se desactiva con la misma combinaciòn de teclas. Pero a
veces es muy lento.

## Soluciones a problemas específicos en Fedora 16 Dropbox

Dropbox tiene un problema menor de compatibilidad con F16: no existe
repositorio para F16 en dropbox y la gran mayoría de las operaciones con
paquetes fallarán. En el foro de dropbox [ya se supo]()http://forums.dropbox.com/topic.php?id=47652&replies=4
de ésto. Y ya se está a la espera de que lo corrijan. Por mientras, pongo la
solución al español.

Por el momento se soluciona deshabilitando el repo de Dropbox al editar el
archivo `/etc/yum.repos.d/dropbox.repo` y añadiendo la línea `enabled=0`.

## PIL (Python Imaging Library) y archivos jpeg

Plone hace uso intensivo de PIL y generalmente instalo PIL 1.6 mediant
`zc.buildout`. Es por eso que es necesario que esten instaladas las librerías de
desarrollo que le dan soporte a JPG y PNG. No recuerdo si en Fedora 15 todavía
se usaba el paquete `libjpeg-dev`, pero en Fedora 16 parece que ha desaparecido
ese paquete y en su lugar se puede usar `libjpeg-turbo-devel`.

## Activar RPMFusion

Las directivas de Fedora prohiben incluir software que no es completamente
libre. Las restricciones se atañen principalmente a las leyes de Copyright de
Estados Unidos. Pero hay cierto software que no es Open Source, pero que es
útil. RpmFusion ofrece colección de paquetes de software compatibles para F15.

Sigue las instrucciones en [ésta página](http://rpmfusion.org/Configuration).

