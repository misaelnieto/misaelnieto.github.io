---
title: "Registrar un viewlet en Plone con 11 líneas de código"
date: "2011-06-20"
summary: "Con five.grok, un viewlet de Plone se registra con 11 líneas de Python y se elimina el boilerplate de ZCML."
description: "Cómo registrar un viewlet en Plone usando five.grok con solo 11 líneas de código, simplificando el desarrollo."
categories:
  - "Plone"
  - "Python"
tags:
  - plone
  - viewlet
  - five-grok
  - zcml
locale: "es_MX"
keywords: "plone, viewlet, five.grok, grok.context, IPortalHeader, convention over configuration"
extra:
  deprecated: true
  deprecated_reason: "five.grok fue deprecado en Plone 5 y removido en Plone 6"
---

![Me grok smash ZCML!](/static/images/posts/registrar-un-viewlet-en-plone-con-11-lineas-de-codigo/me-grok.jpg)

Una vez que se ha configurado `five.grok`, se puede añadir un viewlet con solo
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
Aspeli](http://plone.org/products/dexterity/documentation/manual/five.grok) y
[la documentación en PyPI](http://pypi.python.org/pypi/five.grok).

**Actualización:**

Gracias a que Grok adopta el patrón de diseño *convention over configuration*,
puedo borrar el método `render()` y crear la plantilla
`viewlet_templates/portrait.pt` (asumiendo que el código anterior se encuentra
en `viewlet.py`).
