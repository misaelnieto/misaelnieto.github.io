---
title: Hola mundo con twitter y python
layout: post
categories: Python
---

## Notas del curso de API de twitter en el Campus Party México

Primero Preparar Ubuntu 10.04 para usar el api de twitter con python en virtualenv

```bash
$ sudo aptitude install python-virtualenv
$ virtualenv --no-site-packages --verbose twitter_api
$ cd twitter_api
$ source bin/activate

(twitter_api) $ bin/pip install python-twitter
```

Despues escribir hola mundo desde la consola de python:

``` bash
(twitter_api) $ bin/python

>>> import twitter
>>> api = twitter.Api(username='mi_username',password='secretopassword')
>>> status = api.PostUpdate('Hola mundo con la API de twitter para Python. #cpmexico ')
{"created_at": "Thu Aug 12 02:16:13 +0000 2010", "favorited": false, "id": xxxxyyyy, ... }
```

Y eso es todo!