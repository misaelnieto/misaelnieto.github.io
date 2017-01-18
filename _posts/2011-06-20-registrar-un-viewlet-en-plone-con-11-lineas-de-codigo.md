---
title: Registrar un viewlet en Plone con 11 líneas de código
layout: post
categories: Python Plone
---

![ Me grok smash ZCML! ](/media/me_grok.jpg)

Una vez que se ha configurado `grok.five`, se puede añadir un viewlet con solo
11 líneas de código:

```python
from zope.interface import Interface
from five import grok
from plone.app.layout.viewlets.interfaces import IPortalHeader

class Portrait(grok.Viewlet):
    grok.context(Interface)
    grok.name('libroweb.base.PersonalBarPortrait')
    grok.viewletmanager(IPortalHeader)

    def render(self):
        return u'hola'
```

Para aprender de `five.grok` hay que leer [el manual que escribió Martin
Aspelli](http://plone.org/products/dexterity/documentation/manual/five.grok) y
[la documentación en Pypi](http://pypi.python.org/pypi/five.grok).

**Actualización**:

Gracias a que Grok adopta el patrón de diseño "convention over configuration",
puedo borrar el método `render()` y crear la plantilla
`viewlet_templates/portrait.pt` (asumiendo que el código anterior se encuentra
en `viewlet.py`).

