---
title: Script para automatizar la creación de archivos .metadata
date: 2009-10-27
description: Script simple en Python para automatizar la creación de archivos .metadata en directorios de skins de temas de Plone.
tags:
- python
- plone
- scripting
- automatizacion
extra:
  deprecated: true
  deprecated_reason: el patrón .metadata en /skins es de Plone 3/4; Plone 5+ usa otro mecanismo de temas
---

Este es un script para automatizar la creación de archivos `.metadata` que se
usan en el subdirectorio `/skins` de los temas de Plone:

```python
import os

archivos = os.listdir('.')
metadata = '[default]\ntitle=\ncache=HTTPCache\n'

for a in archivos:
    with open(a + '.metadata', 'w') as f:
        f.write(metadata)
```

Lo puedes ejecutar en el prompt de Python sin problemas. Ya solo falta editar
el campo `Title` en cada archivo.
