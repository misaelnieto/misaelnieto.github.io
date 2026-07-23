---
title: "A buildout for Plone 3.3.5 + fss + relstorage"
date: "2010-04-27"
summary: "An unusual Plone 3.3.5 buildout using FileSystemStorage and RelStorage instead of the traditional ZODB."
description: "Buildout recipe para Plone 3.3.5 usando FileSystemStorage y RelStorage en lugar de ZODB tradicional."
categories:
  - "Plone"
  - "DevOps"
tags:
  - plone
  - buildout
  - relstorage
  - filesystemstorage
locale: "en"
keywords: "plone, buildout, relstorage, filesystemstorage, zodb alternative"
extra:
  deprecated: true
  deprecated_reason: "iw.fss ya no se mantiene y Plone 3.3.5 es EOL; RelStorage moderno tiene config muy diferente"
---

This is an uncommon Plone buildout. There is no ZODB. Instead, we use
FileSystemStorage for files, images, and so on, and RelStorage for storing
everything else in a relational DB.

**Edit:** Changed the title because it can confuse new users into thinking this
is the "standard" way to set up Plone. It is not.

## Intro

On iServices, we used the Plone + FileSystemStorage + RelStorage bundle for
several reasons that I don't remember well. If I have to answer why we used
that combination, I'd probably pass this question to
[@erik_river](http://twitter.com/erik_river) to answer it. He was the first
one who made it work.

So, I maintain all these sites, and over time we had some different ways to
integrate the software bundle. Recently I had to upgrade this site to Plone
3.3.5 and resolved to make a definitive buildout recipe. And thanks to the
help of the guys at the [ZODB-dev](https://mail.zope.org/pipermail/zodb-dev/2010-April/013254.html)
mailing list I give you my ultimate Plone + FileSystemStorage + RelStorage
buildout recipe.

Note: read the [RelStorage](http://pypi.python.org/pypi/RelStorage) documentation.

The buildout recipe:

```ini
[buildout]
parts =
    zope2
    productdistros
    instance
    fss
    zopepy

extends =
    http://dist.plone.org/release/3.3.5/versions.cfg
versions = versions

find-links =
    http://dist.plone.org/release/3.3.5
    http://dist.plone.org/thirdparty
    http://packages.willowrise.org

# Add additional eggs here
eggs =
#...System
    elementtree
    psycopg2
    PILwoTK
#...plone
    RelStorage
    Plone
    iw.fss

develop =

zcml =
    iw.fss
    iw.fss-meta

rel-storage =
    type postgresql
    dbname plone335_zodb
    user zope
    password CHANGE_ME
    host localhost

[versions]
plone.recipe.zope2instance = 3.6
#ZODB3 = 3.7.3-polling
ZODB3 = 3.8.3-polling

[zope2]
recipe = plone.recipe.zope2install
fake-zope-eggs = true
url = ${versions:zope2-url}


[productdistros]
recipe = plone.recipe.distros
urls =
nested-packages =
version-suffix-packages =

[instance]
recipe = plone.recipe.zope2instance
zope2-location = ${zope2:location}
user = admin:admin
http-address = 8080
#debug-mode = on
#verbose-security = on
eggs =  ${buildout:eggs}
zcml =  ${buildout:zcml}
rel-storage= ${buildout:rel-storage}
products =
    ${buildout:directory}/products
    ${productdistros:location}


[fss]
recipe= iw.recipe.fss
zope-instances = ${instance:location}
storages =
    files / flat

[zopepy]
recipe = zc.recipe.egg
eggs = ${instance:eggs}
interpreter = zopepy
extra-paths = ${zope2:location}/lib/python
scripts = zopepy
```
