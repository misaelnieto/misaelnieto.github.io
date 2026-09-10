---
title: Our first Plone 4 site available to the public
date: 2010-09-04
description: Cómo se construyó el primer sitio Plone 4 público, integrando Products.Collage, Products.Carousel y webcoturier.dropdownmenu con temas personalizados.
tags:
- plone
- plone-4
- cms
- web-development
extra:
  deprecated_reason: Plone 4 y todos los Products mencionados son EOL; el stack moderno no usa Collage/Carousel
  deprecated: true
---

## Intro

This is what I did to integrate a Plone 4 site. It features: Plone 4,
`webcoturier.dropdownmenu`, `Products.Carousel` and `Products.Collage`.

One of our customers requested a Plone CMS. We decided to use Plone 4 when it
was on alpha version, so I had to figure out a couple of extra things.

## Implementation

At the end we decided to go for this software bundle:

* **Plone 4.** We always try to upgrade to the latest release. We had to use some components directly from SVN (like `plone.app.jquerytools`).
* **`Products.Collage`.** Latest from SVN.
* **`Products.Carousel`.** Latest stable release was 1.1.
* **`webcoturier.dropdownmenu`.** SVN revision 114137.

The `mr.developer` buildout extension was very helpful here.

We also made a custom theme to accommodate all the changes needed.

`Products.Collage` received a little facelift from our custom theme's
stylesheets. There were some issues with Collage, since it was just starting to
provide Plone 4 support.

`Products.Carousel` received rather extensive modifications. Carousel is very
flexible, so we could almost completely rewrite the CSS to bend it to our
needs.

I also needed to relocate Carousel's viewlet from the `plone.abovecontent`
manager to `plone.portalheader`. This was easily done with some ZCML.

Finally, the Carousel template was overridden so we could insert some more
decorations.

### `webcoturier.dropdownmenu`

Initially, we did not experience any extraordinary problem while customizing
the dropdownmenu template (to hide the type icons) and adapting our CSS so
the menu looked pretty. But when we started to test the menus with Internet
Explorer, we realized that the work was not over.

So I had to read some more about IE and dropdownmenu, and I write it here so
that anyone who wants to do the same doesn't have to waste time trying to
figure out how to make them work with IE.

First of all: `webcoturier.dropdownmenu` uses the very famous *Son of Suckerfish*
technique to make dropdown menus. So it is important to read the original
article in order to understand why things are done the way they are.

Then I had a problem with IE making a mess with the `z-index` CSS properties.

Basically, when Internet Explorer relatively positions an element, it defaults
its `z-index` to 0. That should not happen.

So I had to be very careful to assign adequate `z-index` whenever it was
necessary. I also had to clean up the CSS in order to avoid bogus or incorrect
`z-index` values or inadequate positioning.

The guys at GroundWire had already figured this out.

A good live example of the IE `z-index` bug is here. Also make sure you visit
QuirksMode's bug report and read the comments.


## Conclusion

The site is up and running [here](http://sofomanec.com.mx/).

Currently we have some buggy issues with Plone's JavaScript code in IE6 and
IE, but I haven't had the time to look at them.
