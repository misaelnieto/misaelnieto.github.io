---
title: Getting help with performance problems with Plone
layout: post
categories: Plone
---

I was, again, surprised by the quality of support from the plone users maling
list.

## Interesting thread topic about performance

Recently, on the mailing list for plone-users, a question about performance on
a plone site turned into a wealth of useful information for everyone out there
that wants to tacke similar problems with their sites.

Here is the mailing list thread: <http://plone.293351.n2.nabble.com/Performance-problems-tp7101195p7101195.html>

It has references to several tools, products and techniques that normally are
spreaded through very different places across the interwebs.

And, now that I'm on it, I'm gonna make a my summary of the issue:

* Performance problems with plone sites are mainly of three types:
    + Memory-bound: Find out where the memory leak is. Plone 3 is specially leaky. There seems to be [a fix for that](http://plone.293351.n2.nabble.com/Severe-memory-leak-in-zope-i18nmessageid-fixed-td4917950.html).
        - For Plone 3, I used to restart plone instances every day to keep memory usage in limits.
        - If you use plone on a 64 bit machine, your minimum RAM needs will increase (some times they almost doubles).
        - Upgrade to Plone 4.
    + CPU-Bound. Some view or template is executing some costly operation every time. This is an oportunity to code optimization. If code optimization is not possible, then you can make use of caching tools like plone.memoize, or cache resources with varnish or plone.app.caching or things like that.
    + IO-bound bottleneck. The most difficult to trace, to my opinion.
        - Do not increase zserver-threads, decrease it.
        - Add more ZEO clients.
        - Separate front-end for visitors and backend for editors.
        - Tuning for ZEO and ZODB will be useful.
        - Maybe make a separate data.fs for the portal_catalog. I've never had the need to do that. It depends on how many objects in the catalog are there.
        - Take out heavy stuff out of ZODB (Videos, images files). That's the reason why, on Plone 4, blobstorage is enabled by default. There are other solutions like Products.Reflecto or ore.bigfile.
        - RelStorage moves the ZODB from the filesystem to a relational database. It is useful for very high volume of writes (AFIK). But be careful, it is not a silver bullet, you have to take care of tunning your relational DB too and it will become another system to mantain and backup.

Interesting links about the topic

* Tips on [how to make a plone site faster](http://plone.org/documentation/kb/tips-on-how-to-make-a-plone-site-faster).
* [Removing KSS](http://pypi.python.org/pypi/collective.remove.kss/).
* [Low-level statistics for ZODB](http://plone.org/products/collective.stats).
* [Elizabeth Leddy's findings on performance](http://scalingplone.pbworks.com/w/page/3770062/Tuning) (with suggestions of tools)
* [Performance Tunning de Clusters Plone](http://www.youtube.com/watch?v=0v46s5jAM1w) (Portuguese needed, but portuñol can work as well).
* [Plone Conference 2010: High performance sites made easy Matthew Wilkes, Jarn AS, Germany](http://www.youtube.com/watch?v=0v46s5jAM1w).


Please, feel free to point to more information/tools.
