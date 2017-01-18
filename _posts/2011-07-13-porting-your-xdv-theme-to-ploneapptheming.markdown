---
title: Porting your xdv theme to plone.app.theming
layout: post
categories: Plone
---

## Intro

This is a list of tasks to remind me what to do when porting a `xdv` theme to
`plone.app.theming`.

Replace "`my.theme`" or "`my/theme`" with your theme namespace.

## Use Plone 4.1

Migrate site to Plone 4.1 or add proper version dependencies to "`extends`"
sections on buildout.

## Add setuptools dependency on plone.app.theming

Depend on `plone.app.theming` on `setup.py`:

```python
install_requires=[
 'setuptools',
 # -*- Extra requirements: -*-
          'plone.app.theming',
]
```

## Update GS Profile

If working on a egg, change the profile dependency from `collective.xdv` to
`plone.app.theming`. On `profiles/default/metadata.xml` locate the following line:

```xml
<dependency>profile-collective.xdv:default</dependency>
```

And change it to:

```xml
<dependency>profile-plone.app.theming:default</dependency>
```

Also create the file `profiles/default/theme.xml` with the following contents
(This also enables the theme upon installation):

```xml
<theme>
 <name>my.theme</name>
 <enabled>true</enabled>
</theme>
```

## On the top level resource directory ...

Change the `rules.xml` namespace. Open `rules.xml` (and other xml files) on
you static directory. Change the xml namespace from:

```xml
 xmlns="http://namespaces.plone.org/xdv"
 xmlns:css="http://namespaces.plone.org/xdv+css"
```
To:

```xml
 xmlns="http://namespaces.plone.org/diazo"
 xmlns:css="http://namespaces.plone.org/diazo/css"
```

## ZCML

Then, on `my/theme/configure.zcml` locate this line:

```xml
<include package="collective.xdv" />
```

And change it to:

```xml
<include package="plone.app.theming" />
```

## Move theme parameters to `manifest.cfg`

New features of `plone.app.theming` include multiple themes and packaging
themes in ZIP files.

Themes on ZIP files and themes developed on the file system can include a
`manifest.cfg` file, with the classic INI file format, that includes the
following:

```ini
[theme]
title = My Theme
description = Description of your theme
rules = /++theme++my.theme/directory/rules.xml
prefix = /++theme++my.theme/directory
```

That file serves as a replacement for some settings that you'd normally insert
into `plone.app.registry` using `registry.xml` import step.

