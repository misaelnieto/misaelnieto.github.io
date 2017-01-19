---
layout: post
title:  "Tutorial de Git con windoze"
date:   2012-11-20 19:02:10 -0700
categories: Español Git Windows
redirect_from: /blog/html/2012/11/20/tutorial_de_git_con_windoze
---

# Tutorial de Git con windoze

Este es mi tutorial de [git](http://git-scm.com/) para Winshit. Me caga usar
Windows, pero reconozco que no todo el mundo es perfecto y muchas veces hay
que trabajar con lo que hay.

Además, tengo un amigo que es diseñador y nos interesa más que diseñe
bonito a que se vuelva experto en git, así que por eso hago este tutorial.

Hay un montón de documentación acerca de git en español en inglés y me dió
flojera revisarla, así que pensé que esto sería buen tema para escribir en mi
blog. Solo voy a resumir el [libro de git](http://git-scm.com/book) (que
esta en inglés), pero en español y con mis propias palabras.


## Primero la historia de Git

[Linus Torvalds](https://plus.google.com/+LinusTorvalds) escribió el kernel
de Linux y por muchos años estuvo administrando las colaboraciones de cientos
de personas mediante emails y parches. Pero llegó un momento en que las cosas
se volvieron demasiado grandes y hubo que empezar a usar un sistema de control
de versiones. Como a Linus le asqueaba CVS (un sistema de control de versiones
de la era del caldo) y SVN, comenzó a usar un sistema propietario llamado
BitKeeper. La decisión le cayó de la patada a la comunidad de software libre,
pero a Linus le importó un bledo hasta que las limitaciones de BitKeeper le
asquearon también y prefirió escribir su propio sistema de control de
versiones desde cero ¡Vaya tipo!

Puedes leer la mini-historia oficial en la [pagina oficial de git](http://git-
scm.com/book/en/Getting-Started-A-Short-History-of-Git) que esta en inglés,
por supuesto.


##¿Qué eso de control de versiones?

Es un sistema ideado para mantener un registro al por menor de los cambios que
se le hacen a un proyecto que contiene archivos de computadora. El sistema de
control sirve para responder cuestiones bastante importantes en ciertos casos
como:


 * Modifiqué un montón de cosas y ahora el proyecto ya no funciona ¿Qué fue lo
   que le cambié? ¿Cómo lo regreso a la normalidad?

 * ¿Quién fue el que descompuso el proyecto?

 * Hace varias semanas borramos algunas partes del proyecto y ahora hay que
   volver a hacerlas. ¿Puedo regresar el tiempo para ver cómo estaba el
   proyecto antes y copiar lo que necesito ahora?

 * Fulano, Mengano y Perengano me estan mandando sus cambios, pero lo que me
   mandan no sirve por que no tiene integrado mis últimas modificaciones y tengo
   que estar adaptándolas ¿Hay manera de que ellos siempre esten en sincronía con
   mi versión del proyecto?

 * Un hacker/virus/troyano se metió a mi compu y se conectó a todos mis sitios web
   e inyectó código malicioso en mis páginas con PHP y ahora Chrome y Firefox
   sacan alarmas de todo tipo por que dicen que mis sitios están reportados como
   sitios que bajan troyanos y virus. ¿Cómo se qué archivos fueron modificados?

¿Te identificas con alguna de estas situaciones? Si la respuesta es *no*
entonces significa que use malos ejemplos y que tendrás que buscar otros por
que nos movemos a lo que sigue XD. Pero el chiste es que tener un sistema de
control de versiones es buena idea y además es estar a la moda. Punto.

Luego, hay diferentes maneras de mantener el control de los cambios de tus
proyectos. Por ejemplo, la manera más común en la que la gente mantiene
control de las versiones de sus proyectos es haciendo copias de la carpeta del
proyecto cada vez que hacen cambios. Sería una cosa parecida a esto:

```
proyecto_chido_1/
proyecto_chido_1_bis/
proyecto_chido_pepis/
proyecto_chIdo_lfkjf/
proyecto_chido_22-feb-200/
proyecto_chido_bueno+++.zip
proyecto_chido_bueno--++.zip.doc
```

Y así ... ewwww!

Entonces vienen los sistemitas de control de versiones y ahora solo tendrías
una carpeta por cada proyecto::

```
mis_proyectos/
              cliente_a/
              cliente_b/
              cliente_c/
```

Todo más ordenado ¿No?

##Centralizado vs local

Cuando un sistema de control de versiones está centralizado, significa que hay
una computadora central conectada a la red con la que te debes de comunicar
cuando quieras registrar cambios. Subversion es uno de esos.

Cuando un sistema de control de versiones es local, significa que hay cierta
base de datos en el disco duro de tu computadora que va registrando los
cambios. **Git** es uno de esos y registra los cambios que vayas haciendo en
una carpeta especial en el directorio principal de tu proyecto.

Si quieres más detalles de las diferencias [lee aquí](http://git-scm.com/book/en/Getting-Started-About-Version-Control).

Pero **Git** es algo flexible y aunque todos tus cambios se deben registrar
localmente, **git** lo hace relativamente fácil para subir y bajar cambios
desde y hacia una computadora central. Osea que Linus si hizo bien su trabajo
y tenemos lo mejor de los dos mundos.

##Instalando git en tu winshit

Ahora un poquito de "Next, next, next". Métete a http://windows.github.com y
picale en el botón grande verde que dice "Download", descarga el instalador y
ejecutalo. A la hora de escribir esto el programa se llamaba
``GitHubSetup.exe`` pero igual y luego se les aloca a los de GitHub y le
cambian el nombre. Sólo asegurate de lo estes bajando de la web de github.


    Nota: Resulta que este programa que acabas de instalar esta hecho por
    GitHub Inc. y obviamente todo tendrá que ver con GitHub. Si no usas GitHub
    aún puedes usar la linea de comandos de windows para clonar un repositorio
    y administrarlo con este software.

La línea de comandos de git la encuentras en: `Programas -> GitHub, Inc. ->
Git Shell`. Cuando lo ejecutas sale una consola de windows (o de PowerShell
si es que lo tienes instalado.) Considera esto como el modo *avanzado* de git
y ahí no hay botoncitos. Tendrás que escribir cosas como si escribieras en la
barra de búsqueda del navegador web o de Google.


##¿Te acuerdas de MS-DOS?

No se si llegaste a usar MS-DOS. Muchos usuarios de computadora de hoy en día
no lo conocieron o nunca lo aprendieron a usar. El predecesor de Windows fue
MS-DOS (también distribuido por Microsoft). MS-DOS no era gráfico ni tenía
botoncitos, imagenes ni todas esas chuladas con las que ahora se entretienen
los usuarios de computadora. MS-DOS era puro texto y se manejaba con
*comandos*. El modo texto no se ha desvanecido, al contrario, gracias a Linux
y OSX la interfaz de línea de comando se ha quedado muy engranada en el
corazón de los usuarios de computadora expertos, pues puedes hacer cosas mucho
más rápido que con el mouse y los botones.

Aquí te van algunos comandos que te van a servir.

Comenzamos con lo básico de invocar invocar algún programa, simplemente
escribes su nombre y después presionas la tecla `<<enter>>>`. Por ejemplo,
el nombre del administrador de archivos es es: `explorer.exe` y para lanzar
una ventana de este simplemente escribes::

```PowerShell
explorer
```

o

```Powershell
explorer.exe
```

Pero `explorer` es más corto ¿No?

Recuerda, en MS-DOS las cosas no son automáticas y MS-DOS se quedará esperando
a que le des instrucciones (escritas) y aún así no hará nada hasta que
presiones `<<enter>>` MS-DOS es tonto y poderoso. Solo necesita un cerebro y
tu se lo vas a dar.

Luego, para listar los contenidos de un directorio puedes usar el comando
`dir` y el resultado de este comando es algo así:

```PowerShell
C:\Documents and Settings\Fulano Fernandez\Mis documentos\GitHub>dir
El volumen de la unidad C no tiene etiqueta.
El número de serie del volumen es: F85F-6785

Directorio de C:\Documents and Settings\Fulano Fernandez\Mis documentos\GitHub

13/11/2012  21:51    <DIR>          .
13/11/2012  21:51    <DIR>          ..
13/11/2012  21:17    <DIR>          directorio
13/11/2012  21:17                   archivo.txt
             0 archivos              0 bytes
             3 dirs   5.772.095.488 bytes libres
```

Luego, para cambiarte de directorio:

```PowerShell
  cd directorio
  cd c:\windows
  cd "c:\Documents and Settings\Fulano Fernandez\Mis documentos\GitHub\mi_repo"
```

En MS-DOS y en Winshit, los nombres de archivo y directorio no tienen
distinción por minúsculas o mayúsculas. Entonces, el archivo *`odio_windows.txt`*
y `*OdIo_WinDoWS.TxT*` es el mismo. Esto no se cumple, por fortuna, para sistemas
tipo unix como Linux, OSX o Ios.

Para hacer un directorio puedes usar `mkdir`:

```PowerShell
mkdir mi_repositorio
```

Para cambiarte de unidad simplemente escribes la letra de la unidad seguida de
dos puntos::

```PowerShell
c:
d:
e:
f:
```

Y eso es todo de MS-DOS. Hay mucho más, pero confío en que sabrás buscarlo en
google o que te esperes a que escriba algo al respecto.


##Ahora si, el workflow

Pensaba centrarme principalmente en poner fotitos de dónde picarle en en la
aplicación de GitHub, pero mejor te voy a enseñar la manera geek de usar git.
No es tan difícil y sólo necesitas un par de comandos de MS-DOS (ver arriba).


### 0.- Crear un repo

Este puede ser el primer paso o no. Realmente solo se hace una vez y se trata
de convertir un directorio común y corriente en un repositorio local de Git::

```PowerShell
git init
```

¡Eso es todo!


###1.- Clonar un repo

Generalmente este es el primer paso del flujo de trabajo. Tienes que obtener
una copia del repositorio en tu disco duro y lo más común es obtenerlo de un
repositorio remoto como GitHub, BitBucket o Assembla::

```PowerShell
git clone <dirección_del_repositorio>
```

La dirección del repositorio tiene un esquema parecido al de una URL. Puede
empezar con `http://` o con `git://` e incluso con `ssh://`. Para este
último tendremos que tener configurada una llave SSH.


###2.- Bajar los cambios que otros han hecho
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Si clonaste un repo es muy probable que estes colaborando con otros. Si es
así, lo primero que debes hacer es bajar los cambios que hayan realizado tus
colegas para que tengas un repositorio fresco y no tengas conflictos. También
realiza esto cuando te avisen que metieron cambios a tu repositorio::

```PowerShell
git pull origin master
```

Algunas veces es suficiente con escribir `git pull`


###3.- Hacer tus cambios

Es solo un directorio con archivos. Ya sabes qué hacer.


###4.- Saber lo que has cambiado

Git controla los cambios que le vas haciendo a los archivos de un repositorio.
Esto es muy útil para hacer una revisión de lo que has hecho.::

```PowerShell
git diff
```

El comando git diff imprimirá en la consola un listado de las diferencias que
hay entre la última version del repositorio y lo que has cambiado. Lo nuevo se
verá en color verde y lo que has borrado se verá en color rojo.

Obviamente, para archivos binarios (como imágenes o archivos de word) sólo
verás un resúmen de cuántos bytes se han insertado y cuántos se han borrado.


###5.- Registrar o guardar tus cambios

Cuando has terminado de hacer tus cambios es hora de hacer un *commit*. Esto
equivale a darle un "Guardar" en tu editor de texto favorito, pero para el
repositorio.

La manera más fácil (aunque no la única) es::

```PowerShell
git commit -am "Descripción de los cambios"
```
No olvides poner los espacios y poner un mensaje descriptivo de los cambios
entre comillas. No seas flojo y describe bien las cosas que has hecho.


###6.- Compartir tus cambios

Este es el paso final de un típico día de trabajo con Git. Ya sincronizaste tu
repositorio con los últimos cambios (si es que estas colaborando con alguien),
hiciste tu trabajo y cambiaste algunos archivos y por último registraste tus
cambios en tu copia local.

Ahora es momento de compartir tus cambios con tus colegas.::

```PowerShell
git push
```

¡Y eso es todo! ¿Se ve difícil? ¿Verdad que no?


## Más información acerca de Git
-----------------------------

* El libro de git en spanglish --> http://git-scm.com/book/es/
* La página de wikipedia acerca de Git --> http://es.wikipedia.org/wiki/Git
* Chistes gráficos acerca de Git --> http://wheningit.tumblr.com/

Fin.