---
title: Links about server performance
layout: post
Categories: Servers Performance
---

I'm gathering different links to server performance. This is in strong bias to
Plone, Zope and Python web servers.

[Benchmark of Python Web Servers By Nicholas Piël](http://nichol.as/benchmark-of-python-web-servers) | March 15, 2010

It has been a while since the Socket Benchmark of Asynchronous server. That
benchmark looked specifically at the raw socket performance of various
frameworks. Which was being benchmarked by doing a regular HTTP request
against the TCP server. The server itself was dumb and did not actually
understand the headers being send to it. In this benchmark i will be looking
at how different WSGI servers perform at exactly that task; the handling of a
full HTTP request.

[Link](http://nichol.as/benchmark-of-python-web-servers)

[Asynchronous Servers in Python Nicholas Piël](http://nichol.as/asynchronous-servers-in-python) | December 22, 2009

There has already been written a lot on the C10K problem and it is known that
the only viable option to handle LOTS of concurrent connections is to handle
them asynchronously. This also shows that for massively concurrent problems,
such as lots of parallel comet connections, the GIL in Python is a non-issue
as we handle the concurrent connections in a single thread.

In this post i am going to look at a selection of asynchronous servers implemented in Python.

[Link](http://nichol.as/asynchronous-servers-in-python)

[The Truth About Download Time](http://www.uie.com/articles/download_time/) By CHRISTINE PERFETTI AND LORI LANDESMAN

We hear all the time from web designers that they spend countless hours and
resources trying to speed up their web pages' download time because they
believe that people are turned off by slow-loading pages. Their concerns have
been amplified by experts like Jakob Nielsen who asserts that users become
frustrated after waiting too long for pages to load. It makes sense that a
slow loading page is unusable. We know that if a page takes 2 hours to load,
chances are people will abandon their tasks. But when does download time go
from too slow to fast enough?

[Link](http://www.uie.com/articles/download_time/)

[I Poop on Designing for Scalability](http://eleddy.com/blog/2008/05/on-web-application-scaling.html) by Elizabeth Leddy

Some random notes about programming for scalability.
[Link](http://eleddy.com/blog/2008/05/on-web-application-scaling.html)


[Elizabeth Leddy: Unloading Plone: Approaching Scalability in Integrated Plone Systems](http://maurits.vanrees.org/weblog/archive/2009/10/unloading-plone-approaching-scalability-in-integrated-plone-systems) by Maurits van Rees


While there is an abundance of documentation on ways to achieve better
performance with Plone, there is nothing quite like actually doing it,
especially with other system components getting in the way. This case based
look at the performance and scaling of Plone as part of an integrated system
will cover perceived front-end latency, system stability as related to Plone
responsiveness, and how to set up a hardware forward architecture. This talk
is meant for designers and integrators of large Plone installations.

[Link](http://maurits.vanrees.org/weblog/archive/2009/10/unloading-plone-approaching-scalability-in-integrated-plone-systems)

[Plone Scaling and Performance (Work in Progress)](http://scalingplone.pbworks.com/)

This is an informal place to organize thoughts and ideas about scaling plone
(including performance). I wanted to have a workspace where people can freely
contribute and once things are more solidified then I'll take the time to
format into one cohesive "thing" and publish on plone.org/documentation. Feel
free to contribute wherever you would like, big or small, and make sure to
pimp yourself in the contributors section.

[Link](http://scalingplone.pbworks.com/)

[Unloading Plone by Elizabeth Eddy (Slides in slideshare)](http://www.slideshare.net/eleddy/unloading-plone)

These are the slides form Elizabeth Leddy's talk in Plone Conf.

[Link](http://www.slideshare.net/eleddy/unloading-plone)

[Unloading Plone by Elizabeth Eddy (Video from PloneConf 2009)](http://plone.blip.tv/file/3042000/)

This is the video from Elizabeth Leddy's talk in PloneConf 2009.

[Link](http://plone.blip.tv/file/3042000/)