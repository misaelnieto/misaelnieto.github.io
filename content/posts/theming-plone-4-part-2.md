---
title: "Theming Plone 4 - Part 2"
date: "2010-05-20"
summary: "Translating a free CSS template into a Plone 4 theme: Deco.gs grid, viewlet managers and a hands-on walkthrough."
description: "Second part of the Plone 4 theming walkthrough: choosing a CSS template, understanding Deco.gs grid framework, Plone's viewlet layout and step-by-step styling notes."
categories:
  - "Tutoriales"
  - "Plone"
tags:
  - plone
  - theming
  - css
  - deco-gs
  - sunburst
locale: "en"
keywords: "plone 4, theming, sunburst, deco.gs, viewlets, firebug, css"
extra:
  deprecated: true
  deprecated_reason: "Plone 4 theming with Sunburst/Deco.gs is deprecated; Plone 5+ uses Diazo/Mosaic"
---

On Part Two, I am going to document how to take one template and "translate"
it for Plone. I am using a very simple template from CSSTemplates.org.
Finally, all the code I made will be uploaded to GitHub.


## On Part 1...

On Part 1 I learned to prepare the system for buildout and Zope; I also
learned to create a Plone 4 instance from scratch and finally I learned to
create and prepare a Plone product for the new theme I am going to make.

It's time to continue with some details before starting the modification of
colors, images, and so on.

## Choosing the CSS theme template

I chose the "[Hanging](http://www.freecsstemplates.org/preview/hanging/)"
template from FreeCSSTemplates.com. It's perfect because it has three columns
and fixed width to 1024x768 monitors, which is the minimum standard in 2010.

So, after downloading and unpacking the template I get a very clean and basic
theme &mdash; good!

![choose_css_template.png](/static/images/posts/theming-plone-4-part-2/choose-css-template.png)
![Theme contents](/static/images/posts/theming-plone-4-part-2/contenido-tema-plone4.png)

The original template looks like this:

![new theme](/static/images/posts/theming-plone-4-part-2/hanging-theme.png)


## Theming tools

These are the tools we are going to use to make our theme:

* Firefox and Firebug (on Lucid, the package is `xul-ext-firebug`).
* Gedit (make sure you install the `gedit-plugins` package).

Additionally, on other templates I had to use:

* Gimp, for editing logos and some images.
* Photoshop. Sometimes Gimp does not properly open PSD templates. You'll need someone that exports the template to JPEG, PNG or something similar so you can open the templates in Gimp and cut as needed.
* Komodo Edit (a very good editor).

Any other? Other tools on other OS?

## The Deco.gs system

