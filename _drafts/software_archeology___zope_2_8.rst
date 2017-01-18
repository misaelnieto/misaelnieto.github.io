Software archeology & Zope 2.8
==============================

.. author:: default
.. categories:: Python Zope
.. tags:: Python Zope2 Zope 2.8
.. comments::


Today I took a curious freelance gig: move an old Zope 2.8.5 site to a new
machine. Zope 2.8.5 was released on 2005, 7 years ago. It's old. Also, the
server it is old, with linux 2.4 and Python 2.3. Old.

I'm not going to do any code migration, but I'd like to see how Zope 2.8 does
with the latest version of Python 2.4. Changes from Python 2.3 to Python 2.4
should be small enough to allow for this enhancement.

The first part is to install Python 2.4. But fortunately I already had a
compiled Python 2.4 setup laying around (thanks to `Collectives'
buildout.python <https://github.com/collective/buildout.python>`_), so I
installed virtualenv on it and created an isolated sandbox for my tests:

.. code-block:: bash

    ~/Aplicaciones/Codigo/buildout.python/python-2.4/bin/pip install virtualenv
    mkdir ~/Aplicaciones/Codigo/Zope2.8-Test
    cd ~/Aplicaciones/Codigo/Zope2.8-Test
    ~/Aplicaciones/Codigo/buildout.python/python-2.4/bin/virtualenv ve

Next step is to download the source code of Zope 2.8 (`here <http://old.zope.org/Products/Zope/2.8.5/>`_) 
and uncompressed it:

.. code-block:: bash

    wget http://old.zope.org/Products/Zope/2.8.5/Zope-2.8.5-final.tgz
    tar -xzvf Zope-2.8.5-final.tgz

The `Zope 2 book <>`_ has some very handy install instructions, which I
reproduce here:



