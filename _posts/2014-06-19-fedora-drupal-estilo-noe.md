---
layout: post
title:  "Preparando Fedora para Drupal 7 al estilo Noe"
categories: Linux Fedora Drupal
---


## Intro

![PHP corriendo su servidor interno desde la linea de comandos]({{ site.url }}/media/Screenshot-2014-06-19-20_10_24.png)

Tengo unos minutos libres y decidí complicarme la vida un poco más de lo que
ya esta. Resulta que hace algunas semanas instale Fedora desde cero y ya perdi
todo lo que estaba haciendo con Drupal. Ahora lo tengo que re hacer, pero:

* No voy a usar Apache por que PHP ya trae un servidor web integrado y
* funciona bastante bien para desarrollar cosas en Drupal.

* Tampoco voy a instalar MySQL o MariaDB por que Drupal puede usar SQLite y
* tambien funciona bastante bien.

* Solo necesito instalar PHP, composer y drush para comenzar a chambear.

¡Manos a la obra!

## Instalando PHP

Instalé `php` junto con `php-pdo` (para SQLite) y `php-gd` para que Drupal pueda
usar la librería de gráficos GD.

```bash
sudo yum install php php-cli php-pdo php-gd
```

Cuando se instala php, automaticamente se instala Apache. Para revisar si
Apache se arranca junto con la maquina se puede hacer uso de `systemctl` (Fedora
ya viene con systemd)

```bash
$ systemctl status httpd
httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled)
   Active: inactive (dead)
```

## Instalar composer

Ya tenemos php, ahora es necesario instalar
[composer](https://getcomposer.org/) de manera local.

```bash
$ mkdir -p ~/bin
$ cd ~/bin
$ curl -sS https://getcomposer.org/installer | php
All settings correct f0r using Composer

Downloading...

Composer successfully installed to: /home/nnieto/bin/composer.phar
Use it: php composer.phar
```

El primer comando es para crear el directorio `~/bin`. Fedora ya esta
configurado para incluir ese directorio en `$PATH`. Si en ese directorio
colocamos algun o script que sea ejecutable, podremos invocarlo solo con su
nombre desde cualquier lugar.

## Instalar Drush

Ahora es momento de instalar [Drush](https://github.com/drush-ops/drush) con:

```bash
$ composer.phar global require drush/drush:dev-master

Changed current directory to /home/nnieto/.composer
./composer.json has been updated
Loading composer repositories with package information
Updating dependencies (including require-dev)
  - Updating drush/drush dev-master (7dd8076 => 12942ed)
    Checking out 12942ed3eaf8b6be5372baec32169ba61a04b22f

Writing lock file
Generating autoload files
```
Luego hice una liga simbólica hacia el directorio `~/bin`

```bash
$ ln -s ~/.composer/vendor/drush/drush/drush ~/bin/drush
```

¿Por qué? Para que pueda invocar a drush desde cualquier ruta :)

## Instalar Drupal con Drush

Según [este sitio](http://www.coderintherye.com/install-drupal-7-using-drush)
con Drush puedo instalar y configura Drupal 7 en dos patadas. ¡Eso me gusta!

```bash
$ drush dl drupal-7.x
Project drupal (7.x-dev) downloaded to /home/nnieto/Code/Hkl/hkl_drupal/drupal-7.x-dev.   [success]
Project drupal Contains:                                                                  [success]
 - 3 profiles: standard, minimal, testing
 - 4 themes: seven, stark, bartik, garland
 - 47 modules: update, menu, dashboard, simpletest, forum, image, help, aggregator, rdf, blog, syslog, search, dblog, trigger, locale, profile, number, text,
field_sql_storage, options, list, field, translation, shortcut, taxonomy, field_ui, toolbar, user, file, comment, tracker, system, color, php, contextual,
block, statistics, contact, openid, node, overlay, book, poll, filter, path, drupal_system_listing_incompatible_test, drupal_system_listing_compatible_test
```

¿Qué hizo? Bajó una copia de Drupal (asumo que era la más reciente) y la puso
en una carpeta de nombre drupal-7.x-dev. Nada mal.

Ahora es momento de usar drush para configurar el sitio desde la linea de comandos:

```bash
$ cd drupal-7.x-dev
$ drush site-install standard --account-name=admin --account-pass=admin --db-url=sqlite://sites/default/files/.ht.sqlite

You are about to CREATE the 'sites/default/files/.ht.sqlite' database.
Do you want to continue? (y/n): y
Starting Drupal installation. This takes a few seconds ...       [ok]
Installation complete.  User name: admin  User password: admin   [ok]

```

¡Ooookey! ¿Qué quiere decir esto? ¿Ya instaló y configuró Drupal? ¿Apoco ya no
necesito correr el wizard de instalación? ¿Dónde puso la base de datos?

Primero contesto la última pregunta: ¿Dónde metio la base de datos? Bueno, yo
se que estoy dentro del directorio de instalación de Drupal y que la URI de la
base de datos fue `sqlite://sites/default/files/.ht.sqlite` y además esa URI se
parece  al directorio sites de Drupal. ¿Será?

```bash
$ ls -la sites/default/files/
total 780
drwxrwxr-x. 3 nnieto nnieto   4096 Jun 19 19:52 .
dr-xr-xr-x. 3 nnieto nnieto   4096 Jun 19 19:43 ..
-r--r--r--. 1 nnieto nnieto    476 Jun 19 19:45 .htaccess
-rw-r--r--. 1 nnieto nnieto 778240 Jun 19 19:52 .ht.sqlite
drwxrwxr-x. 2 nnieto nnieto   4096 Jun 19 19:46 styles
```

¡Si! Ahí esta el archivo `.ht.sqlite :) Ya voy entendiendo...


## Corriendo el servidor web de PHP

Python y Node.js traen servidores web integrados. Esos servidores web son muy
básicos que no estan hechos para ponerlos en producción. Pero sirven muy bien
para desarrollo y evitar la molestia de configurar un servidor real. PHP
también tiene un servidor web integrado. Me lo dijeron en
[StackExchange](http://drupal.stackexchange.com/questions/111200/how-to-run-drupal-from-the-console)
;).

```bash
$ php -S localhost:8000
PHP 5.5.13 Development Server started at Thu Jun 19 20:05:10 2014
Listening on http://localhost:8000
Document root is /home/nnieto/Code/Hkl/hkl_drupal/drupal-7.x-dev
Press Ctrl-C to quit.
```
**Actualización**: Las versiones recientes de Drush incluyen un comando `rs` que
ejecuta el servidor web integrado de php en el puerto `8888`.

Y si, funciona:

![Drupal funcionando en el servidor web integrado de PHP]({{ site.url }}/media/Screenshot_from_2014_06_19_20_06_56_0.png)

¿Cómo te quedó el ojo?

-- Fin