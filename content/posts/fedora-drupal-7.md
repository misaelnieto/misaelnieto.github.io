---
title: "Preparando Fedora para Drupal 7 (borrador)"
summary: "Borrador crudo del post homónimo; la versión final está en fedora-drupal-estilo-noe."
description: "Borrador de trabajo del post de Drupal 7. La versión publicada y completa está en /blog/fedora-drupal-estilo-noe."
date: "2014-06-19"
draft: true
categories:
  - "Tutoriales"
  - "Linux"
tags:
  - drupal
  - fedora
  - php
  - drush
locale: "es_MX"
keywords: "drupal 7, fedora, php, drush, composer"
extra:
  deprecated: true
  deprecated_reason: "Borrador crudo del mismo post. La versión final, expandida y publicada está en /blog/fedora-drupal-estilo-noe."
---

> **Nota**: Este es un borrador de trabajo. La versión final y publicada de
> este post está en [`/blog/fedora-drupal-estilo-noe`](/blog/fedora-drupal-estilo-noe).

## Preparando Fedora para Drupal 7 al estilo Noe

## Intro

Tengo unos minutos libres y decidí complicarme la vida un poco más de lo que ya está.

![Drupal corriendo sin apache ni mysql](/static/images/posts/fedora-drupal-7/screenshot-from-2014-06-19-20-10-24.png)

Hace algunas semanas instalé Fedora desde cero y ya perdí todo lo que estaba haciendo con Drupal y se me ocurrió probar a ver si puedo arrancar Drupal 7 con el servidor web integrado de PHP para ahorrarme la configuración de Apache.

Y ya que estamos en el mismo camino, tampoco voy a instalar MySQL o MariaDB por que Drupal puede usar SQLite y también funciona bastante bien.

Entonces solo necesito instalar PHP, composer y drush para comenzar a trabajar.

## Instalando PHP

Instalé php junto con php-pdo (para SQLite) y php-gd para que Drupal pueda usar la librería de gráficos GD.

```bash
sudo yum install php php-cli php-pdo php-gd
```

Cuando se instala php, automáticamente se instala Apache. Para revisar si Apache se arranca junto con la máquina se puede hacer uso de `systemctl` (Fedora ya viene con systemd):

```bash
$ systemctl status httpd
httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled)
   Active: inactive (dead)
```

## Instalar composer

Ya tenemos php, ahora es necesario instalar [composer](https://getcomposer.org/) de manera local.

```bash
$ mkdir -p ~/bin
$ cd ~/bin
$ curl -sS https://getcomposer.org/installer | php
```

## Instalar Drush

Ahora es momento de instalar [drush](http://www.drush.org/en/master/) con:

```bash
$ composer.phar global require drush/drush:dev-master
```

Luego hice una liga simbólica hacia el directorio `~/bin`:

```bash
$ ln -s ~/.composer/vendor/drush/drush/drush ~/bin/drush
```

¿Por qué? Para que pueda invocar a drush desde cualquier ruta :)

## Instalar Drupal con Drush

Según [este sitio](http://www.coderintherye.com/install-drupal-7-using-drush) con Drush puedo instalar y configurar Drupal 7 en dos patadas. ¡Eso me gusta!
