---
title:  "Mi resumen de C#"
categories: Español Programación
---

![Una mala referencia a algo "afilado"](/media/4105108383_f0d70b3db1_o.jpg)

## Intro

**Nota**: Este resumen esta incompleto. No si si algún día lo llegue a completar.

Comencé a usar Mono y .NET para desarrollar apps que corren en Linux y
Windows. He encontrado que es bastante cómodo desarrollar con MonoDevelop en
Linux y poder compartir proyectos con colaboradores que usan VisualStudio.

Todo iba bién hasta que me trabé por varios errores al compilar y fue entonces
que emergió la necesidad de aprender más detalles del lenguaje. Este resumen
viene de la lectura de la especificacion de C#. Te advierto La sintaxis es
casi la misma.

## Similitudes y diferencias

La sintaxis es bastante parecida a C, C++, Java, JavaScript. Aca las similitudes:

* Los bloques de código se delimitan con corchetes.
* Las sentencias se deben terminar con punto y coma.
* Se hace diferencia entre mayúsculas y minúsculas.
* Las estructuras de control como se escriben igual.
* La declaración de funciones se ve igual.
* La declaración de clases y estructuras tambien tienen ese sabor de C/C++.
* La operación ternaria es la misma.
* Los operadores de comparación (`<, <=, ==, !=, >=`) son los mismos.

Ahora las diferencias:

* ¿No hay punteros?
* No hay separador de espacios de nombres (`::`) o referencias a estructuras de datos desde un puntero (`->`).
* No hay `#include`, en cambio se usa "`using`".

Con saber esto, ya tenemos un montón del camino recorrido.

## Tipos de datos

* De valor (value type). Las variables de este tipo contienen directamente el valor y son independientes una de otra.
    - `char`  almacena caracteres unicode de **16 bits**, por ende, string tambien almacenara caracteres de 16 bits.
    - `short`, `int` y `long`  funcionan de manera similar a C, incluyendo las
     contrapartes sin signo: `ushort`, `uint`, `ulong`. Su tamaño es,
     respectivamente: 16, 32 y 64 bits.
    - `float` y `double` funcionan de manera similar a C.
    - `decimal` es un nuevo tipo de datos: *Precise decimal type with at least 28 significant digits*
    - `enum`: igual
    - `struct`: no se.
    - `bool`: Booleano
    - `sbyte`, `byte`: No estoy seguro si son de 8 bits.

## Tipos de datos de referencia.

Las variables de este tipo sólo contienen una referencia (o puntero, como en
C) a la instancia de un objeto. Dos variables de este tipo pueden hacer
referencia al mismo objeto.

* object - La base de todos los objetos en C#. Todos los objetos derivan de `object`.

Fin.

----

Foto: <https://flic.kr/p/7fKKGK>


