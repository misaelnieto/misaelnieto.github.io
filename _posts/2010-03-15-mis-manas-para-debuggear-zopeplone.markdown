---
title: Mis mañas para debuggear Zope/Plone
layout: post
categories: Plone
---

Pongo un par de mañas que uso para depurar y desarrollar aplicaciones Zope y
Plone.

No hay nada como usar un buen depurador para desarrollar programas o para
depurarlos. Después de un año de experiencia con Plone y Zope me atreví a
aprender a usar las herramientas de ayuda que trae por default.

Aquí en iServices usamos buildout para desarrollar y desplegar nuestras
aplicaciones. Buildout se encarga de agrupar utilerias debajo de scripts que
residen en `./bin`. Dos de ellos son:

`./bin/zopepy` te entrega un shell de python en un entorno igual al que corren las aplicaciones de Plone.

`./bin/instance` es una navaja suiza. Nos ofrece diferentes opciones:

```
$ bin/instance
program: /home/tzicatl/plone4a3/parts/instance/bin/runzope
daemon manager not running
zopectl> help

Documented commands (type help <topic>):
========================================
EOF      debug       help       logtail  restart  show    stop
adduser  fg          kill       quit     run      start   wait
console  foreground  logreopen  reload   shell    status

Undocumented commands:
======================
reopen_transcript  test

zopectl>
```

Y aqui el link donde viene cómo preparar adecuadamente el shell de debug

<http://stackoverflow.com/questions/279119/how-do-i-search-for-unpublished-plone-content-in-an-ipython-debug-shell/427914>

