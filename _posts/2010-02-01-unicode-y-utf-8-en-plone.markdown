---
title: Unicode y UTF-8 en Plone
layout: post
categories: Python
---

Notas acerca de errores con acentos y eñes y etc etc. Y aún no entiendo bien
por qué truena.

Tengo este producto de plone que trae buenos links (bueno, un solo link bueno):

<http://plone.org/products/unicodeerrordetector>

Recomienda este articulo de Joel On software: <http://www.joelonsoftware.com/articles/Unicode.html>

Ahora, Erik opina esto:

Dentro de un buildout de plone:

```
$ cd parts/zope2/lib/python
```

Crear, en ese directorio, un archivo con el nombre `sitecustomize.py` que contenga lo siguiente

```
import sys
sys.setdefaultencoding('utf-8')
```

Esto es porque en eduIntelligent tenemos un problema con `Products.PloneGlossary`. Y el problema dice así (link):

```rest
Plone Unicode issue
===================

If you use an old version of Plone (< 3.2), you'll encounter `this issue
<http://dev.plone.org/plone/ticket/7522>`_: using non ASCII characters in
your glossary requires to change the default encoding of your Zope.


To do this, add a `sitecustomize.py` file to your $SOFTWARE_HOME with
these two lines::

  import sys
  sys.setdefaultencoding('utf-8')

Then replace "utf-8" above with the value of the "default_charset" property
in your "portal_properties/site_properties".
```

Y, además, en `zope.conf` tweaks, tenemos:

```
If the Plone sites of your instance use another charset, or if you
need another batch size, you might append this to your `zope.conf`::

  <product-config ATFlashMovie>
    charset utf-8 # Or iso-8859-15
  </product-config>
```

Esto pinta como para hacer un buen documento de las cosas que no deben hacerse
al desarrollar productos en plone. Cosas que se rompen cuando le pones acentos
a las cosas.
