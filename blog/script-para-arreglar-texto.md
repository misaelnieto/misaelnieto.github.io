---
title: Script para arreglar texto
date: 2012-07-16
description: Script en Python usando expresiones regulares para reformatear texto escrito en mayúsculas o minúsculas, convirtiéndolo a formato de oraciones capitalizadas.
tags:
- python
- regex
- re
- string-formatting
- scripting
extra:
  deprecated_reason: HomeViva cerró hace años; el script sigue funcionando pero el caso de uso original ya no existe
  deprecated: true
---

## Script para arreglar texto

**Actualización 14-Enero-2017:** HomeViva dejó de existir hace varios años.

Hoy me pidieron resolver un problema curioso: tenemos un ~~[sitio](http://homeviva.com)~~
donde gente no técnica introduce información acerca de sus proyectos.

El problema que había que resolver es que hay gente que escribe con puras
mayúsculas o puras minúsculas. Esto se ve horrendo, así que había que encontrar
una manera de reformatear esos textos para que tuvieran una mejor presentación.
Después de buscar un poco de información, me encontré con la posibilidad de
resolver el problema usando únicamente la librería estándar de Python.

La función que hace el reformateo es esta:

```python
import re

SENTENCE_REGEX = r'[\?.:!;\n]'

def format_string_sentence(value):
    sentences = [s.strip() for s in re.split(SENTENCE_REGEX, value)]
    for s in sentences:
        value = value.replace(s, s.capitalize())

    return value
```

Tuve que usar `re.split()` porque la función `string.split` solo funciona con
un solo carácter de separación, y si ponemos más de uno, pues lo toma como una
palabra y no como una serie de caracteres que sirvan como separadores.

Pero `re.split()` toma un patrón de caracteres. Ejemplo de uso:

```python
>>> import re
>>> a = """
... lOreM IPsuM dolor sit amet, consectetur adipiscing ELIT.
... Typi non habent claritatem insitam? EST USUS LEGENTIS in Iis Qui! facit eorum
... """
>>> re.split('.!', a)
['\nlOreM IPsuM dolor sit amet, consectetur adipiscing ELIT. \nTypi non habent claritatem insitam? EST USUS LEGENTIS in Iis Qu', ' facit eorum\n']
>>>
```

Con eso ya se puede ver que separa cadenas usando como separador el carácter
`.` o el signo de admiración. Como ya sé un poquito de expresiones regulares,
me aventé a hacer un regex super sencillo, uno que coincidiera con los
caracteres `?.:!;` y nueva línea.

```python
SENTENCE_REGEX = r'[\?.:!;\n]'
```

Y para terminar el truco uso `capitalize()` en cada una de las cadenas
separadas y después las reemplazo en la cadena original.

```python
>>> print(a)

lOreM IPsuM dolor sit amet, consectetur adipiscing ELIT.
Typi non habent claritatem insitam? EST USUS LEGENTIS in Iis Qui! facit eorum

>>> print(format_string_sentence(a))

Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Typi non habent claritatem insitam? Est usus legentis in iis qui! Facit eorum
```

Y ya. Fin.
