---
layout: post
title:  "Python 3 para renombrar screenshots"
date:   2014-05-24 12:26:10 -0800
categories: Programacion Python
---

**Actualizacion** (15-Enero-2017): El problema de Shutter ha sido corregido en
las versiones más nuevas de Fedora.

Hago muchos screenshots. Pero por alguna razon [Shutter](http://shutter-
project.org/) no esta funcionando bien. Sospecho que tiene que ver con algun
bug en el driver de video de la maquina que uso. Me tengo que conformar con
usarlo como editor y usar Gnome Screenshot para sacar las capturas de
pantalla.

Un problema algo molesto es que [Gnome Screenshot](https://en.wikipedia.org/wiki/GNOME_Screenshot)
define un esquema de nombre de archivo algo incomodo. En AskUbuntu averigüe
que no soy el único que no esta satisfecho con esto y sugieren varias
opciones. No se por qué, pero en Fedora 20 la herramienta rename funciona de
una manera diferente a los demas Linux. Después de perder bastante tiempo con
el shell, decidí que python lo haría mejor y no me equivoqué. Y para hacer más
interesante el reto, lo hice en Python 3:


```python
#!/usr/bin/env python3
import os, re, fileinput

#Get list of files from stdin
if __name__ == '__main__':
    for _ in fileinput.input():
        f = _.strip()
        os.rename(f, re.sub('[:|\s|-]+', '_', f))
```

Para hacerlo ejecutable y disponible en el `$PATH` solo necesito copiar el
script al directorio `~/bin` y darle permisos de ejecucion.

```bash
cp rename_screenshots.py ~/bin/rename_screenshots
chmod +x ~/bin/rename_screenshots
```

Python 3 añadió una nueva función que facilita procesar los argumentos que se
pasan mediante la linea de comandos o mediante stdin. Esto me permite hacer
que el script funcione como una utilería mas del shell:

```bash
ls
Screenshot from 2014 05 13 14:27:06.png
ls * | rename_screenshots
Screenshot_from_2014_05_13_14_27_06.png
```

Ya como último paso, puedo usar cron para correr el scritp cada minuto:

```cron
* * * * * cd ~/Pictures/Screenshots && ls * | ~/bin/rename_screenshots
```

Todo esto lo tuve que hacer solo por que hay un bug en alguno de los
componentes de Fedora. Me parece como usar un cañón para matar una mosca, pero
el software libre no es perfecto.

Fin.
