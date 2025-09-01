---
title: "Programa, compila e instala tu propia extension de PHP con PHP-CPP"
categories: Php C++ Apache Administración
---

![Una broma muy simple](/media/extension-cord-147580_1280.png)

## Intro

El proyecto [PHP-CPP](http://www.php-cpp.com/documentation) te permite
compilar tu propia extension en C++. Estas notas son los pasos que tuve que
seguir para conseguir hacer funcionar el típico Hola mundo.

## Manos a la obra

Las pruebas las hice en Ubuntu 14.04. Previamente intente hacerlo en un Ubuntu
12.04 (por que un servidor tenia esa versión) pero el compilador que trae es
muy viejo y al ejecutar make el proceso falla con el siguiente mensaje:

```
error: unrecognized command line option "-std=c++11"
```

Despues de mucho buscar encontré ésta [pregunta en stackoverflow](http://stackoverflow.com/questions/27341599/cc1plus-error-unrecognized-command-line-option-std-c11).
Básicamente el error se debe a que el compilador de Ubuntu 12.04 es muy viejo.
Es posible instalar un compilador más reciente, pero vale mejor aprovechar el
tiempo para actualizar la máquina a Ubuntu 14.04.

El primer paso es instalar compiladores, librerias y utilidades:

```console
sudo aptitude install php5-dev build-essential git
```

Luego clonamos el repo de PHP-CPP, corremos make y make install.

```console
git clone https://github.com/CopernicaMarketingSoftware/PHP-CPP.git
make
sudo make install
```

El `Makefile` es lo suficientemente inteligente como para averigüar el lugar
correcto dónde poner las librerias. Después de compilar e instalar PHP-CPP es
momento de compilar una extensión de PHP para comprobar que todo funciona
bien. [Basado en el tutorial de PHP-CPP](http://www.php-cpp.com/documentation/your-first-extension)
usé archivos: `main.cpp`, `Makefile` y `noe_extension.ini`.

El `Makefile` se ve asi:

```make
NAME                    =       noe_extension
INI_DIR                 =       /etc/php5/mods-available/
EXTENSION_DIR           =       $(shell php-config --extension-dir)
EXTENSION               =       ${NAME}.so
INI                     =       ${NAME}.ini
COMPILER                =       g++
LINKER                  =       g++
COMPILER_FLAGS          =       -Wall -c -O2 -std=c++11 -fpic -o
LINKER_FLAGS            =       -shared
LINKER_DEPENDENCIES     =       -lphpcpp
RM                      =       rm -f
CP                      =       cp -f
MKDIR                   =       mkdir -p
SOURCES                 =       $(wildcard *.cpp)
OBJECTS                 =       $(SOURCES:%.cpp=%.o)
all:                            ${OBJECTS} ${EXTENSION}

${EXTENSION}:                   ${OBJECTS}
                                ${LINKER} ${LINKER_FLAGS} -o $@ ${OBJECTS} ${LINKER_DEPENDENCIES}

${OBJECTS}:
                                ${COMPILER} ${COMPILER_FLAGS} $@ ${@:%.o=%.cpp}

install:
                                ${CP} ${EXTENSION} ${EXTENSION_DIR}
                                ${CP} ${INI} ${INI_DIR}

clean:
                                ${RM} ${EXTENSION} ${OBJECTS}
```

El archivo `main.c` se ve asi:

```cpp
#include <stdlib.h>
#include <phpcpp.h>

Php::Value hello()
{
  return "Hola Mundo";

}

Php::Value myFunction()
{
    if (rand() % 2 == 0)
    {
        return "string";
    }
    else
    {
        return 123;
    }
}

/**
 *  tell the compiler that the get_module is a pure C function
 */
extern "C" {

    /**
     *  Function that is called by PHP right after the PHP process
     *  has started, and that returns an address of an internal PHP
     *  strucure with all the details and features of your extension
     *
     *  @return void*   a pointer to an address that is understood by PHP
     */
    PHPCPP_EXPORT void *get_module()
    {
        // static(!) Php::Extension object that should stay in memory
        // for the entire duration of the process (that's why it's static)
        static Php::Extension extension("noe_extension", "1.0");

        // @todo    add your own functions, classes, namespaces to the extension
        extension.add("hello", hello);
        extension.add("myFunction", myFunction);

        // return the extension
        return extension;
    }
}
```

Finalmente, `noe_extension.ini`:

```ini
extension=noe_extension.so
```

Ya solo falta compilar e instalar:

```console
make
sudo make install
```

El `Makefile` anterior (osea, el segundo) tambien es lo suficientemente
inteligente como para averigüar el lugar correcto dónde poner la libreria
compilada (`noe_extension.so`) y el archivo `noe_extension.ini`. En el Ubuntu
14.04 donde probé esto los archivos quedaron en estas dos rutas:

* `/usr/lib/php5/20121212/noe_extension.so`
* `/etc/php5/mods-available/noe_extension.ini`

Aunque la localización de `noe_extension.ini` es la correcta, hay que saber
que el estilo de configuración de las extensions de PHP en Debian/Ubuntu es
muy parecido al de sitos y módulos de apache2. En Ubuntu/Debian hay que usar
los comandos `a2enconf`, `a2enmod` y `a2ensite` para activar algun archivo con
extensión `.conf` en particular. De igual manera, en Debian/Ubuntu tambien
existen los comandos `php5enmod` y `phpdismod`. Usé `php5enmod` para dar mi
modulo de alta:

```console
sudo php5enmod noe_extension
```

Esto crea una liga simbolica `/etc/php5/apache2/conf.d/20-noe_extension.ini`
que apunta hacia `/etc/php5/mods-available/noe_extension.ini`. Despues de esto
reiniciamos apache:

```console
sudo service apache2 restart
```

Después de esto, sólo fató escribir un peueño script de php para usar la
extensión. Lo puse en un directorio visible por apache2 y lo nombré
`index.php`:

```php
<html>
  <head>
     <title>Extension de PHP de Noe</title>
  </head>
  <body>
  <h3>Extension de PHP de Noe</h3>
  <ul>
     <li>Hola: <?php echo (hello()); ?> </li>
     <li>MyFunction: <?php echo myFunction(); ?></li>
  </ul>
</body>
</html>
```

Y si la configuración es correcta, se deberá ver algo así:

![La extension funcionando](/media/Captura-de-pantalla-de-2015-03-13-09.15.55.png)

Los textos "Hola mundo" y "string" provienen del complemento noe_estension.so

Eso es todo.

----
La imagen "extension cord" proviene de <http://pixabay.com/en/extension-cord-cable-electronics-147580/>

Tomada el dia 13 de Marzo del 2015.
