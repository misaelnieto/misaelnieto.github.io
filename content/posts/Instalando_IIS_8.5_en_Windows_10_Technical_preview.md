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

![Página de bienvenida de IIS 8.5](/static/images/posts/Instalando_IIS_8.5_en_Windows_10_Technical_preview/screenshot-from-2015-01-16-17-47-30.png)

Instalé *Windows 10 Technical Preview* en una maquina virtual y quise ver
cómo funciona con IIS. Es bastante sencillo y muy similar a la instalacion de
IIS en cualquier otro Windows.

Comenzamos por abrir el menu de windows y en la barra de búsqueda escribe "`Add
or remove Programs`".

![Add or remove Programs](/static/images/posts/Instalando_IIS_8.5_en_Windows_10_Technical_preview/screenshot-from-2015-01-16-17-15-34.png)

Abre el primer icono, el que sale hasta arriba. Inmediatamente despues va a
aparecer la ventana de `Programs and Features`. Deberás seleccionar `Turn Windows
Features on or off`. Checa la imagen para que veas en dónde esta.

![Ventana `Program and Features`; Pícale en Turn Windows features on or off.](/static/images/posts/Instalando_IIS_8.5_en_Windows_10_Technical_preview/screenshot-from-2015-01-16-17-16-05.png)

Inmediatamente va a aparecer otra ventana, la de `Windows Features`. Tiene una
lista de opciones. Ponle palomita a `Internet Information Services`.

![Habilita IIS. Pícale en la cajita de `Internet Information Services`.](/static/images/posts/Instalando_IIS_8.5_en_Windows_10_Technical_preview/screenshot-from-2015-01-16-17-14-13.png)

Presiona OK y espera unos minutos en lo que Windoze hace su magia e instala y
configura IIS.

![Proceso de instalacion de IIS](/static/images/posts/Instalando_IIS_8.5_en_Windows_10_Technical_preview/screenshot-from-2015-01-16-17-14-29.png)

Se paciente. No se si descarga cosas del internet, pero tarda un rato en
completar.

Finalmente, despues de que termina la instalacion ya podemos lanzar la consola
de administracion de IIS seleccionando `Internet Information Services (IIS)
Manager` desde el menu de inicio.

![Consola de admin de IIS](/static/images/posts/Instalando_IIS_8.5_en_Windows_10_Technical_preview/screenshot-from-2015-01-16-17-17-44-1.png)

La version instalada es la `8.5.9841.0`

![Esta es la version reportada en mi IIS](/static/images/posts/Instalando_IIS_8.5_en_Windows_10_Technical_preview/screenshot-from-2015-01-16-17-49-59.png)

Y eso es todo por el momento.

---
Todas las imagenes son mias.