---
title: Mi primera experiencia con Django y zc.buildout en Ubuntu 9.10
layout: post
categories: Python Django
---

## Intro
Ésta es la primera vez que intento hacer el hola mundo con Django. Como vengo
del mundo de Plone intenté ver si se podía hacer de manera sencilla con
`zc.buildout`.

Me gusta la idea de `zc.buildout`. Brinda un entorno de desarrollo repetible
ente diferentes máquinas. Se me hizo la opción natural de probar Django, así
que, después de la sorpresa de saber que Django no viene con "buildout"
integrado, me di a la tarea de intentar averguar si se podía hacer y esto es
lo que encontré.

## Mi primera impresión de Django.

Repito, vengo del mundo de plone, ahí todo es muy a la "2.4". Lo primero que
veo es que puedo correr Django con el Python 2.6.4rc2 así que puedo usar el
python que ya trae la distro Ubuntu de mi laptop. Esto también es muy cómodo
(jajaj, aunque no se por qué).

Aunque Karmic ya trae las últimas versiones de Django, la experiencia me ha
obligado a no depender de paquetes específicos de cada Sistema Operativo. Es
por eso que decidí intentar instalar `zc.buildout`.

## Construyendo un buildout para Django

El post de Jacob Kaplan-Moss [Developing Django apps with zc.buildout](https://jacobian.org/writing/django-apps-with-buildout/) es la
primera guía que leí. Es un artículo muy bueno para poder empezar.

Y basándome en el dicho post, he aquí la estructura del directorio:

```
mydjangobuildout/
    LICENSE
    README
    bootstrap.py
    buildout.cfg
    setup.py
    src/
```

Intencionalmente no puse nada en `src/`.

Ahora, basandome en este otro post de Dan Fairs [A Django Development Environment with zc.buildout](http://www.stereoplex.com/two-voices/a-django-development-environment-with-zc-buildout)
me encuentro que usa una receta para instalar PIL con buildout (Algo que
nunca pude hacer con Plone por que no sabía como hacerlo).  Así esta mi
`buildout.cfg` sin ninguna aplicación Django, sólo sus dependencias.

```ini
[buildout]
executable=/usr/bin/python2.6
parts =
    PIL
    python
    django
eggs =
    PIL

[python]
recipe = zc.recipe.egg
interpreter = python
eggs = ${buildout:eggs}

[django]
recipe = djangorecipe
version = 1.1.1
eggs = ${buildout:eggs}

[PIL]
recipe = zc.recipe.egg
egg = PIL==1.1.6
find-links = http://dist.repoze.org/
```

Funciona a la perfección. Incluso puedo arrancar Django aunque no tengo
ninguna aplicación para ello

## Conclusión

Me agrada mucho usar zc.buildout para construir mi app en Django. Ya solo me
falta aprender Django.


