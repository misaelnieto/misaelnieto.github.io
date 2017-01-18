Testing angularjs app with phantomjs
====================================



.. author:: default
.. categories:: none
.. tags:: none
.. comments::


Install PhantomJS
------------------

I just got the binary build for 64 bits and put it in ~/Aplicaciones/PhantomJS.

    cd ~/Aplicaciones
    wget http://phantomjs.googlecode.com/files/phantomjs-1.8.1-linux-x86_64.tar.bz2
    tar -xjvf phantomjs-1.8.1-linux-x86_64.tar.bz2
    mv phantomjs-1.8.1-linux-x86_64 PhantomJS
    ln -s ~/Aplicaciones/PhantomJS/bin/phantomjs ~/bin/phantomjs

Now phantomjs just works:

    $ phantomjs 
    phantomjs> 


Now go read the `QuickStart <https://github.com/ariya/phantomjs/wiki/Quick-Start>`_


Install CasperJS
----------------

It's better to install CaseperJS directly from GitHub repo.

    git clone git://github.com/n1k0/casperjs.git CasperJS
    git checkout tags/1.0.1
    ln -s ~/Aplicaciones/CasperJS/bin/casperjs ~/bin/casperjs

Now casperjs just works, as well.

    $ casperjs 
    CasperJS version 1.0.1 at /home/tzicatl/Aplicaciones/CasperJS, using PhantomJS version 1.8.1

    Usage: casperjs [options] script.[js|coffee] [script argument [script argument ...]]
           casperjs [options] test [test path [test path ...]]
           casperjs [options] selftest

    Options:

    --help      Prints this help
    --version   Prints out CasperJS version

    Read the docs http://casperjs.org/











