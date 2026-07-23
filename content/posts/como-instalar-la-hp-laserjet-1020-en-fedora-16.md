---
title: "Cómo instalar la HP LaserJet 1020 en Fedora 16"
date: "2011-07-02"
summary: "Con hplip-gui la LaserJet 1020 se instala con hp-setup; hay que desinstalar foo2zjs de RPMFusion para evitar el bug 769127."
description: "Guía para instalar la impresora HP LaserJet 1020 en Fedora 16 usando hplip-gui, solucionando problemas con el paquete foo2zjs."
categories:
  - "Linux"
tags:
  - fedora
  - hp-laserjet
  - hplip
  - rpmfusion
  - cups
locale: "es_MX"
keywords: "fedora 16, hp laserjet 1020, hplip-gui, hp-setup, rpmfusion, foo2zjs"
extra:
  deprecated: true
  deprecated_reason: "Fedora 16 es EOL; el bug 769127 de RPMFusion ya no aplica en versiones modernas"
---

## Intro

Tenemos esta impresora desde hace años y funciona de maravilla. La instalación
del driver de esta impresora en Fedora 16 ha mejorado, pero aún no es plug &
play.

![HP LaserJet 1020](/static/images/posts/como-instalar-la-hp-laserjet-1020-en-fedora-16/hp-laserjet-1020.jpg)

Es una impresora que compró mi hermana o mi mamá y que tenía más de 2 años
arrumbada.

## Problemas con el paquete foo2zjs de RPMFusion

Si tienes activado RPMFusion, deberás desactivarlo temporalmente y
desinstalar `foo2zjs`, pues al parecer, si está instalado, la cola de la
impresora no va a funcionar. Ver el bug
[#769127](https://bugzilla.redhat.com/show_bug.cgi?id=769127).

## Instala dependencias

Ejecuta esto en la terminal (como `root`):

```bash
yum remove foo2zjs
yum install hplip-gui
```

Con esto se eliminará el paquete `foo2zjs` y se instala la utilería `hp-setup`
como dependencia de `hplip-gui`.

## Ejecuta la utilería de configuración

Conecte la impresora y ejecute `hp-setup` como `root`. Aparecerá el siguiente
cuadro de diálogo.

Seleccione Universal Serial Bus (USB) como método de conexión y presione
*Next* (Siguiente).

![Paso 1 - Seleccione USB](/static/images/posts/como-instalar-la-hp-laserjet-1020-en-fedora-16/hp-laserjet-device-discovery1.png)

La impresora deberá aparecer listada. Seleccione la impresora y presione
*Next*.

![Paso 2 - Seleccione la impresora](/static/images/posts/como-instalar-la-hp-laserjet-1020-en-fedora-16/hp-laserjet-device-discovery2.png)

La impresora buscará los drivers disponibles y/o los descargará del sitio de
HP y finalmente los instalará en el sistema.

Finalmente, `hp-setup` nos ofrecerá la opción de instalar una cola de
impresión e imprimir una página de prueba.

![Finito](/static/images/posts/como-instalar-la-hp-laserjet-1020-en-fedora-16/hp-laserjet-device-discovery1.png)

**Nota:** no olvidar reactivar los repositorios de RPMFusion.
