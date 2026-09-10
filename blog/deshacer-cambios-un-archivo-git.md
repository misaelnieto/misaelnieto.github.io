---
title: Deshacer los cambios de un solo archivo en un repo GIT
date: 2009-09-15
description: Guía para revertir cambios en un solo archivo de un repositorio Git usando el comando git checkout, explicando la diferencia entre git reset y git checkout.
tags:
- git
- checkout
- reset
- versionamiento
---

## El problema

Hice varias modificaciones locales a mi repositorio GIT. Me quiero deshacerme de
las modificaciones de uno o dos archivos, pero no de todas las demás ¿Qué
puedo hacer?

## La solución errónea

Yo creía que se podía hacer con el comando `git reset <ruta_al_archivo>`.
Pero eso no funciona así de fácil. Además, tengo la suficiente pereza
requerida como para no leer concienzudamente las páginas del manual.

## La solución chafa (funciona, pero&hellip;)

Lo que hacía era hacer un `git diff <ruta_al_archivo>` y deshacer los cambios a
mano mediante el editor.

Sí, ya sé&hellip; eso está muy chafa.

## La solución elegante.

La solución elegante la encontré en el blog de la empresa Norbauer.
Básicamente lo que uno tiene que hacer es `git checkout <ruta_al_archivo>`. Lo
que hace este comando es revertir sólo ese archivo a la versión de HEAD.

Ya que git checkout también sirve para cambiar entre ramas de desarrollo
(branches) — [un tema que da para rato][gitmercurial] — puede que alguna vez
exista una rama de desarrollo que tenga el mismo nombre que nuestro archivo;
entonces se anteponen dos guiones (o como me gusta decir: menos,menos) al nombre
o ruta del archivo: `git checkout -- <ruta_al_archivo>`.

[gitmercurial]: /blog/acerca-de-las-diferencias-entre-git-y-mercurial "Acerca de las diferencias entre git y mercurial"

Esta solución sí me gustó. Menos chafa, más elegante &mdash; como debe ser.

---