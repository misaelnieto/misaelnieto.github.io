---
title: Hola mundo con Twitter y Python
date: 2010-08-11
description: Ejemplo mínimo del uso de la API de Twitter con Python en Ubuntu 10.04 usando virtualenv y la librería python-twitter, desde el curso de Campus Party México.
tags:
- python
- twitter
- api
- virtualenv
extra:
  deprecated_reason: la API v1 de Twitter fue descontinuada en 2013; python-twitter 0.8 ya no funciona
  deprecated: true
---

## Notas del curso de API de Twitter en el Campus Party México

Primero, preparar Ubuntu 10.04 para usar la API de Twitter con Python en
virtualenv:

```bash
$ sudo aptitude install python-virtualenv
$ virtualenv --no-site-packages --verbose twitter_api
$ cd twitter_api
$ source bin/activate

(twitter_api) $ bin/pip install python-twitter
```

Después, escribir el hola mundo desde la consola de Python:

```bash
(twitter_api) $ bin/python

>>> import twitter
>>> api = twitter.Api(username='mi_username', password='secretopassword')
>>> status = api.PostUpdate('Hola mundo con la API de Twitter para Python. #cpmexico ')
{"created_at": "Thu Aug 12 02:16:13 +0000 2010", "favorited": false, "id": xxxxyyyy, ... }
```

¡Y eso es todo!
