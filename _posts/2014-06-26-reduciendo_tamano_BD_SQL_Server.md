---
layout: post
title:  "Reduciendo el tamaño de una BD en SQL Server"
categories: SQLServer
---

## Intro

Esta es otra de mis aventuras como DBA de SQL Server.

El reto ahora es reducir el tamaño de una base de datos de SQL Server. El
servidor es SQL Server 2008r2. Lo bueno es que esta base de datos es para los
desarrolladores y tengo permisos de romper cosas, borrar bitácoras, alterar
valores, etc ¡A darle pues! ¿De qué tamaño es la BD?

Este es el primer paso. Averiguar qué tanto espacio esta ocupando la base de
datos. De antemano se que el archivo de respaldo pesa alrededor de `800 GB`
¿Pero cuánto usa en realidad en el disco duro?

[Pinal Dave](http://blog.sqlauthority.com/2010/02/08/sql-server-find-the-size-of-database-file-find-the-size-of-log-file/) al rescate:

```sql
SELECT DB_NAME(database_id) AS DatabaseName,
Name AS Logical_Name,
Physical_Name, (size*8)/1024 SizeMB, ((size*8)/1024)/1024 SizeGB
FROM sys.master_files
WHERE DB_NAME(database_id) = 'MI_DB_GIGANTE';
GO
```

El resultado:

```sql
DatabaseName     Logical_Name    Physical_Name                  SizeMB  SizeGB
==============================================================================
MI_DB_GIGANTE    db_Data         C:\MI_DB_GIGANTE\Data.mdf      238000  232
MI_DB_GIGANTE    db_Log          C:\MI_DB_GIGANTE\Log.ldf       100679  98
MI_DB_GIGANTE    db_Index        C:\MI_DB_GIGANTE\Index.mdf     489500  478
MI_DB_GIGANTE    db_Data03       C:\MI_DB_GIGANTE\Data03.mdf    75000   73
MI_DB_GIGANTE    db_Data04       C:\MI_DB_GIGANTE\Data04.mdf    75000   73
```

Y para calcular el gran total haremos un query a `sys.master_files`:

```sql
SELECT (SUM(size)/1024)/1024*8
FROM sys.master_files
WHERE DB_NAME(database_id) = 'MI_DB_GIGANTE'
GO
```

Y el resultado en Gigabytes:

```
952
```

**Nota**: `sys.master_files.size` es el tamaño del archivo en bloques de `8KB`.
El resultado original era `125206936` bloques de `8KB` cada uno. ¡Casi un
Terabyte!

Ahora ¿Cómo le hago para reducir el tamaño?

## Recovery model

El _Recovery Model_ de SQL Server afecta la manera en que se hacen respaldos y
cómo se restauran. SQL Server puede registrar todas y cada una de las
operaciones de la base de datos en una bitácora. La bitácora permite restaurar
una base de datos en un punto exacto en el pasado, por ejemplo: ayer a las
3:45 pm. El modo de recuperación controla la generación de las bitácoras.

Existen tres modos de recuperación:

* **Simple**.  No guarda nada en las bitácoras.

* **Full**. Guarda todas las operaciones en las bitácoras. El modelo más seguro.

* **Bulk logged**. Guarda las operaciones en masa o volumen. Puede perder
datos si la bitácora se daña, pero usa menos espacio en disco.

Tengo la ventaja de que esta base de datos es para los desarrolladores, así que la desición es fácil: Podemos usar el modo **simple**.

```sql
ALTER DATABASE [MI_DB_GIGANTE] SET RECOVERY SIMPLE WITH NO_WAIT;
ALTER DATABASE [MI_DB_GIGANTE] SET PAGE_VERIFY NONE WITH NO_WAIT;
```

Con esto nos aseguramos que las bitácoras no crezcan. ¿Qué sigue?

## Encoger las bitácoras

**CUIDADO**: Encoger las bitácoras hará que pierdas información. Yo tengo la
ventaja de tener una base de datos de prueba. No lo tomes esto como una
recetita sin entender lo que estas haciendo. Para dejar claro, **no sigas
leyendo este post si antes no has leido los siguientes sitios:

* [SQL SERVER – SHRINKFILE and TRUNCATE Log File in SQL Server 2008](http://blog.sqlauthority.com/2010/05/03/sql-server-shrinkfile-and-truncate-log-file-in-sql-server-2008/) de Pinal Dave

* [[Why you should not shrink your data files](http://www.sqlskills.com/blogs/paul/why-you-should-not-shrink-your-data-files/) de Paul S. Randal


¿Ya los leiste? Sigamos.

Anteriormente ya habia sacado el tamaño del archivo de `LOG`. Era de 98
Gigabytes. Con `DBCC SHRINKFILE` me podré deshacer de los logs.

```sql
DBCC SHRINKFILE (Data_Log)
```

¿Sirvió de algo? Vamos a averiguarlo ejecutando la primera consulta de este
¿post, pero ahora sobre sobre `sys.master_files`.

```mysql

DatabaseName     Logical_Name    Physical_Name                  SizeMB  SizeGB
==============================================================================
MI_DB_GIGANTE    db_Data         C:\MI_DB_GIGANTE\Data.mdf      238000  232
MI_DB_GIGANTE    db_Log          C:\MI_DB_GIGANTE\Log.ldf       1       0
MI_DB_GIGANTE    db_Index        C:\MI_DB_GIGANTE\Index.mdf     489500  478
MI_DB_GIGANTE    db_Data03       C:\MI_DB_GIGANTE\Data03.mdf    75000   73
MI_DB_GIGANTE    db_Data04       C:\MI_DB_GIGANTE\Data04.mdf    75000   73
```

¡Que bien! ¡Se liberaron **98 Gigabytes**!

## Encogiendo los datos

Use `DBCC SHRINKDATABASE`, pero no liberó demasiado espacio.

```sql
DBCC SHRINKDATABASE (MI_DB_GIGANTE, 10);
GO
```

La documentación dice que para que regrese el espacio usado al sistema
operativo hay que usar el parametro `TRUNCATEONLY`.


```sql
DBCC SHRINKDATABASE (MI_DB_GIGANTE, TRUNCATEONLY);
GO
```

Pero tampoco vi ninguna mejora significativa.

``` sql
DatabaseName     Logical_Name    Physical_Name                  SizeMB  SizeGB
==============================================================================
MI_DB_GIGANTE    db_Data         C:\MI_DB_GIGANTE\Data.mdf      237970  232
MI_DB_GIGANTE    db_Log          C:\MI_DB_GIGANTE\Log.ldf       1       0
MI_DB_GIGANTE    db_Index        C:\MI_DB_GIGANTE\Index.mdf     489500  478
MI_DB_GIGANTE    db_Data03       C:\MI_DB_GIGANTE\Data03.mdf    75000   73
MI_DB_GIGANTE    db_Data04       C:\MI_DB_GIGANTE\Data04.mdf    75000   73
```


## Encogiendo los archivos de datos

Estaba monitoreando la misma base de datos cuando vi que alguien más estaba
corriendo `DBCC` sobre uno de los archivos de de datos. Le pregunté acerca de
eso y como resultado intenté de nuevo en mi base de datos.

Elegí `db_Data03` como conejillo de indias.

```sql
DBCC SHRINKFILE (db_Data03)
```

El comando tardó dos minutos en completar y devolvió las siguientes
estadisticas:

```
DbId    FileId  CurrentSize     MinimumSize     UsedPages       EstimatedPages
27      4       9600000         9600000         8090720         8090720
```

En la documentación de DBCC explican qué significa cada uno de esos campos.
Las que me interesan son:

* **CurrentSize**: El número de páginas de `8 KB` que el archivo ocupa actualmente.

* **MinimumSize**: El número de páginas de `8 KB` que el archivo podría ocupar, como mínimo.

* **UsedPages**: El número de páginas de `8 KB` que utiliza actualmente el archivo

* **EstimatedPages**: El número de páginas de `8 KB` que el Motor de base de datos estima que puede reducir del archivo.

Por lo que veo no voy a tener suerte con este archivo. Voy a probar con `db_data_04` y `db_Data`.

```sql
DBCC SHRINKFILE (db_Data04)

DbId    FileId    CurrentSize    MinimumSize    UsedPages    EstimatedPages
18      5         9600000        9600000        8093648      8093648

DBCC SHRINKFILE (db_Data)
DbId    FileId  CurrentSize MinimumSize UsedPages   EstimatedPages
18      1       30226208    128         30224168    30224168
```

Se me terminó el tiempo :( Ojalá tenga tiempo para terminarlo y ofrecer alguna solución útil.

