---
title: "Primer post con blog estático"
date: "2012-06-15"
summary: "El anuncio original de la migración de Plone a un sitio estático generado con Jekyll en GitHub Pages."
description: "Anuncio de la migración del sitio personal de Plone a un blog estático generado con Jekyll y hosteado en GitHub Pages."
categories:
  - "Tutoriales"
tags:
  - jekyll
  - static-site
  - github-pages
  - blog
  - markdown
locale: "es_MX"
keywords: "jekyll, blog estático, github pages, markdown, migración plone"
extra:
  deprecated: true
  deprecated_reason: "Este post marca el fin del sitio en Plone y el inicio del sitio en Jekyll; el sitio volvió a migrarse a Seite en 2025"
---

He decidido abandonar mi sitio personal hecho en Plone y generarlo con puro
HTML estático. Esto quiere decir que me complico la vida aún más, pues no usaré
algo fácil como WordPress o Blogger, sino que ahora generaré el blog de manera
estática con ~~[reStructuredText](http://docutils.sourceforge.net/rst.html)~~
[Jekyll](https://jekyllrb.com/).

Las herramientas que voy a usar son:

* ~~reStructuredText~~ Markdown como lenguaje de marcado de texto.

* ~~[Tinkerer](http://tinkerer.bitbucket.org)~~ [Jekyll](https://jekyllrb.com/) para convertir el lenguaje de marcado de texto a un blog estático de HTML.

* ~~Editor de texto [Sublime Text 2](http://www.sublimetext.com/)~~ Cualquier editor de texto.

* ~~Un buildout para construir el ejecutable de Tinkerer y usar herramientas de Amazon y subir el blog a un bucket de Amazon S3.~~ GitHub como hosting.

* ~~Algún script que inventaré para automatizar el copiado de todos los archivos del blog hacia el bucket de Amazon S3.~~ Solo necesito comitear y hacer push para que GitHub reconstruya el sitio.

Y eso es todo, amigos.
