---
title: "Script para automatizar la creación de archivos .metadata"
date: "2009-10-27"
description: "Script simple en Python para automatizar la creación de archivos .metadata en directorios de skins de temas de Plone."
categories:
  - "Python Plone"
---

Este es un script para automatizar la creación de archivos `.metadata` que se
usan en el subdirectorio `/skins` de los temas de Plone.

```python
import os
archivos = os.listdir('.')
metadata= '[default]\ntitle=\ncache=HTTPCache\n'
for a in archivos:
    f = file(a+'.metadata','w')
    f.write(metadata)
    f.close()
```


Lo puedes ejecutar en el prompt de python sin problemas. Ya solo falta editar
el campo Title en cada archivo.
