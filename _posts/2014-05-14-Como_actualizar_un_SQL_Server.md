---
layout: post
title:  "¿Cómo actualizar un SQL Server?"
date:   2014-05-14 15:29:10 -0700
categories: SQL SQLServer
---

![Portada]({{ site.url }}/media/Wonder_Lake_Denali.jpg)

Primero se necesita saber qué version de SQL Server esta instalada.

Hay varias formas. Una es con el _Object Exporer_ de _Sql Server Management
Studio (SSMS)_. Al conectarse a la base de datos se puede ver la versión entre
paréntesis, al lado del nombre del servidor.

![Object Explorer de SSMS]({{ site.url }}/media/Screenshot_from_2014_05_14_15_41_34.png)

Tambien se puede sacar la ventana de de propiedades de la base de datos desde
el _Object Explorer_  y mirar el campo _Version_.

![Acceder a la ventana de propiedades]({{ site.url }}/media/Screenshot_from_2014_05_14_15_53_04.png)
![Revisar versión en la ventana de propiedades]({{ site.url }}/media/Screenshot_from_2014_05_14_15_53_03.png)

Otra opción más es hacer un sencillo query:

```sql
USE msdb;
SELECT @@SERVERNAME AS [Nombre del servidor], @@VERSION AS [Version];
GO
```
En mi caso, el resultado es:

```
Microsoft SQL Server 2012 (SP1) - 11.0.3128.0 (X64)
    Dec 28 2012 20:23:12
    Copyright (c) Microsoft Corporation
    Enterprise Evaluation Edition (64-bit) on Windows NT 6.2  (Build 9200:)
```

Después de saber la versión del servidor, fui a consultar el blog
[sql builds](http://sqlserverbuilds.blogspot.mx/):  y busqué la version
especifica de mi servidor. En mi caso la version reportada era `11.0.3128.0` y
la encontre como `11.00.3128`. Seguí la lista hacia arriba y el último
_Cumulative Update (CU)_ publicado al 18 de Marzo del 2014 (en la fecha en la
que hice este blog) fue el `2931078` y el título es: "_Cumulative update
package 9 for SQL Server 2012 Service Pack 1_". Este CU ofrece cuatro
descargas. A mi solo me interesa la de SQL Server; esta tiene el nombre de
`SQLServer2012_SP1_CU9_2931078_11_0_3412_x64`.

Para bajar el CU me pidieron mi direccion de correo electrónico y que
demostrara que no soy un robot. Después me mandaron el link de descarga en mi
correo.

Tuve que refunfuñar algo con Internet Explorer de Windows 2012R2. Su
configuracion de seguridad avanzada es bastante molesta y hace que el
navegador sea casi inútil. Tuve que mover varios controles hasta que me dejara
descargar el CU.

El CU es un exe que trae otro exe comprimido. Descomprimí el CU al directorio
`C:\Updates` y cuando lo ejecuté resultó que extrajo más archivos. Creo que a
los de Microsoft les gustan las Matrioskas.

![A alguien en Microsoft le gustan las Matrioskas]({{ site.url }}/media/First_matryoshka_museum_doll_open_0.jpg)

Despues de un rato de estar desparramando archivos por ahí, comienza el
proceso de de instalación del CU. Este proceso es bastante aburrido.

Basicamente es esperar a que salga el instalador de SQL Server, ...

![¡¡¡Aburrido!!!]({{ site.url }}/media/Screenshot_from_2014_05_14_17_47_32.png)

... aceptar que le vendes tu alma al chamuco, ...

![Aceptar la licencia]({{ site.url }}/media/Screenshot_from_2014_05_14_17_49_45.png)

... y darle next, next, next por que no hay otra opción.

Despues de un rato de hacer su chamba, el instalador termina reportando lo que
ha salido mal y lo que ha salido bien. En mi caso todo salió bien. Reinicié el
servidor para no tener dudas de que todo funciona al 100%. Finalmente, el
Object Explorer del SSMS  muestra la nueva version de SQL Server 2012.

![SQL Version 11.00.3412SQL Version 11.00.3412 :)]({{ site.url }}/media/Screenshot_from_2014_05_15_08_17_18.png)

Esta version corresponde al [2931078 Cumulative update package 9 (CU9) for SQL
Server 2012 Service Pack 1](http://support.microsoft.com/kb/2931078/en-us).

Y eso es todo.

P.D. Esta página en inglés es la que leí antes de hacer este post.

https://sqlserverperformance.wordpress.com/2011/01/12/how-to-obtain-and-install-sql-server-service-packs-and-cumulative-updates/

