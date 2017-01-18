---
title: Moving a Plone site from AWS to webfaction
layout: post
---


I've been helping [my friends](http:/www.holokinesislibros.com) with their
Plone site for some years now. Initially, the site was hosted on IntoVPS,
which is quite cheap and nice to setup. Unfortunately, at that time, we needed
a lot of storage and their plans didn't provide enough space, so I moved the
site to amazon AWS and it's been almost two years since then. Unfortunately,
AWS is very expensive and we have lowered our storage requirements since then.
So I'm moving the site again, this time to WebFaction.

We went for the 256MB plan because it includes 256MB of RAM (plone4 uses 160MB
at most), 100GB of space (right now we need about 60 GB) and 600 GB of
bandwidth which I'm not measuring yet. So, a single plone instance will fit
there.

## Configuring webfaction

We are using HTTPS to encrypt the whole site's traffic. I set up two websites:
one for HTTP and another for HTTPS. The HTTP website is linked to a
**Static/CGI/PHP** application that only has two files: an `index.html` and a
`.htaccess` file which it's only purpose is to rewrite/redirect the traffic to
the HTTPS port.


```apache
Options +FollowSymLinks
RewriteEngine on
RewriteBase /
RewriteRule ^(.*)$ https://www.holokinesislibros.com/$1 [R=301,L]
```

On the HTTPS website I created a **Zope (2.13.15) - Plone (4.1.6)**
application. This is basically a directory that contains a Python2.6
virtualenv, a `buildout-cache` directory and uses Plone's universal installer
to create and bootstrap a buildout environment in another directory called
`zinstance`. It also creates a crontab entry to start Zope's instance every 20
minutes.

But I'm using a customized buildout, so I ignored the `zinstance` directory
and instead cloned my repo on the application directory and bootstraped it
with a fresh virtualenv of python 2.7.

```bash
cd webapps/hkl_plone
virtualenv ve
hg clone ssh://hg@bitbucket.org/tzicatl/holokinesis_libros
cd holokinesis_libros
../ve/bin/python bootstrap.py -c webfaction.cfg
bin/buildout -c webfaction.cfg
```

Not everything went smooth. I had to adjust my buildout so it could run with
the new branch of `zc.buildout` 2.0. Namely: some syntax errors in my
`versions.cfg`, remove `buildout.dumppickedversions` extension and update
`bootstrap.py`

I also had to copy some settings from the `zinstance` directory, like the
port.

Finally, in order to completely switch from `zinstance` to my own buildout in
`holokinesis_libros` I change the crontab command, from:

```crontab
2,22,42 * * * * $HOME/webapps/hkl_plone/zinstance/bin/instance start > /dev/null 2>&1
```

to:

```crontab
2,22,42 * * * * $HOME/webapps/hkl_plone/holokinesis_libros/bin/instance start > /dev/null 2>&1
```

## Setting up HTTPS

Plone (in fact, Zope2) needs to be monkey-patched so it recognizes the `X-Forwaded-SSL` header.
Fortunately, [webfaction provides a patch](http://docs.webfaction.com/software/zope-and-plone/configuring.html#using-zope-over-https)>
that works really well with recent versions of Plone (4.1.6).

```bash
cd ~/webapps/hkl_plone/holokinesis_libros/products
wget -O patch.tar.gz http://wiki.webfaction.com/attachment/wiki/WebFactionSslPatch/WebFactionSSLPatch-1.0.tar.gz?format=raw
tar -zxvf patch.tar.gz
rm patch.tar.gz
```

I had to to issue a support ticket so the web serve could load my SSL
certificates. I only had to point them to the directory where my certs are and
they did all the job cofiguring the certificates.

### Moving `data.fs` and blobs

I went the easy route and made an uncompressed tarball of the `var/` directory
and copied it to the new server.

On the AWS server:

```bash
cd path/to/plone/on/aws
tar -cf var.tar var/
# I started a GNU screen session for this.
rsync -avz --delete var/ tzicatl@tzicatl.webfactional.com:/home/tzicatl/webapps/hkl_plone/holokinesis_libros/var/
# Then go to sleep, because it takes a lot of time to transfer from one site to another.
```

On the Webfaction server:

.. code-block :: bash

    cd ~/webapps/hkl_plone/holokinesis_libros/
    tar -xf var.tar

## Server startup and configuration of VHM

Starting the Plone instance is quite easy:

```bash
cd ~/webapps/hkl_plone/holokinesis_libros/
bin/instance start
```

The ZMI welcome screen shows on <https://www.holokinesislibros.com/> and
<https://www.holokinesislibros.com/Plone> works very well. Now it is time to login to the ZMI and add
a few configuration tot he Virtual Host monster. And, at the end I ended up adding just one line:

```apache
    *.holokinesislibros.com/Plone
```

## The end

Its alive and kicking! :)
