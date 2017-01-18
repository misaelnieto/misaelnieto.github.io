---
title: Our first Plone4 site available to the public
layout: post
categories: Plone
---

## Intro
This is what I did to integrate a Plone 4 site. It features: Plone4,
webcoturier.dropdownmenu, Products.Carousel and Products.Collage

One of our customers requested a Plone CMS. We decided to use Plone 4 when it
was on alpha version, so I had to figure out a couple of extra stuff.

## Implementation
At the end we decided to go for this software bundle:

* **Plone 4**. We always try to upgrade to the latests release. We had to use some components directly from SVN (like plone.app.jquerytools).
* **Products.Collage**. Latest from SVN.
* **Products.Carousel**. Latest stable release was 1.1
* **webcoturier.dropdownmenu**. SVN revision 114137

The `mr.developer` buildout extension was very helpful here.

We also made a custom theme to accomodate all the changes needed.

`Products.Collage` received a little facelift from our custom theme's
stylesheets. There were some issues with collage, since it's starting to
provide plone4 support.

`Products.Carousel` We did some rather extensive modifications to
Products.Carousel. Carousel is very flexible, so we could almost completely
rewrite the css to bend it to our needs.

I also needed to relocate the Carousel's viewlet from the plone.abovecontent
manager to plone.portalheader. This was easily done with some zcml.

Finally, the carousel template was overriden so we could inser some more decorations.
webcoturier.dropdownmenu


Initially, we did not experienced any extraordinary problem while customizing
the dropdownmenu template (to hide the types icons) and adequating our css so
the menu looks pretty. But when we started to test the menues with Internet
Explorer, we realized that the work was not over.

So I had to read some more about IE and dropdownmenu and I write it here so
that anyone who wants to do the same, don't have to waste time trying to
figure out how to make them work with IE.

First of all: webcoturier.dropdownmenu uses the very famous Son of Suckerfish
technique to make dropdown menues. So, It is important to read the original
article in order to understand why are things done like that.

Then I had a problem with IE making a mess with the z-index css properties.

Basically, when Internet Explorer relatively positions an element, it defaults its z-index to 0. That should not happen.

So I had to be very careful to assign adequate z-index whenever was necesary. Also I had to clean up the css in order to avoid bogus or incorrect z-index or inadequate positioning.

The guys at GroundWire had already figured this out.

A good live example of the IE z-index bug is here. Also make sure you visit
QuirksMode's bug report and read the comments.


## Conclusion

The site is up an running [here](http://sofomanec.com.mx/).

Currently we have some buggy issues with plone's javascript code in IE6 and
IE, but i had not the time to look at them.
