---
title: Plone and security
layout: post
categories: Plone
---

My site has been experiencing some downtime this week. The reasons are
various. I've heard that Plone is very secure, but, how secure it is and what
can one do in order to avoid downtime, resist some attacks and so?

* **UPDATE**: Tonight my account was suspended again. So far, I haven't seen anything that
resembles an attack. What seems to be happening is that when my account is
suspended it will also kill all my processes (Plone and friends included).

Last time I checked, `instance-Z2.log`'s size was over `50 MB` (In less than 7 days). 
There are also some Plone errors on `instance.log`. I'll address that as soon as I can.

This week, this blog experienced some downtime due to various reasons:

* I migrated my site from one location in the server to another.
* I upgraded my site and Blog from Plone 3.2.3 to Plone 4.
* Then my web hosting account got suspended 2 times due to excesive bandwidth. This domain served almost 2.5 GB in less than 4 days, which is something I was not expecting. I don't have excesive content in this site, just my blog.

So that raised the following questions:

* Was that an attack (like a DOS?)?. I found that supervisor, varnish and plone were not running. Something or someone killed them!! Or they died!
* Was that a bandwidth issue? When I had my site in the previuos location in the server, there was no bandwidth monitoring. Now there is. I increased the BW limit.

If that was an attack, What do you guys usually do for securing yout Plone/zope installations?
