---
title: Django y Buildout (Parte 1)
layout: post
categories: Python Buildout DevOps
---

## Intro

Esta es la primera parte de las notas que escribo acerca de cómo usar Django
con Buildout. Esto fué realizado en una instalación limpia de Ubuntu Karmic
9.10

Esta es una guía de instalación de Django que es diferente a la que se anuncia
en la página web de Django. Usaremos buildout, que es una interesante manera
de replicar en entorno de desarrollo en producción y viceversa.

Una de las principales ventajas de usar buildout para nuestros proyectos en
python es que es posible crear un entorno independiente de las librerías del
sistema. En la práctica esto significa que se puede replicar las mismas
condiciones que hay en el servidor en nuestro entorno de desarrollo.

## Paso 1 - Instalación de distribute y PIP

 Primero, algunas notas:

* Python usa distutils para manejar sus librerías.
* Después del lanzamiento de distutils, emergió el sistema setuptools para automatizar el manejo de dependencias y el manejo de paquetes. Según Tarek Ziade, en su libro Expert Python Programming: Learn best practices to designing, coding, and distributing your Python software, setuptools es a Python lo que apt es a Debian/Ubuntu.
* Las librerías de python se distribuyen en un formato común, que en la comunidad python les han llamado huevos (eggs). Un huevo de python es un archivo zip, pero con la extensión .egg.
* El PyPi (Python Package Index) es el lugar principal donde se concentran la mayoría de los huevos de Python. Existen otros índices, tales como el índice de productos de Plone. El PyPi viene siendo a Python, como los repositorios de paquetes a Debian/Ubuntu.
* setuptools ha estado envejeciendo y en base a eso, Tarek Ziade decidió hacer un fork de setuptools llamado distribute (<http://pypi.python.org/pypi/distribute>)
* PIP es el reemplazo de easy_install.

Todo este cambio se resume en la siguiente imagen:

![Pip distribute](/media/2009_distribute.png)

Una vez terminado el intento de explicación, pongámonos manos a la obra. Aquí
está una lista de instrucciones necesarias para instalar distribute en una
máquina limpia. Se instalará distribute, pip y pastescript.

```
tzicatl@hormiga-negra:~ $ wget http://python-distribute.org/distribute_setup.py
tzicatl@hormiga-negra:~ $ sudo python distribute_setup.py 
tzicatl@hormiga-negra:~ $ sudo easy_install pip
tzicatl@hormiga-negra:~ $ sudo pip install PasteScript
```

Ahora, probando paster:

```
tzicatl@hormiga-negra:~/Descargas$ paster create --list-templates
Available templates:
  basic_package:  A basic setuptools-enabled package
  paste_deploy:   A web application deployed through paste.deploy
tzicatl@hormiga-negra:~/Descargas$
```

Funciona!!.

El siguiente paso es instalar las plantillas necesarias para que paster genere
todo el esqueleto de nuestro proyecto con Django. En PyPi hay dos huevos con
recetas para crear projectos con Django y Buildout,

* <http://pypi.python.org/pypi/fez.djangoskel/> Contiene plantillas para crear esqueletos de código y construir una instancia de django usando buildout.

* <http://pypi.python.org/pypi/djangorecipe> Descarga Django y lo instala en un lugar independiente de las liberías que tiene el sistema.

Comenzamos por instalar `fez.djangoskel`:

```
tzicatl@hormiga-negra:~$ sudo pip install fez.djangoskel
```

Ahora paster tiene las siguientes opciones:

```
tzicatl@laptop:~ $ paster create --list-templates
Available templates:
  basic_package:             A basic setuptools-enabled package
  django_app:                Template for a basic Django reusable application
  django_buildout:           A plain Django buildout
  django_namespace_app:      Template for a namespaced Django reusable application
  django_namespace_project:  Template for a namespaced Django project
  django_project:            Template for a Django project
  paste_deploy:              A web application deployed through paste.deploy
tzicatl@laptop:~ $
```

## Paso 2 - Crear un buildout para django

```
tzicatl@laptop:~/programar$ paster create -t django_buildout
Selected and implied templates:
  fez.djangoskel#django_buildout  A plain Django buildout

Enter project name: my_djangobuildout
Variables:
  egg:      my_djangobuildout
  package:  my_djangobuildout
  project:  my_djangobuildout
Enter django_version (Django version to fetch, the default is 1.0.2) ['1.0.2']: 1.1.1
Enter django_project_name (Name of the main Django project folder) ['project']: projects
Creating template django_buildout
Creating directory ./my_djangobuildout
  Copying README.txt to ./my_djangobuildout/README.txt
  Copying bootstrap.py to ./my_djangobuildout/bootstrap.py
  Copying buildout.cfg_tmpl to ./my_djangobuildout/buildout.cfg
  Copying devel.cfg_tmpl to ./my_djangobuildout/devel.cfg
-----------------------------------------------------------
Generation finished
You probably want to run python bootstrap.py and then edit
buildout.cfg before running bin/buildout -v

See README.txt for details
-----------------------------------------------------------
tzicatl@laptop:~/programar$
```

Con esta instrucción se ha creado un directorio my_djangobuildout que contiene
los archivos necesarios para arrancar nuestra buildout. Veamos qué archivos
contiene:

```
tzicatl@laptop:~/programar$ cd my_djangobuildout/
tzicatl@laptop:~/programar/my_djangobuildout$ ls
bootstrap.py  buildout.cfg  devel.cfg  README.txt 
tzicatl@laptop:~/programar/my_djangobuildout$

 Tenemos 3 archivos:

    bootstrap.py
        Ejecuta este archivo para crear un directorio bin/ con los diferentes scripts que se han configurado en buildout.cfg.
    buildout.cfg
        Es el archivo de configuración principal. Aquí se instruye a buildout sobre qué scripts ejecutar. También aquí controlaremos qué librerías extras se instalaran en nuestro entorno.
    devel.cfg
        Opciones de configuración extras para el modo de depurado.
    README.txt
        Archivo README ;)
```

Ahora modificamos buildout.cfg para que todo se ejecute con python2.6 y se
instalen 2 librerías extra de manera independiente del sistema. El
buildout.cfg original es este:

```ini
[buildout]
parts = django

[django]
recipe = djangorecipe
version = 1.1.1
project = projects
wsgi=true
settings=production
```
Y completadas las modificaciones queda así:

```ini
executable=/usr/bin/python2.6
parts = 
    zlib
    PIL
    django

eggs = 
    PIL

[django]
recipe = djangorecipe
version = 1.1.1
project = projects
wsgi=true
settings=production

# Build zlib for PIL, and PIL so we don not rely on something in the system
[zlib]
recipe = hexagonit.recipe.cmmi
url = http://www.zlib.net/zlib-1.2.3.tar.gz
configure-options = --shared
 
[PIL]
recipe = zc.recipe.egg:custom
egg = PIL
find-links = http://dist.repoze.org/
include-dirs = ${zlib:location}/include
library-dirs = ${zlib:location}/lib
rpath = ${zlib:location}/lib
```
 

* **Nota1**: Este es el momento perfecto para añadir los archivos que estan dentro del buildout a un repositorio git o SVN.
* **Nota 2**: Ahora es momento de configurar ~/.buildout/default.cfg para designar un directorio común de cache de huevos de python (.egg). (Link hacia la documentación de Plone).

Ejecutamos `bootstrap.py`

```
tzicatl@laptop:~/programar/my_djangobuildout$ python2.6 bootstrap.py 
Creating directory '/home/tzicatl/programar/my_djangobuildout/bin'.
Creating directory '/home/tzicatl/programar/my_djangobuildout/parts'.
Creating directory '/home/tzicatl/programar/my_djangobuildout/develop-eggs'.
Generated script '/home/tzicatl/programar/my_djangobuildout/bin/buildout'.
tzicatl@laptop:~/programar/my_djangobuildout$
```

Ahora ya podemos ejecutar el buildout que automaticamente bajará, compilará e
instalará Django, Zlib y PIL en un entorno aislado del sistema.  Lo que se va
a ver en la consola será algo como esto:

```
tzicatl@laptop:~/programar/my_djangobuildout$ bin/buildout 
Unused options for buildout: 'download-directory'.
Installing django.
Getting distribution for 'zc.buildout'.
Got zc.buildout 1.4.2.
Generated script '/home/tzicatl/programar/my_djangobuildout/bin/django'.
Generated script '/home/tzicatl/programar/my_djangobuildout/bin/django.wsgi'.
tzicatl@laptop:~/programar/my_djangobuildout$
```

Examinemos el directorio. Ahora el contenido del directorio lucirá así:

```console
tzicatl@laptop:~/programar/my_djangobuildout$ ls
bin  bootstrap.py  buildout.cfg  devel.cfg  develop-eggs  parts  projects  README.txt
tzicatl@laptop:~/programar/my_djangobuildout$ ls bin/
buildout  django  django.wsgi
tzicatl@laptop:~/programar/my_djangobuildout$ ls develop-eggs/
tzicatl@laptop:~/programar/my_djangobuildout$ ls parts/
django
tzicatl@laptop:~/programar/my_djangobuildout$ ls projects/
development.py  __init__.py  media  production.py  settings.py  templates  urls.py
tzicatl@laptop:~/programar/my_djangobuildout$
```

A continuación se explicará cáda uno de los directorios y archivos

* `bin/`: El directorio donde residen los programas y scripts para construir una instancia de django y controlarla.
* `develop-eggs/`: Aquí se depositan huevos de python
* `parts/`: Si existe alguna librería de python que no esté empaquetada como huevo (por ejemplo, zlib), este será el lugar donde residirán esas librerías.
* `projects/`: Aquí es donde depositaremos nuestro código que conformará nuestra aplicación de Django.

Hasta aquí la primera entrega de mis Notas.
