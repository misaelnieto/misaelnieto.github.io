---
title: Python 3 para renombrar screenshots
date: 2014-05-24
description: Script en Python 3 para renombrar automáticamente los archivos de captura de pantalla de GNOME Screenshot, sustituyendo espacios y signos por guiones bajos vía regex y fileinput.
tags:
- python
- python-3
- screenshots
- automatizacion
- scripting
---

**Actualización** (15-Enero-2017): El problema de Shutter ha sido corregido en
las versiones más nuevas de Fedora.

Hago muchos screenshots. Pero por alguna razón [Shutter](http://shutter-
project.org/) no está funcionando bien. Sospecho que tiene que ver con algún
bug en el driver de video de la máquina que uso. Me tengo que conformar con
usarlo como editor y usar Gnome Screenshot para sacar las capturas de
pantalla.

Un problema algo molesto es que [Gnome Screenshot](https://en.wikipedia.org/wiki/GNOME_Screenshot)
define un esquema de nombre de archivo algo incómodo. En AskUbuntu averigüé
que no soy el único que no está satisfecho con esto y sugieren varias
opciones. No sé por qué, pero en Fedora 20 la herramienta `rename` funciona de
una manera diferente a los demás Linux. Después de perder bastante tiempo con
el shell, decidí que python lo haría mejor y no me equivoqué. Y para hacer más
interesante el reto, lo hice en Python 3:


```python
#!/usr/bin/env python3
import os, re, fileinput

# Obtener lista de archivos desde stdin
if __name__ == '__main__':
    for _ in fileinput.input():
        f = _.strip()
        os.rename(f, re.sub('[:|\s|-]+', '_', f))
```

Para hacerlo ejecutable y disponible en el `$PATH` solo necesito copiar el
script al directorio `~/bin` y darle permisos de ejecución.

```bash
cp rename_screenshots.py ~/bin/rename_screenshots
chmod +x ~/bin/rename_screenshots
```

Python 3 añadió una nueva función que facilita procesar los argumentos que se
pasan mediante la línea de comandos o mediante stdin. Esto me permite hacer
que el script funcione como una utilería más del shell:

```bash
ls
Screenshot from 2014 05 13 14:27:06.png
ls * | rename_screenshots
Screenshot_from_2014_05_13_14_27_06.png
```

Ya como último paso, puedo usar cron para correr el script cada minuto:

```cron
* * * * * cd ~/Pictures/Screenshots && ls * | ~/bin/rename_screenshots
```

Todo esto lo tuve que hacer solo por que hay un bug en alguno de los
componentes de Fedora. Me parece como usar un cañón para matar una mosca, pero
el software libre no es perfecto.

**FIN**
