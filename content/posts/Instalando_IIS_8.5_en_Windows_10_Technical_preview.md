---
title: "Instalando IIS 8.5 en Windows 10 Technical preview"
date: "2015-01-16"
categories:
  - "Windows IIS"
tags:
  - iis
  - windows
  - windows 10
  - web server
---

![Página de bienvenida de IIS 8.5](/static/images/Screenshot_from_2015_01_16_17_47_30.png)

Instalé *Windows 10 Technical Preview* en una maquina virtual y quise ver
cómo funciona con IIS. Es bastante sencillo y muy similar a la instalacion de
IIS en cualquier otro Windows.

Comenzamos por abrir el menu de windows y en la barra de búsqueda escribe "`Add
or remove Programs`".

![Add or remove Programs](/static/images/Screenshot_from_2015_01_16_17_15_34.png)

Abre el primer icono, el que sale hasta arriba. Inmediatamente despues va a
aparecer la ventana de `Programs and Features`. Deberás seleccionar `Turn Windows
Features on or off`. Checa la imagen para que veas en dónde esta.

![Ventana `Program and Features`; Pícale en Turn Windows features on or off.](/static/images/Screenshot_from_2015_01_16_17_16_05.png)

Inmediatamente va a aparecer otra ventana, la de `Windows Features`. Tiene una
lista de opciones. Ponle palomita a `Internet Information Services`.

![Habilita IIS. Pícale en la cajita de `Internet Information Services`.](/static/images/Screenshot_from_2015_01_16_17_14_13.png)

Presiona OK y espera unos minutos en lo que Windoze hace su magia e instala y
configura IIS.

![Proceso de instalacion de IIS](/static/images/Screenshot_from_2015_01_16_17_14_29.png)

Se paciente. No se si descarga cosas del internet, pero tarda un rato en
completar.

Finalmente, despues de que termina la instalacion ya podemos lanzar la consola
de administracion de IIS seleccionando `Internet Information Services (IIS)
Manager` desde el menu de inicio.

![Consola de admin de IIS](/static/images/Screenshot_from_2015_01_16_17_17_44_1.png)

La version instalada es la `8.5.9841.0`

![Esta es la version reportada en mi IIS](/static/images/Screenshot_from_2015_01_16_17_49_59.png)

Y eso es todo por el momento.

---
Todas las imagenes son mias.