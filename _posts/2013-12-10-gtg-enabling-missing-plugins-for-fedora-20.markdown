---
title: "GTG: Enabling missing plugins for Fedora 20"
layout: post
redirect_from: /blog/html/2013/12/10/gtg__enabling_missing_plugins_for_fedora_20
---

I Like [Get Things Gnome](http://gtgnome.net/) and fedora 20 brings GTG 0.3.1;
but after installing it I realized that some plugins were not available. Where
are they? This question made me realize that the GTG package for Fedora needs
to add a couple of dependencies. So here's how I managed to enable
[Remember the milk](http://www.rememberthemilk.com/) and
[mantis](http://www.mantisbt.org/>)

```bash
    yum install -y python-dateutil python-suds
```

Unfortunately, the dependencies for the *launchpad* plugin are not available
in the default Fedora repositories and RPMFusion is not available for Fedora
20 yet (as of Dec, 10, 2013).

As for the *evolution* plugin, I couldn't find any dependency that would
provide the module named `evolution` in Python. I don't use Evolution at
all, but someone else will feel disappointed.

