---
title: Migrating data from Plone 3.2.1 to Plone 4.0b2
layout: post
---

These are my notes about the process for migrating data from Plone 3 to Plone4.

## Intro

One of our customers wanted to renew the look&feel of his website. His website ran Plone 3.2.1 with a custom skin (One of the first ones made by me, and one that I'am NOT very proud of).

We decided to do a clean Plone4 installation with a custom theme and mount a beta site. The resulting site looks considerably better that the previous one. We've been updating the site every time a new plone4 release comes out to the public, so at the time of writing of this post, Plone 4 was still in beta2.
Migrating Data

Some considerations:

* Our customer's plone install didn't had very much customizations. We only had a couple of custom themes, CacheFu and Products.Carousel.
* ChacheFu does not work with Plone 4 (by now).
* Products.Carousel works very well with Plone 4 as of version 1.1
* We wanted to "copy" only selected parts of the old site to the new site. The best way to do this is by exporting Plone content using zexp.

Given the above considerations, these are the steps I took for migrating data from one site to another.

* Prepare a Plone 3 buildout with a copy of the zodb of the live site.
* Deactivate/clean/uninstall our custom themes and CacheFu
* Delete the "leftovers" of the uninstalled themes on portal_skins
* Clear and Rebuild the entire catalog (just in case).
* Pack the ZODB (Size decreases from 2GB to 760 MB)
* Upgrade the Plone3 Buildout to Plone
* Upgrade to Plone 3.3.5
* Prepare Plone 4 buildout (in another folder) with a copy of the zodb of the Plone 3 site.
* Upgrade to Plone 4

An that's it. Exporting content from the Plone 4 buildout to the new site works like a charm. 

P.D. I uploaded a copy of my dual buildout to git. [Get it](http://github.com/tzicatl/Plone-3-to-Plone-4-buildout).