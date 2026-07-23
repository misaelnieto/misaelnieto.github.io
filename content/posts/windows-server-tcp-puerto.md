---
title: "Windows Server: ¿Cómo saber qué proceso está usando un puerto TCP?"
summary: "Cómo identificar el proceso que mantiene ocupado un puerto con netstat -noa."
description: "Cómo identificar el proceso que mantiene ocupado un puerto TCP en Windows Server usando netstat -noa para obtener el PID y matarlo desde el Administrador de Tareas."
date: "2014-07-15"
categories:
  - "Tutoriales"
  - "DevOps"
tags:
  - windows-server
  - netstat
  - troubleshooting
  - puertos
  - tcp
locale: "es_MX"
keywords: "windows server, netstat, puerto tcp, pid, selenium, troubleshooting"
---

![Cover](/static/images/posts/windows-server-tcp-puerto/3743184350_e992e763f5_o.jpg)

Estaba configurando Selenium Server en un Windows Server 2008 R2. Probé a
correrlo y, sin saberlo, arranqué Selenium en modo
demonio/daemon/TSR/Servicio. Después de eso, cada vez que intentaba arrancar
Selenium Server encontraba este error:

```powershell
PS C:\Selenium> java -jar .\selenium-server-standalone-2.42.2.jar
Jul 15, 2014 1:33:52 PM org.openqa.grid.selenium.GridLauncher main
INFO: Launching a standalone server
13:33:53.060 INFO - Java: Oracle Corporation 24.60-b09
13:33:53.061 INFO - OS: Windows Server 2008 R2 6.1 x86
...
13:33:53.292 WARN - Failed to start: SocketListener0@0.0.0.0:4444
Exception in thread "main" java.net.BindException: Selenium is already running on port 4444. Or some other service is.
```

Si hay algún proceso que ya está ocupando el puerto `4444`, ¿cuál es ese
proceso? Busqué un poco en el internet y la respuesta es usando el comando
`netstat` así:

```powershell
netstat -noa
```

El PID que está usando el puerto `4444` es `1008`, y era un proceso de Java
(ahí es cuando me di cuenta lo que había ocurrido). Maté el árbol de procesos
con el Administrador de Tareas y todo volvió a la normalidad.

---
Imagen del hacha: <https://flic.kr/p/6GLNid>

Attribution-ShareAlike 2.0 Generic (CC BY-SA 2.0)
