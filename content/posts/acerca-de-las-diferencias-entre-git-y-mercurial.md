---
title: "Acerca de las diferencias entre Git y Mercurial"
date: "2011-03-19"
summary: "Notas de un usuario de Git que aprende Mercurial: instalación, conversiones de repo, la extensión record y qué es el staging area."
description: "Notas sobre las diferencias clave entre Git y Mercurial desde la perspectiva de un usuario de Git que aprende Mercurial: instalación, configuración, conversión de repos y la extensión record frente al staging area de Git."
categories:
  - "Tutoriales"
tags:
  - git
  - mercurial
  - vcs
  - scm
locale: "es_MX"
keywords: "git, mercurial, hg, bitbucket, staging area, hg convert, hgrc, record extension"
---

## Intro

Una breve lista de las diferencias que he hallado al comenzar a usar
Mercurial.

Vengo del mundo de Git. Previamente había usado Subversion y CVS, pero solo a
un nivel superficial. Git fue el primer SCM que usé para trabajo diario y el
primero al que le dediqué algún tiempo para aprender cómo usarlo de manera
cotidiana. Aún hay muchas cosas que aprenderle a Git pero, por el momento, no
me he visto en la necesidad de usar alguna característica avanzada.

He usado GitHub desde hace ya varios meses y considero que es una herramienta
muy útil, por decir poco. Tenía ciertas reticencias hacia BitBucket (y
Mercurial), pues la interfaz de línea de comandos de Git está muy bien
trabajada y es capaz de ofrecerte poca y sucinta información, o información
con muchos detalles con solo cambiar un comando. La interfaz de línea de
comandos de Mercurial me había parecido un poco "llana" y simplona, y además
no sabía cómo ponerle colorcitos.

Recientemente, en el PyCON 2011, visité el stand de BitBucket que, casualmente,
estaba al lado del de GitHub. Los de BitBucket me dijeron que ellos ofrecían
repositorios privados (cosa que GitHub también tiene, pero tienes que pagar
una cuota). Cuando averigüé que los repos privados de BitBucket son
gratuitos, inmediatamente les dije: *"All right, I'm sold"*.

Así es que, ya de regreso del PyCON 2011 me propuse aprender Mercurial. Aquí
van algunas notas.

## Instalación y configuración de Mercurial

Lo primero que hice fue convertir uno de mis repos git a Mercurial. Para esto,
primero había que instalar Mercurial. En Ubuntu/Debian esto es fácil:

```bash
sudo aptitude install mercurial
```

Lo siguiente fue crear mi archivo de configuración de Mercurial (nota: estoy
usando el editor de texto Scribes. Tú puedes usar el que tú quieras):

```bash
touch ~/.hgrc
scribes ~/.hgrc
```

Mi archivo de configuración (`~/.hgrc`) luce así:

```ini
[extensions]
color =
highlight =

[ui]
username = Noe Nieto <tzicatl@gmail.com>
verbose = True
```

El archivo de configuración de Mercurial (`~/.hgrc`) es un archivo de texto
plano con formato de configuración `.ini`. La comunidad Pythonera hace buen uso
de este formato de archivos de configuración gracias al paquete `ConfigParser`.
Este archivo contiene 2 secciones. La sección `[ui]` es fácil de inferir:
contiene mi nombre de usuario y será usado en todos los commits que haga. La
sección `[extensions]` sirve para habilitar y configurar algunas extensiones o
plugins de Mercurial. La extensión `color` habilita los colorcitos en la
interfaz de línea de comandos, mientras que la extensión `highlight` le hace un
resaltado de sintaxis a los diferentes archivos de código fuente que se
encuentren en el repo Mercurial.

Se usa el siguiente comando para obtener un reporte de qué extensiones están
disponibles en la máquina:

```bash
hg help extensions
```

Y por último, el wiki de Mercurial acerca del uso de extensiones nos da una
buena introducción al tema.

### Convirtiendo un repo Git a repo Mercurial

Tengo algunos proyectos que quiero migrar a los repos privados de BitBucket.
Mercurial tiene una extensión llamada `convert`. Esta tiene que ser habilitada
para que se pueda usar. Afortunadamente es algo tan sencillo como editar
`~/.hgrc` y añadir `convert =` a la sección `[extensions]`.

```ini
[extensions]
color =
highlight =
convert =

[ui]
username = Noe Nieto <tzicatl@gmail.com>
verbose = True
```

Supongamos que mi repositorio Git se encuentra en el directorio `mirépo/`,
entonces, para convertir un repo Git a Mercurial, es algo tan sencillo como:

```bash
mv mirepo/ mirepo_git/
hg convert mirepo_git mirepo/
```

Yo no tuve ningún problema al convertir mi repositorio que tenía ya como 30
commits. Nunca lo he hecho con otro repo más grande.

Falta solo un detalle: `hg convert` no se encarga de migrar el archivo
`.gitignore`. Éste tiene que ser convertido al formato de Mercurial. Ese formato
es un archivo de texto, con formato `.ini`. Aquí les pongo un *one-liner*, como
dirían en EU, para hacer esto:

```bash
echo "syntax:glob" > mirepo/.hgignore && cat mirepo_git/.gitignore >> mirepo/.hgignore
```

## La extensión Record de Mercurial y el staging area de Git

Git tiene una funcionalidad clave de funcionamiento, el *staging area*. En el
trabajo me piden ayuda todo el tiempo con Git, porque aún no han comprendido
bien el staging area.

Este post sería muy largo si me pusiera a explicar a fondo cómo funciona ésto
en Git. Solo lo resumiré en que es una característica muy útil, porque te
permite fraccionar tu trabajo en unidades pequeñas y entendibles. No importa
que hayas cambiado 10 archivos y hayas resuelto 3 distintos problemas. Con el
staging area puedes fraccionar ese commit en 3 diferentes pasos. Al principio
parece un esfuerzo inútil, pero si regresas a revisar tu trabajo (o el de
alguien más), 6 meses o 1 año después y quieres saber qué fue lo que cambió en
un archivo o directorio, es mucho más sencillo navegar por una serie de
commits pequeños y que además la descripción del commit corresponda con lo que
contiene ese commit.

Si todavía no me he explicado acerca de la importancia del staging area,
entonces les dejo un buen post que lo explica de otra manera:
<http://gitready.com/beginner/2009/01/18/the-staging-area.html>

Mercurial, por otro lado, no tiene ese tipo de funcionalidad a la vista. Hay
que activarla mediante la extensión `record`. Al final mi `~/.hgrc` queda así:

```ini
[extensions]
color =
highlight =
convert =
record =

[ui]
username = Noe Nieto <tzicatl@gmail.com>
verbose = True
```

---

Noe
