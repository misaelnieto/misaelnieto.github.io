Static version of Plone site with httrack
=========================================



.. author:: default
.. categories:: Plone
.. tags:: plone static httrack
.. comments::

A couple of months ago I deactivated my Plone site because,  frankly, it
was way too much software for just a webpage with a blog. Also, I fell in love
with static page generators like `Tinkerer <http://tinkerer.me/>`_. 

So, my old webpage was gone, but apparently, beside robots, there are humans
that *actually* bother to read what I write and the last week `@pbinderup
<https://twitter.com/pbinderup>`_ contacted me about one broken link in the
`collective-docs <http://collective-docs.readthedocs.org/en/latest/templates_css_and_javascripts/javascript.html#having-multiple-jquery-versions-noconflict>''_ 
that points to my old web page.

And today I felt like exporting my old Plone site to pure static pages in
the middle of a deadline just to feel some accomplishment. Here we go!

First, I had to relaunch my EC2 instance and my plone site. Then I installed
httrac in my laptop with Fedora:

    sudo yum install httrack

Then this is the magic command I used to export the whole site to a directory
in my laptop:


    mkdir old.noenieto.com
    cd old.noenieto.com
    httrack "http://ec2-75-101-206-145.compute-1.amazonaws.com:8092/noenieto" -O "." "+*ec2-75-101-206-145.compute-1.amazonaws.com:8092/noenieto/*" -v

I'm dissapointed because it didn't download the 