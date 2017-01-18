---
title: Cómo instalar la HP LaserJet 1020 en Fedora 15
layout: post
---

![HP LaserJet 1020](/media/hp_laserjet_1020.jpg)


## Descripción de la HP LaserJet 1020

Es una impresora que compró mi hermana o mi mamá y que tenía más de 2 años
arrumbada.

## Instalar dependencias

Ejecuta esto en la terminal:

```bash
sudo yum install tix foomatic\*
```

¿Y por qué? Pues por que si.

También vas a necesitar otros paquetes como `gcc`, pero como ya lo tenía
instalado y un montonal de paquetes de desarrollo también entonces ya no se
qué mas se necesite.

## Instalar foo2zjs

Esto me lo copie verbatim de la página de [`foo2zjs`](http://foo2zjs.rkkda.com/)
y le puse de mi propia cosecha. No seas huevón como yo, ahórrate unos 20 minutos de andar buscando en
google y lee el [`INSTALL`](http://foo2zjs.rkkda.com/INSTALL).

```bash
mkdir -p ~/Aplicaciones/DriverHP 
cd ~/Aplicaciones/DriverHP
wget -O foo2zjs.tar.gz http://foo2zjs.rkkda.com/foo2zjs.tar.gz
tar zxf foo2zjs.tar.gz
cd foo2zjs
make
./getweb 1020
sudo make install
rpm -e --nodeps system-config-printer-udev
sudo make install-hotplug
sudo make install cups
```

Cuando termine de ejecutarse todo eso ( y sin errores), desconecta la
impresora, apágala y reinicia la máquina.

Después de reiniciar la computadora enciende la impresora y conéctala a la
computadora. Abre la herramienta de configuración de impresoras (syste-config-
printer) y añade una impresora (Nota: acepta los defaults que te propone el
programita y escribe la contraseña mil veces por que te la va a pedir).

Listo.
