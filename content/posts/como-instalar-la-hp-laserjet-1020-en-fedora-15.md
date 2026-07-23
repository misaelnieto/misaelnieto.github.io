---
title: "Cómo instalar la HP LaserJet 1020 en Fedora 15"
date: "2011-07-01"
summary: "Driver foo2zjs compilado a mano para hacer funcionar una HP LaserJet 1020 arrumbada en Fedora 15."
description: "Pasos para compilar foo2zjs desde la fuente y configurar la HP LaserJet 1020 en Fedora 15 con system-config-printer."
categories:
  - "Linux"
tags:
  - fedora
  - hp-laserjet
  - foo2zjs
  - cups
  - driver
locale: "es_MX"
keywords: "fedora 15, hp laserjet 1020, foo2zjs, foomatic, system-config-printer"
extra:
  deprecated: true
  deprecated_reason: "Fedora 15 es EOL; hplip moderno detecta la LaserJet 1020 sin compilar foo2zjs"
---

![HP LaserJet 1020](/static/images/posts/como-instalar-la-hp-laserjet-1020-en-fedora-15/hp-laserjet-1020.jpg)

## Descripción de la HP LaserJet 1020

Es una impresora que compró mi hermana o mi mamá y que tenía más de 2 años
arrumbada.

## Instalar dependencias

Ejecuta esto en la terminal:

```bash
sudo yum install tix foomatic\*
```

¿Y por qué? Pues por qué sí.

También vas a necesitar otros paquetes como `gcc`, pero como ya lo tenía
instalado y un montonal de paquetes de desarrollo también, entonces ya no sé
qué más se necesite.

## Instalar foo2zjs

Esto me lo copié verbatim de la página de [`foo2zjs`](http://foo2zjs.rkkda.com/)
y le puse de mi propia cosecha. No seas huevón como yo, ahórrate unos 20 minutos
de andar buscando en Google y lee el [`INSTALL`](http://foo2zjs.rkkda.com/INSTALL).

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

Cuando termine de ejecutarse todo eso (y sin errores), desconecta la
impresora, apágala y reinicia la máquina.

Después de reiniciar la computadora, enciende la impresora y conéctala a la
computadora. Abre la herramienta de configuración de impresoras
(`system-config-printer`) y añade una impresora (nota: acepta los defaults que
te propone el programita y escribe la contraseña mil veces porque te la va a
pedir).

Listo.
