---
title: "Mis mañas para debuggear Zope/Plone"
date: "2010-03-15"
summary: "Dos binarios del buildout de Plone que uso para depurar: zopepy y instance."
description: "Notas rápidas sobre cómo usar ./bin/zopepy y ./bin/instance para depurar aplicaciones Zope y Plone 4."
categories:
  - "Plone"
tags:
  - plone
  - zope
  - debugging
  - python
locale: "es_MX"
keywords: "plone, zope, buildout, debugging, zopepy, instance"
extra:
  deprecated: true
  deprecated_reason: "zopepy y el comando zopectl son de Plone 3/4; en Plone 5+ el flujo cambió"
---

Un par de mañas que uso para depurar y desarrollar aplicaciones Zope y Plone.

No hay nada como usar un buen depurador para desarrollar programas o para
depurarlos. Después de un año de experiencia con Plone y Zope me atreví a
aprender a usar las herramientas de ayuda que trae por defecto.

Aquí en iServices usamos buildout para desarrollar y desplegar nuestras
aplicaciones. Buildout se encarga de agrupar utilerías debajo de scripts que
residen en `./bin`. Dos de ellos son:

`./bin/zopepy` te entrega un shell de Python en un entorno igual al que corren
las aplicaciones de Plone.

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

Y aquí el link donde viene cómo preparar adecuadamente el shell de debug:

<http://stackoverflow.com/questions/279119/how-do-i-search-for-unpublished-plone-content-in-an-ipython-debug-shell/427914>
