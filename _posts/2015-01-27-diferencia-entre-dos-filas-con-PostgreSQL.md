---
title:  "Cómo sacar la diferencia entre dos filas con PostgreSQL"
categories: Postgresql DBA Administración
---

![Elefantote](/media/401930619_c6ce5e6f54_o.jpg)

Tengo una tabla muy simple donde se guardan mediciones. Cada fila corresponde
a una medición y cada fila tiene una columna con el ID.

```sql
CREATE TABLE history (
  id SERIAL,
  conteo INT
);
```

Ahora insertaré algunos datos.

```sql
INSERT INTO history(conteo)
VALUES (43), (63), (22), (41) ,(85);
```

Necesito calcular qué tanto ha cambiado el valor de conteo de una columna con
respecto a la columna anterior. ¿Cómo se hace eso? La respuesta es más
sencilla de lo que me imaginé. Este es uno de esos casos donde se puede hacer
un JOIN de la tabla consigo misma. Esto en inglés se le llama *Self-join*.

```sql
SELECT Y.id, Y.conteo- X.conteo AS "Diferencia"
FROM history X
JOIN history Y ON X.id=(Y.id -1)
ORDER BY Y.id DESC;
```

La solución, en este caso especifico, consiste en aprovechar que la columna ID
es un numero entero que crece conforme se van insertando columnas. Simplemente
se busca que el id de la columna anterior sea equivalente al de la columna
actual menos uno.

El resultado es este:

| ID | DIFERENCIA |
|----|:----------:|
| 5  | 44         |
| 4  | 19         |
| 3  | -41        |
| 2  | 20         |


Obviamente en condiciones reales no todas las tablas tendrán un id seriado de
1 en 1. Pero si la tabla incluye la fecha y hora de la creacion de la columna
se puede usar esta columna.

Aca dejo un [SQLFiddle](http://sqlfiddle.com/#!15/76b2a/6) para que puedas jugar con los datos.

----

* La imagen del elefante la tomé de <https://flic.kr/p/BvZYg>
