---
title: "Demostrando la efectividad de indices en MySQL"
categories: DBA
---

Estaba leyendo una pagina que habla acerca de [indices en MySQL](http://www.informit.com/articles/article.aspx?p=377652) 
y pense que era buena idea probar lo que decian:

    Suppose that you have three unindexed tables, `t1`, `t2`, and `t3`, each
    containing a column `i1`, `i2`, and `i3`, respectively, and each consisting of
    1,000 rows that contain the numbers 1 through 1000.

Para crear dichas tablas el SQL es asi:

```mysql
CREATE TABLE `t1` (
  `i1` int(11) DEFAULT NULL,
  `i2` int(11) DEFAULT NULL,
  `i3` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `t2` (
  `i1` int(11) DEFAULT NULL,
  `i2` int(11) DEFAULT NULL,
  `i3` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

CREATE TABLE `t3` (
  `i1` int(11) DEFAULT NULL,
  `i2` int(11) DEFAULT NULL,
  `i3` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
```

Abri [Calc](https://es.libreoffice.org/) y generé una tabla con 3 filas y cada
fila la rellene del 0 al 1. Para comodidad puse el csv en pastie.

<http://pastie.org/10036497>

Luego lo importe a mysql:

```mysql
LOAD DATA LOCAL INFILE '/home/nnieto/Documentos/3.csv' INTO TABLE t1
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(i1, i2, i3);

LOAD DATA LOCAL INFILE '/home/nnieto/Documentos/3.csv' INTO TABLE t2
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(i1, i2, i3);

LOAD DATA LOCAL INFILE '/home/nnieto/Documentos/3.csv' INTO TABLE t3
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(i1, i2, i3);
```

Segun el post original el query más facil para sacar las filas en donde los
valores son iguales es como sigue:

    A query to find all combinations of table rows in which the values are equal looks like this:

```mysql
SELECT t1.i1, t2.i2, t3.i3
FROM t1, t2, t3
WHERE t1.i1 = t2.i2 AND t2.i1 = t3.i3;
```
Tomé las estadísticas de la consulta con MySQLWorkbench:

![Estadisticas de la consulta reportadas por MySQLWorkbench](/media/Seleccion_001.png)


Y el plan de ejecucion:

![Plan de ejecucion - Asi lo reporta el Workbench](/media/Seleccion_002.png)


El plan de ejecucion nos dice que tuvo que hacer un barrido completo de las
tres tablas. Esto equivale a `1 000 000 000` de combinaciones diferentes. Me
sorprende que haya terminado en tan poco tiempo 0.13 segundos.

Ahora para demostrar la efectividad de los indices, voy a crear un indice.


# TERMIAME!!!!