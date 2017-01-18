Install development version of Pitivi on Fedora 16
==================================================



.. author:: default
.. categories:: Fedora Pitivi
.. tags:: fedora fedora-16 pitivi opensource
.. comments::


It's been some time since I wanted to test the latest development version of
`Pitivi <http://wiki.pitivi.org/wiki/Building_with_GES>`_. Fedora 16 doesn't
ship with Gstreamer 1.0, so I need to build gstreamer, glib and friends.
Fortunately, there is an automatic script that downloads, compiles and
installs the right versions of the libraries. So here are the steps I went
through to to have my version of pitivi working on my Fedora 16.


First, install needed libraries and utilities:

    sudo yum install cairo-gobject-devel intltool libtool libxml2-devel gcc gnome-doc-utils gnonlin goocanvas2 gtk-doc gstreamer-*devel pygobject3-devel yasm-devel
    sudo yum-builddep pitivi gstreamer gstreamer-python
    sudo yum install libffi-devel flex bison

Then, download the ``pitivi-git-environment.sh``

    wget http://git.gnome.org/browse/pitivi/plain/bin/pitivi-git-environment.sh
    chmod +x pitivi-git-environment.sh
    ./pitivi-git-environment.sh

And wait until the