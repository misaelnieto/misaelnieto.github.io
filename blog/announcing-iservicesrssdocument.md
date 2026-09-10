---
title: Announcing iservices.rssdocument
date: 2011-11-15
description: Anuncio de iservices.rssdocument y collective.collage.rssdocument, productos para integrar feeds RSS en Plone sin almacenar entradas en ZODB.
tags:
- plone
- rss
- products-collage
- jquery
- add-on
extra:
  deprecated: true
  deprecated_reason: iservices.rssdocument y collective.collage.rssdocument no se mantienen; Plone 5+ reemplazó el stack de feeds
---

*Note:* I no longer work for iServices, but they kindly asked me to release an
updated version. They owe me a pizza for this.

## Rationale

I wanted to embed RSS feeds directly into Plone and `Products.Collage`, but I
did not want to store the entries in the ZODB. However, I could not find any
suitable product for that task. I did not search very hard anyway. So I ended
up cooking 2 products: `iservices.rssdocument` and
`collective.collage.rssdocument`.

## What does it do?

`iservices.rssdocument` provides a `RSSDocument` content-type. This
`RSSDocument` needs two things (well, three): a title, the URL of the RSS from
which you want to retrieve data from, and the number of entries to display.

With that data in place, it will use a jQuery plugin from
<http://www.zazar.net/developers/jquery/zrssfeed/> which uses Google's AJAX
Feed API to parse the RSS or ATOM and get JSON data of the parsed feed and
finally embed it into Plone. There is no interaction with the ZODB apart from
retrieving the URL, title, description and number of entries to display. So,
its speed and reliability depend upon external factors to Plone.

`collective.collage.rssdocument` reuses `rssdocument` into a Collage. So this
is an add-on that allows me to do that. It only provides the "standard" view
for the collage. That's just exactly what I needed for my purposes.

## Where do I get it?

These two products are already available in PyPI:

* [iservices.rssdocument on PyPI](http://pypi.python.org/pypi/iservices.rssdocument/)
* [iservices.rssdocument on Plone.org's index](http://plone.org/products/iservices.rssdocument/)
* [collective.collage.rssdocument on PyPI](http://pypi.python.org/pypi/collective.collage.rssdocument/0.1)

They are also available on the collective:

* [iservices.rssdocument on the GitHub Collective](https://github.com/collective/iservices.rssdocument/)
* [collective.collage.rssdocument on the SVN Collective](https://svn.plone.org/svn/collective/Products.Collage/addons/collective.collage.rssdocument/)

**Final note:** it just works with latest versions of Plone 4.
