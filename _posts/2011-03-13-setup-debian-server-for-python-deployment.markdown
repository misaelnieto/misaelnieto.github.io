---
title: Setup Debian server for python deployment
layout: post
categories: Linux Python Debian
---

Some notes about setting up a Debian 5.05 server for python webapp deployment.
Note: this post should have been posted 3 or 4 months ago ;)) Yeeha! New
server!

We've got a new server and It's debian 5.05 (Lenny). We'll be deploying python
web apps all over the server, so this is how I did it. Let's do it!


## Update and upgrade.

```bash
apt-get update && apt-get upgrade
```

## Install development libraries:

```bash
apt-get install build-essential manpages-dev autoconf automake1.9 libtool libncurses-dev
```

## Intstall Python 2.4

Compile Python 2.4.6 from sources. Deploy in `/opt`. Why? Because we might
still need to deploy Plone 3.3 sites.

```bash
wget http://www.python.org/ftp/python/2.4.6/Python-2.4.6.tar.bz2
tar -xjf Python-2.4.6.tar.bz2
cd Python-2.4.6
./configure --prefix=/opt/Python2.4
mkdir -p /opt/Python2.4
make && make install
```
## Install Python 2.6

Compile Python 2.6.5 from sources. Deploy in `/opt`. Why? Because we will
deploy Plone 4 and Django Apps.

```bash
wget http://www.python.org/ftp/python/2.6.5/Python-2.6.5.tar.bz2
tar -xjf  Python-2.6.5.tar.bz2
cd  Python-2.6.5
./configure --prefix=/opt/Python2.6
mkdir -p /opt/Python2.6
make && make install
```

### Install GIT

We use git for several projects. Debian Lenny's version is 1.5, and as of the
date this post was written, the latest version is 1.7.2.1. Sooner or later we
will need to upgrade, so I added the debian backports based on the
instructions:

First I added this line to `/etc/apt/sources.list`:

```
deb http://www.backports.org/debian lenny-backports main contrib non-free
```

Then, we need to update the package list and install the debian backports
keyring so all the installed packages get verified.

``` bash
apt-get update && apt-get install debian-backports-keyring
```

It looks odd, but once we installed debian-backports-keyring, we need to re-
run:

```bash
apt-get update
```

We are ready to install git:

```bash
apt-get -t lenny-backports install git-core
```

Just to be sure:
```bash
git --version
git version 1.7.1
```

## Install subversion

We will also need subversion from lenny-backports:

```bash
apt-get install -t lenny-backports subversion
```

## Install pip and virtualenv for Python 2.4 and Python 2.6

We need to install pip and virtualenv for our recently installed Python 2.4
and 2.6. For 2.4:

```bash
cd ~
mkdir Python2.4-deps
cd Python2.4-deps
wget http://peak.telecommunity.com/dist/ez_setup.py
/opt/Python2.4/bin/python ez_setup.py
/opt/Python2.4/bin/easy_install pip
/opt/Python2.4/bin/pip install virtualenv
```

For Python 2.6 is just the same, but changing the path:

```bash
cd ~
mkdir Python2.6-deps
cd Python2.6-deps
wget http://peak.telecommunity.com/dist/ez_setup.py
/opt/Python2.6/bin/python ez_setup.py
/opt/Python2.6/bin/easy_install pip
/opt/Python2.6/bin/pip install virtualenv
```

Finally, install ZopeSkel (which is used for Plone buildouts) for both Python
2.4 and Python 2.6:

```bash
/opt/Python2.4/bin/pip install ZopeSkel && /opt/Python2.6/bin/pip install ZopeSkel
```

## Set-up apache for django deployment

Install `mod_wsgi`. No notes for that yet.
