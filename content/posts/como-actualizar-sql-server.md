---
title: "¿Cómo actualizar un SQL Server?"
date: "2014-05-14"
summary: "Identificar versión y aplicar el Cumulative Update correcto en SQL Server."
description: "Guía paso a paso para identificar la versión actual de SQL Server y aplicar el Cumulative Update correspondiente."
categories:
  - "Bases de datos"
tags:
  - sql-server
  - sqlserver
  - cumulative-update
  - ssms
  - windows-server
locale: "es_MX"
keywords: "sql server, cumulative update, ssms, sqlserverbuilds, version, patch"
extra:
  deprecated: true
  deprecated_reason: "SQL Server 2012 SP1 es EOL; los enlaces de soporte de Microsoft para KB específicas suelen cambiar; el flujo general sigue siendo el mismo pero los detalles específicos (CU9) están obsoletos."
---

![Portada](/static/images/posts/como-actualizar-sql-server/wonder-lake-denali.jpg)

Primero se necesita saber qué versión de SQL Server está instalada.

Hay varias formas. Una es con el *Object Explorer* de *SQL Server Management
Studio (SSMS)*. Al conectarse a la base de datos se puede ver la versión entre
paréntesis, al lado del nombre del servidor.

![Object Explorer de SSMS](/static/images/posts/como-actualizar-sql-server/screenshot-from-2014-05-14-15-41-34.png)

También se puede sacar la ventana de propiedades de la base de datos desde
el *Object Explorer* y mirar el campo *Version*.

![Acceder a la ventana de propiedades](/static/images/posts/como-actualizar-sql-server/screenshot-from-2014-05-14-15-53-04.png)
![Revisar versión en la ventana de propiedades](/static/images/posts/como-actualizar-sql-server/screenshot-from-2014-05-14-15-53-03.png)

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
[sql builds](http://sqlserverbuilds.blogspot.mx/) y busqué la versión
específica de mi servidor. En mi caso la versión reportada era `11.0.3128.0` y
la encontré como `11.00.3128`. Seguí la lista hacia arriba y el último
*Cumulative Update (CU)* publicado al 18 de marzo del 2014 (en la fecha en la
que hice este blog) fue el `2931078` y el título es: "*Cumulative update
package 9 for SQL Server 2012 Service Pack 1*". Este CU ofrece cuatro
descargas. A mí solo me interesa la de SQL Server; esta tiene el nombre de
`SQLServer2012_SP1_CU9_2931078_11_0_3412_x64`.

Para bajar el CU me pidieron mi dirección de correo electrónico y que
demostrara que no soy un robot. Después me mandaron el link de descarga en mi
correo.

Tuve que refunfuñar algo con Internet Explorer de Windows 2012R2. Su
configuración de seguridad avanzada es bastante molesta y hace que el
navegador sea casi inútil. Tuve que mover varios controles hasta que me dejara
descargar el CU.

El CU es un `exe` que trae otro `exe` comprimido. Descomprimí el CU al
directorio `C:\Updates` y cuando lo ejecuté resultó que extrajo más archivos.
Creo que a los de Microsoft les gustan las Matrioskas.

![A alguien en Microsoft le gustan las Matrioskas](/static/images/posts/como-actualizar-sql-server/first-matryoshka-museum-doll-open-0.png)

Después de un rato de estar desparramando archivos por ahí, comienza el
proceso de instalación del CU. Este proceso es bastante aburrido.

Básicamente es esperar a que salga el instalador de SQL Server…

![¡¡¡Aburrido!!!](/static/images/posts/como-actualizar-sql-server/screenshot-from-2014-05-14-17-47-32.png)

…aceptar que le vendes tu alma al chamuco…

![Aceptar la licencia](/static/images/posts/como-actualizar-sql-server/screenshot-from-2014-05-14-17-49-45.png)

…y darle next, next, next porque no hay otra opción.

Después de un rato de hacer su chamba, el instalador termina reportando lo que
ha salido mal y lo que ha salido bien. En mi caso todo salió bien. Reinicié el
servidor para no tener dudas de que todo funciona al 100%. Finalmente, el
Object Explorer del SSMS muestra la nueva versión de SQL Server 2012.

![SQL Version 11.00.3412](/static/images/posts/como-actualizar-sql-server/screenshot-from-2014-05-15-08-17-18.png)

Esta versión corresponde al [2931078 Cumulative update package 9 (CU9) for SQL
Server 2012 Service Pack 1](http://support.microsoft.com/kb/2931078/en-us).

Y eso es todo.

P.D. Esta página en inglés es la que leí antes de hacer este post:
<https://sqlserverperformance.wordpress.com/2011/01/12/how-to-obtain-and-install-sql-server-service-packs-and-cumulative-updates/>

**FIN**
