---
title: Acerca de las diferencias entre git y mercurial
layout: post
categories: programacion
---

## Intro

Una breve lista de las diferencias que he hallado al comenzar a usar
mercurial.

Vengo del mundo de Git. Previamente había usado Subversion y CVS, pero solo a
un nivel superficial. Git fue el primer SCM que usé para trabajo diaro y el
primero al que le dediqué algún tiempo para aprender cómo usarlo de manera
diaria. Aún hay muchas cosas que aprenderle a Git pero, por el momento, aún no
me he visto en la necesidad de usar alguna característica avanzada de Git.

He usado GitHub desde hace ya varios meses y considero que es una herramienta
muy útil, por decir poco. Tenía ciertas reticencias hacia BitBucket (y
mercurial), pues la interfaz de linea de comandos de git esta muy bien
trabajada y es capaz de ofrecerte poca y sucinta información, o información
con muchos detalles con solo cambiar un comando. La interfaz de línea de
comandos de mercurial me había parecido un poco "llana" y simplona, y además,
no sabía cómo ponerle colorcitos.

Recientemente, en el PyCON2011, visité el stand de BitBucket que, casualmente,
estaba al lado del de GitHub. Los de BitBucket me dijeron que ellos ofrecían
repositorios privados (Cosa que github también tiene, pero tienes que pagar
una cuota). Cuando averigüé que los "repos" *privados* de BitBucket son
gratuitos, inmediatamente les dije: "All right, I'm sold".

Así es que, ya de regreso del PYCON2011 me propuse aprender mercurial. Aquí
van algunas notas.

## Instalación y configuración de Mercurial

Lo primero que hice fue convertir uno de mis repo git a mercurial. Para esto,
primero había que instalar mercurial. En Ubuntu/debian esto es fácil.

```bash
sudo aptitude install mercurial
```

Lo siguiente fue crear mi archivo de configuración de mercurial (Nota: estoy
usando el editor de texto Scribes. Tu puedes usar el que tu quieras):

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

El archivo de configuración de mercural (`~/.hgrc`) es un archivo de texto
plano con formato de configuración `.ini`. La comunidad Pythonera hace buen uso
de este formato de archivos de configuración gracias al paquete ConfigParser.
Este archivo contiene 2 secciones. La sección [iu] es fácil de inferir:
contiene mi nombre de usuario y será usado en todos los commits que haga. La
sección [extensions] sirve para habilitar y configurar algunas extensiones o
plugins de mercurial. La extensión color habilita los colorcitos en la
interfaz de línea de comandos, mientras que la extensión highlight le hace un
resaltado de sintaxis a los diferentes archivos de código fuente que se
encuentren en el repo Mercurial.

Se usa el siguiente comando para obtener un reporte de qué extensiones están
disponibles en la maquina:

```bash
hg help extensions
```

Y por último, el wiki de mercurial acerca del uso de extensiones nos da una
buena introduccion al tema. Convirtiendo un repo Git a repo Mercurial.

Tengo algunos proyectos que quiero migrar a los repos privados de BitBucket.
Mercurial tiene una extensión llamada "convert". Esta tiene que ser habilitada
para que se puede usar. Afortunadamente es algo tan sencillo como editar
`~/.hgrc` y añadir `convert=` a la sección `[extensions]`.

```ini
[extensions]
color =
highlight =
convert =

[ui]
username = Noe Nieto <tzicatl@gmail.com>
verbose = True
```

Supongamos que mi repositorio Git se encuentra en el directorio mirepo/,
entonces, para convertir un repo Git a Mercurial, es algo tan sencillo como:

```bash
mv mirepo/ mirepo_git/
hg convert mirepo_git mirepo/
```

Yo no tuve ningún problema al convertir mi repositorio que tenía ya como 30
commits. Nunca lo he hecho con otro repo más grande.

Falta solo un detalle, hg convert no se encarga de migrar el archivo
.gitignore. Éste tiene que ser convertido al formato de Mercurial. Ese formato
es un archivo de texto, con formato .ini. Aquí les pongo un "one-liner", como
dirían en EU, para hacer esto:

```bash
echo "syntax:glob" > mirepo/.hgignore && cat mirepo_git/.gitignore >> mirepo/.hgignore
```

La extensión Record de Mercurial y el staging area de Git

Git tiene una funcionalida clave de funcionamiento, el "Staging Area". En el
trabajo me piden ayuda todo el tiempo con git, por que aún no han comprendido
bien el Staging Area.

Este post sería muy largo si me pusiera a explicar a explicar a fondo cómo
funciona ésto en Git, solo lo resumiré en que es una característica muy útil,
por que te premite fraccionar tu trabajo en unidades pequeñas y entendibles.
No importa que hayas cambiado 10 archivos y hayas resuelto 3 distintos
problemas. Con el staging area puedes fraccionar ese commit en 3 diferentes
pasos. Al principio parece un esfuerzo inútil, pero si regresas a revisar tu
trabajo (o el de alguien mas), 6 meses o 1 año después y quieres saber qué fue
lo que cambio en un archivo o directorio, es mucho más sencillo navegar por
una serie de commits pequeños y que además, la descripción del commit,
corresponda con lo que contiene ese commit.

Si todavía no me he explicado acerca de la importancia del staging area,
entonces les dejo un buen post que explican de otra manera.
<http://gitready.com/beginner/2009/01/18/the-staging-area.html>

Mercurial, por otro lado, no tiene ese tipo de funcionalidad a la vista. Hay
que activarla mediante la extensión Record. Al final mi `~/.hgrc` queda así:

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
Fin.

---

Noe
