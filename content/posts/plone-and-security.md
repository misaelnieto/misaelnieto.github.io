---
title: "Plone and security"
date: "2010-05-28"
summary: "A week of downtime: was it an attack, or just bandwidth limits on shared hosting?"
description: "Notas sobre una semana de downtime en un sitio Plone 4 hosted: causas posibles y dudas sobre DOS vs límites de ancho de banda."
categories:
  - "Plone"
tags:
  - plone
  - security
  - dos-attack
  - troubleshooting
locale: "en"
keywords: "plone, security, dos, downtime, hosting, bandwidth"
extra:
  deprecated: true
  deprecated_reason: "Plone 4 ya es EOL; el contexto de hosting compartido de 2010 cambió completamente"
---

My site has been experiencing some downtime this week. The reasons are
various. I've heard that Plone is very secure, but how secure is it, and what
can one do in order to avoid downtime, resist some attacks, and so on?

* **UPDATE**: Tonight my account was suspended again. So far, I haven't seen anything that resembles an attack. What seems to be happening is that when my account is suspended it will also kill all my processes (Plone and friends included).

Last time I checked, `instance-Z2.log`'s size was over `50 MB` (in less than 7
days). There are also some Plone errors on `instance.log`. I'll address that as
soon as I can.

This week, this blog experienced some downtime due to various reasons:

* I migrated my site from one location in the server to another.
* I upgraded my site and blog from Plone 3.2.3 to Plone 4.
* Then my web hosting account got suspended 2 times due to excessive bandwidth. This domain served almost 2.5 GB in less than 4 days, which is something I was not expecting. I don't have excessive content in this site, just my blog.

So that raised the following questions:

* Was that an attack (like a DOS)? I found that supervisor, varnish and plone were not running. Something or someone killed them! Or they died!
* Was that a bandwidth issue? When I had my site in the previous location in the server, there was no bandwidth monitoring. Now there is. I increased the BW limit.

If that was an attack, what do you guys usually do for securing your
Plone/Zope installations?
