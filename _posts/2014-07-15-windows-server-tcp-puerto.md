---
title:  " Windows Server: ¿Cómo saber qué proceso esta usando un puerto TCP? "
categories: Español Windows Servers DevOps
---

![Cover](/media/3743184350_e992e763f5_o.jpg)

Estaba configurando Selenium Server en un Windows Server 2008 R2. Probé a
correrlo y, sin saberlo, arranque Selenium en modo
demonio/daemon/TSR/Servicio. Despues de eso, cada vez que intentaba arrancar
Selenium Server encontraba este error:

```powershell
PS C:\Selenium> java -jar .\selenium-server-standalone-2.42.2.jar
Jul 15, 2014 1:33:52 PM org.openqa.grid.selenium.GridLauncher main
INFO: Launching a standalone server
13:33:53.060 INFO - Java: Oracle Corporation 24.60-b09
13:33:53.061 INFO - OS: Windows Server 2008 R2 6.1 x86
13:33:53.070 INFO - v2.42.2, with Core v2.42.2. Built from revision 6a6995d
13:33:53.234 INFO - RemoteWebDriver instances should connect to: http://127.0.0.1:4444/wd/hub
13:33:53.236 INFO - Version Jetty/5.1.x
13:33:53.238 INFO - Started HttpContext[/selenium-server/driver,/selenium-server/driver]
13:33:53.239 INFO - Started HttpContext[/selenium-server,/selenium-server]
13:33:53.239 INFO - Started HttpContext[/,/]
13:33:53.289 INFO - Started org.openqa.jetty.jetty.servlet.ServletHandler@df416
13:33:53.290 INFO - Started HttpContext[/wd,/wd]
13:33:53.292 WARN - Failed to start: SocketListener0@0.0.0.0:4444
Exception in thread "main" java.net.BindException: Selenium is already running on port 4444. Or some other service is.
        at org.openqa.selenium.server.SeleniumServer.start(SeleniumServer.java:491)
        at org.openqa.selenium.server.SeleniumServer.boot(SeleniumServer.java:300)
        at org.openqa.selenium.server.SeleniumServer.main(SeleniumServer.java:245)
        at org.openqa.grid.selenium.GridLauncher.main(GridLauncher.java:95)
```

Si hay algun proceso que ya esta ocupando el puerto `4444`, ¿Cuál es ese
proceso?. Busque un poco en el internet y la respuesta es usando el comando
netstat asi:

```powershell
netstat -noa
```

El PID que esta usando el puerto `4444` es `1008`, y era un proceso de Java
(Ahí es cuando me di cuenta lo que había ocurrido). Maté el arbol de procesos
con el Administrador de Tareas y todo volvio a la normalidad.

---
Imagen del hacha: <https://flic.kr/p/6GLNid>

Attribution-ShareAlike 2.0 Generic (CC BY-SA 2.0)