SunBurst, the Plone 4 default theme, uses the
[Deco.gs](http://web.archive.org/web/20100413153750/http://deco.gs/) system,
which can be defined as a "lightweight" grid framework. As some will already
know, there are some very popular grid systems.

I came to understand the grid system when I saw the
[Grid System Generator](http://web.archive.org/web/20100419013044/http://www.gridsystemgenerator.com/).
So, in general, the Sunburst theme uses the Deco.gs system and has 12 columns
for horizontal layout/positioning and has no horizontal layout/positioning. So
this is as basic as it can get.

There is a talk from Alexander Limi, the creator of Deco.gs, on
[blip.tv](http://blip.tv/file/3020558). He explains very clearly why he
created yet another grid system.

So, now that we know that Deco.gs exists, we only need to pay attention to
these CSS styles:

* `row`
* `cell`
* `width-full`
* `width-1:2`
* `position-0`
* `position-1:4`
* `position-3:4`

## Plone's layout

Plone's layout is made of viewlet managers that contain another viewlet
manager or viewlets. On a vanilla Plone site, there are 8 main viewlet
managers: `plone.portaltop`, `plone.abovecontent`, `plone.contentviews`,
`plone.abovecontenttitle`, `plone.belowcontenttitle`, `plone.abovecontentbody`,
`plone.belowcontentbody` and `plone.belowcontent`. Not all viewlet managers (or
their contents) are displayed at the same time.

This is a Firebug screenshot showing the structure of the `@@manage-portlets`
view:

![manage_portlets](/static/images/posts/theming-plone-4-part-2/manage-portlets.png)

The viewlet manager `plone.portaltop` renders `#portal-top`; `plone.belowcontent`
renders `#portal-footer`, `#portal-colophon` and `#portal-siteactions`. The template
`main.pt` is the one that renders `#portal-columns` directly, and inside it, it
renders the content of some other viewlet managers.

There are other good documentation resources for Plone theming:

* [Professional Plone Development](https://www.packtpub.com/Professional-Plone-web-applications-CMS/book) (Martin Aspelli), chapter 8 "Plone 3 Theming".
* [Plone 3 Theming](https://www.packtpub.com/plone-3-theming-create-flexible-powerful-professional-templates/book) (Veda Williams).
* [Updating Plone 3 themes for Plone 4](http://plone.org/documentation/manual/upgrade-guide/version/upgrading-plone-3-x-to-4.0/updating-add-on-products-for-plone-4.0/updating-plone-3-themes-for-plone-4/).
* [Plone.org documentation](http://plone.org/documentation/topic/Visual+Design#creating-theme-products) (various authors).


## Copying stylesheets to the Sunburst theme

Setting the theory aside, we need to copy some stylesheets from the Sunburst
theme. Some of the stylesheets of Sunburst are empty, and some others don't
really need customization.

First, we need to find out the location of the `plonetheme.sunburst` egg. I use
the following trick:

```bash
# on our buildout directory (e.g. ~/plone4b3)
sunburst=`cat bin/instance | grep "plonetheme.sunburst" | cut -d \' -f2`/plonetheme/sunburst/skins/sunburst_styles/
hanging=src/plonetheme.hanging/plonetheme/hanging/skins/hangingtheme_styles/
```

Now that we have the location of both directories, we only need to copy three files:

```bash
cp $sunburst/base_properties.props $hanging
cp $sunburst/ploneCustom.css.dtml $hanging
cp $sunburst/public.css $hanging
```

These three files will be all we need to edit in order to change colors and so
on.

## Copy images from the template to our theme

This is just a reminder to copy all the images from the Hanging theme to the
directory
`src/plonetheme.hanging/plonetheme/hanging/skins/hangingtheme_images/`
(`hangingtheme_images/` from now on).


## Hands-on with our theme

We already have our filesystem-based theme and we have also installed it on a
Plone instance. We already know of the existence of the Deco.gs system and, in
general, we already know how Plone visual building blocks are laid out on top
of each other (by using portlet managers).

We also have three new files on `hangingtheme_images/`, so we have everything
we need to start.

Let's use a top-bottom approach while applying styles to the Plone theme. That
means: I open two tabs in Firefox and start copying styles from the `<body>`,
then I move to `#visual-portal-wrapper`, and so on.

For those like me who need a photo for everything, that's what we are going to do:

![Copying theme styles](/static/images/posts/theming-plone-4-part-2/copy-theme-styles.png)

If I documented every step by now, this post would be unfinishable, so I just
will list the modifications I made. The details of each modification are
broken into small commits on the
[git repository](http://github.com/tzicatl/plone4andtheme). Feel free to clone
the project buildout and walk through the log (hopefully it is not very long).


These are the steps I did to finish the theme:

* Style `<body/>`.
* Center `#visual-portal-wrapper` and use `60em` width.
* Change the Plone logo. It was transparent for white background. Now it's transparent for any background. I took it from the official Plone logo pack.
* Style `#portal-globalnav`.
    + The navigation bar in Hanging and Plone are alike, but not equal. I also had to adjust the sizes, margin and padding.
* Style the columns.
    + This was trickier than the previous commits. I had to create a special background for `#portal-columns` with some transparent pixels so I could align the header and the columns. Also, the portlet columns background won't take all the vertical space. What should I do? Anyway, this is the best I can do in less than 1 hour.
* Override the footer viewlet and style it.
* Style the Plone content. I use the `test_rendering` template as a guide (i.e. `http://localhost:8080/Plone/test_rendering`).
* Add styles for headers and paragraphs.
* Add styles for links.
* Adjust minor details.

After some hours of hacking (I'm slooow), this is how it looks:

![Template hanging final](/static/images/posts/theming-plone-4-part-2/plone-hanging-preview.png)

## Wrap up

On Part 1 of this post, I learned to prepare the system for buildout and Zope;
I created a Plone 4 instance from scratch and finally I learned to create and
prepare a Plone product for the new theme.

On this second part, I briefly described the Deco.gs grid framework and that
we should pay attention to it. I also described Plone's HTML and CSS layout
and some very rough notes on the process of changing the stylesheets, adding
images or even adapting images for the Plone theme.

While doing this theme I made every commit to git as small as possible. I hope
that, if someone else (or me) walks through the git log, he or she can learn
about the theming process.

Finally, there are some issues with the theme, though. Mainly with the columns.
For example, the portlet columns may not fill up all the vertical space. I
hope to find a trick to make them work. Or should I start to theme sites using
Deliverance?

Thanks for reading my bad English so far!

---
