---
title: Testing plone+varnish for speed
layout: post
---

So, I've been working for more than a year setting up and maintainting Plone
sites. I've learnt about Plone's weaknesses and strengths. Recently speed and
performance has become the "holy grail" in iServices (where i work). I've been
told that Plone needs caching and there are a lot of ways to make it behave
well regarding to speed and performance. Let's see if that is true for Plone +
Varnish.

## The basic set-up

I've gathered almost 1+ year of daily experience with Plone, but even tough,
there are a lot of concepts, ideas and procedures that I don't understand or
do ignore. One of these topics is performance.

On live sites we use a set-up like the one depicted below:

![Load balancing and caching](/media/plone_varnish.png)

We have several Plone/Zope instances, behind pound (load balancer); then comes
varnish cache and then apache.

Someone might come and ask questions:

* *Why is this setup like that?* My answer: I don't know. It was there before I arrived here. From what I've read and told this is one of the best "bundles" for a decent Plone deployment.

* *Hey, but it can be improved by adding or removing X, Y, Z*. My answer: I don't know. I am already pretty confused with all these components. Can we improve it by removing parts instead of adding more?

* *How do these plone instances share data?* My answer: Is not ZEO, is relStorage + Postgresql + FileSystemStorage or plone.app.blob. I've never tryied ZEO before and I don't know how well does it perform or scale. OTOH, We have bottlenecks with relstorage+postgresql.

* *Hey dude, you should tune up your relstorage+postgresql backend first*. My answer: yeah, you're right. That's what I want to do!! Now how do I it? I don't know much about tuning relational databases, sorry.

## Are we measuring performance?

Up to date we have been "measuring" our performance gains by seting up our
servers (with the aforesaid caching+load balancing approach), visiting them
and saing "hey, this is very slow". We also measure performance based on how
many support calls do we receive by our clients complaining that the site is
"slow".

Yeah.... i know.

So, on this quest for performance+speed, I am starting from scratch by asking:
How do I measure performance + speed in plone? What kind of numbers should we
see so we can say "this site is slow" or "this site is performing well, check-
out your internet connection", etc etc.

## Testing websites with Apache Benchmark

The first tool I'm going to use is Apache Benchmark. It comes bundled with
almost every installation of apache or at least it does with Ubuntu. Test
bench

* Server
    + Hardware: This is an old HP Compaq nx6120 with 720 MB of RAM and Intel Centrino processor (1 processor). HD space for linux is 40 GB.
    + Software: Ubuntu 9.10 Server edition 32-Bits. Installed from scratch.
* Client
    + Hardware: HP Compaq 515. It has an AMD Athlon-x2 CPU 64 bits with 1.7 GB of RAM.
    + Software: Ubuntu 9.10 Desktop (With lots of packages installed as this is the computer I use daily for programming).
* Network: Crossover cable between the two laptops. 100 Mbit Ethernet.

## Learning how to use Apache Benchmark

In a google search, one of the first links I found was this howto, and then
this one.  And based on these two readings, I decided to measure the
following:

* Static Non-KeepAlive test for Apache web server. On this test we will serve a very small webpage. We will make 1000 requests with 5 concurrent connection.
* Static Non-KeepAlive test for lighttpd web server ???
* Keep alive and non-keep-alive test for plone ??
* Keep alive and non-keep-alive test for varnish behind plone (just one instance) ??
* Keep alive and non-keep-alive test for apache/varnish/plone set-up ??
