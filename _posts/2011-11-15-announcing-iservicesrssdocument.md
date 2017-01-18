---
title: Announcing iservices.rssdocument
layout: post
---

*Note*:  I no longer work for iServices, but they kindly asked me to release
an updated version. They own me a pizza for this.

## Rationale

I wanted to embedd RSS Feeds directly into Plone and Products.Collage, but I
wanted not to store the entries in the ZODB. However, I could not find any
suitable product for that task. I did not searched very hard anyway. So I
ended up cooking 2 products: `iservices.rssdocument` and
`collective.collage.rssdocument`.

## What does it do?

`iservices.rssdocument` provides a `RSSDocument` content-type. This
`RSSDocument` needs two things (well, three): A Title, the URL of the RSS from
which you want to retrieve data from, and the number of entries to display.

With that data on place, it will use a jQuery plugin from
<http://www.zazar.net/developers/jquery/zrssfeed>/ which uses Google's AJAX Feed
API to parse the RSS or ATOM and get JSON data of the parsed Feed and finally
embedd it into Plone. There is no interaction with the ZODB appart for
retrieving the URL, title, description and number of entries to display. So,
it's speed and reliability depends upon external factors to plone.

`collective.collage.rssdocument` reuses rssdocument into a Collage. So this is
an Add-on that allows me to do that. It only provides the "standard" view for
the collage. That's just exactly what I needed for my purposes.

## Where do I get it?

These two products are already available in Pypi:

* [iservices.rssdocument on Pypi](http://pypi.python.org/pypi/iservices.rssdocument/)
* [iservices.rssdocument on Plone.org's index](http://plone.org/products/iservices.rssdocument/)
* [collective.collage.rssdocument on Pypi](http://pypi.python.org/pypi/collective.collage.rssdocument/0.1)

They are also available on the collective:

* [iservices.rssdocument on the github Collective](https://github.com/collective/iservices.rssdocument/)
* [collective.collage.rssdocument on the SVN Collective](https://svn.plone.org/svn/collective/Products.Collage/addons/collective.collage.rssdocument/)

Final note: It just works with latest versions with plone4.