---
title: "Instalar IIS 8.5 en Windows 10 Technical Preview"
summary: "Pasos para habilitar IIS 8.5 desde Windows Features en Windows 10 Technical Preview."
description: "Tutorial paso a paso para instalar y habilitar IIS 8.5 en Windows 10 Technical Preview vía Windows Features, con capturas de pantalla del proceso completo."
date: "2015-01-16"
categories:
  - "Tutoriales"
  - "DevOps"
tags:
  - iis
  - windows
  - windows-10
  - web-server
  - microsoft
locale: "es_MX"
keywords: "IIS 8.5, Windows 10 Technical Preview, Windows Features, Internet Information Services, web server"
extra:
  deprecated: true
  deprecated_reason: "Windows 10 Technical Preview fue reemplazado por versiones RTM (22H2, etc.); las versiones modernas traen IIS 10. Los pasos son similares pero las screenshots ya no coinciden."
---

![Página de bienvenida de IIS 8.5](/static/images/posts/Instalando_IIS_8.5_en_Windows_10_Technical_preview/screenshot-from-2015-01-16-17-47-30.png)

Instalé *Windows 10 Technical Preview* en una máquina virtual y quise ver
cómo funciona con IIS. Es bastante sencillo y muy similar a la instalación de
IIS en cualquier otro Windows.

Comenzamos por abrir el menú de Windows y en la barra de búsqueda escribe
`Add or remove Programs`.

![Add or remove Programs](/static/images/posts/Instalando_IIS_8.5_en_Windows_10_Technical_preview/screenshot-from-2015-01-16-17-15-34.png)

Abre el primer ícono, el que sale hasta arriba. Inmediatamente después va a
aparecer la ventana de `Programs and Features`. Deberás seleccionar `Turn
Windows Features on or off`. Checa la imagen para que veas en dónde está.

![Ventana `Programs and Features`; pícale en `Turn Windows features on or off`.](/static/images/posts/Instalando_IIS_8.5_en_Windows_10_Technical_preview/screenshot-from-2015-01-16-17-16-05.png)

Inmediatamente va a aparecer otra ventana, la de `Windows Features`. Tiene una
lista de opciones. Ponle palomita a `Internet Information Services`.

![Habilita IIS. Pícale en la cajita de `Internet Information Services`.](/static/images/posts/Instalando_IIS_8.5_en_Windows_10_Technical_preview/screenshot-from-2015-01-16-17-14-13.png)

Presiona OK y espera unos minutos en lo que Windoze hace su magia e instala y
configura IIS.

![Proceso de instalación de IIS](/static/images/posts/Instalando_IIS_8.5_en_Windows_10_Technical_preview/screenshot-from-2015-01-16-17-14-29.png)

Sé paciente. No sé si descarga cosas del internet, pero tarda un rato en
completar.

Finalmente, después de que termina la instalación ya podemos lanzar la
consola de administración de IIS seleccionando `Internet Information Services
(IIS) Manager` desde el menú de inicio.

![Consola de admin de IIS](/static/images/posts/Instalando_IIS_8.5_en_Windows_10_Technical_preview/screenshot-from-2015-01-16-17-17-44-1.png)

La versión instalada es la `8.5.9841.0`:

![Esta es la versión reportada en mi IIS](/static/images/posts/Instalando_IIS_8.5_en_Windows_10_Technical_preview/screenshot-from-2015-01-16-17-49-59.png)

Y eso es todo por el momento.

---
Todas las imágenes son mías.

**FIN**
