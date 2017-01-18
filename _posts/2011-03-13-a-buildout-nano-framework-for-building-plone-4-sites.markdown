---
title: A buildout nano-framework for building Plone 4 sites
layout: post
categories: Plone
---

We are rolling out our 6th Plone deployment and I wanted to adopt the most
standard way of rolling our backups. After some tinkering, I came up with,
what I call a nano-framework for buildout configuration.

As I stated above, we are rolling our 6th Plone 4 deployment. On the very
first deployments, we have tried very different backup strategies and lately
we adopted the "no backup at all" strategy as it was the easiest one to do.
(sigh!) We have been very lucky so far, but we will not forever. So I tried to
group all the buildout tricks I have learned in the last two years and put
together this buildout system.

This all started with me worrying about backups, so I started looking around
until I found some guidelines. The recommended way to backup Plone is by using
repozo and a set of associated recipes for buildout. But Plone 4 also uses
plone.app.blob by default and on the #plone irc channel I was recommended two
readings:

* <http://stackoverflow.com/questions/451952/what-is-the-correct-way-to-backup-zodb-blobs>
* <http://plone.293351.n2.nabble.com/backup-of-blobstorage-in-collective-recipe-backup-td5411264.html>

Based on that, and after some months of testing, I finally arrived to craft a
nano framework based on buildout. I'll describe them so anyone, even me, can
understand this stuff after some months have passed.:

* `buildout.cfg`: This file does not exists. I deleted it. It can be created by symlinking to another file. You should run bin/buildout-c file.cfg instead.
* `base.cfg`: Base configuration file. It defines the Plone version and the base settings for one plone instance. It also adds support for Diazo/Xdv
* `development.cfg`: Extends base.cfg and adds support for mr.developer or omelette.
* `deployment.cfg`: Extends base.cfg and adds ZEO, one more Plone instance for debugging, automatic apache configuration generation, supervisor, maintenance and backup scripts.
* `custom-set`tings.cfg: This file gets included in the aforementioned config files. It contains all the definitions that makes this buildout unique. You also list the extra Plone librearies you want to use here.
* `versions.cfg`: Pinned down versions of python packages.
* `password.cfg`: User and password for zope admin.


If you want to take a look at the config files of this nano_buildout, I
upladed one to github, so you can get a copy of it.

<https://github.com/tzicatl/Plone-4-nano-buildout-framework>

I'd love to have some feedback.
