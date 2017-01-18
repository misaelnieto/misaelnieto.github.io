No habia visto shutil.make_archive
==================================

.. author:: default
.. categories:: Python Spanish
.. tags:: python shutil
.. comments::

Hoy me tropecé con ``shutil.make_archive`` y me di cuenta que he desperdiciado mucho tiempo haciendo
zips a mano con la librería ``zipile``. Vamos a remediar ésto con un pequeño tutorial.

Primero, creo un directorio temporal.

.. code-block :: bash

    $ mkdir /tmp/prueba_make_archive
    $ cd /tmp/prueba_make_archive

Voy a hacer una estructura de directorios y archivos para que la prueba un poco más realista.

.. code-block :: bash

    $ mkdir -p uno/dos
    $ mkdir -p uno/tres
    $ echo "Hola mundo" > uno/dos/cuatro.txt
    $ echo "Y ahora, para algo completamente diferente" > uno/tres/cinco.txt
    $ ls
    uno

Abro una consola aparte y ejecuto python, cambio la ruta del directorio actual a
``/tmp/prueba_make_archive`` y configuro algunas variables para crear archivos .zip, .tar, .tar.gz y
tar.bz2 de mi directorio de prueba ``uno``.

.. code-block :: python

    >>> import os
    >>> os.chdir('/tmp/prueba_make_archive')
    >>> os.getcwd()
    '/tmp/prueba_make_archive'

La función ``make_archive`` toma varios argumentos:

.. code-block :: python 

    make_archive(base_name, format, root_dir=None, base_dir=None, verbose=0, dry_run=0, owner=None, group=None, logger=None)

* ``base_name``