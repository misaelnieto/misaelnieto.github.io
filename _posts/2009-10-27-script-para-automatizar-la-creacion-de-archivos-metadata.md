---
title: Script para automatizar la creación de archivos .metadata
layout: post
tag: Plone
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
