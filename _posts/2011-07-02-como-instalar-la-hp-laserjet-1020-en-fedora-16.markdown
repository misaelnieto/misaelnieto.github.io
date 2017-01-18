---
title: Cómo instalar la HP LaserJet 1020 en Fedora 16
layout: post
categories: Linux Fedora
---

## Intro
Tenemos esta impresora desde hace años y funciona de maravilla. La instalación del driver de ésta impresora en Fedora 16 ha mejorado, pero aun no es plug&play.
Cómo instalar la HP LaserJet 1020 en Fedora 16

![HP LaserJet 1020](/media/hp_laserjet_1020.jpg)

Es una impresora que compró mi hermana o mi mamá y que tenía más de 2 años arrumbada.

## Problemas con el paquete foo2zjs de RPMFusion

Si tienes activado RPMFusion, deberás desactivarlo temporalmente y desisntalar
foo2zjs, pues, al parecer, si esta instalado la cola de la impresora no va a
funcionar. Ver el bug [#769127](https://bugzilla.redhat.com/show_bug.cgi?id=769127).

## Instala dependencias

Ejecuta esto en la terminal (Como `root`):

```bash
yum remove foo2zjs
yum install hplip-gui
```

Con esto se eliminará el paquete `foo2zjs` y se instala la utilería `hp-setup` como dependencia de `hplip-gui`.

## Ejecuta la utilería de configuración

Conecte la impresora y ejecute `hp-setup` como `root`. Aparecerá el siguiente
cuadro de diálogo.

Seleccione Universal Serial Bus (USB) como método de conexión y presione Next (Siguiente).

![Paso 1 - Seleccione USB](/media/hp_laserjet_device_discovery1.png)

La impresora deberá aparecer listada. Seleccione la impresora y presione Next.

![Paso 2 - Seleccione la impresora](/media/hp_laserjet_device_discovery2.png)

La impresora buscará los drivers disponibles y/o los descargará del sitio de
HP y finalmente los instalará en el sistema.

Finalmente, `hp-setup` nos ofrecerá la opción de instalar una cola de impresión
e imprimir una página de prueba.

![Finito](/media/hp_laserjet_device_discovery1.png)

Nota: no olvidar reactivar los repositorios de rpm-fusion.
