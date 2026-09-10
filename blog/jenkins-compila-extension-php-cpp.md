---
title: Jenkins para compilar e instalar una extensión de PHP con PHP-CPP
date: 2015-03-17
description: Tutorial paso a paso para configurar Jenkins en Ubuntu 14.04 con un hook post-commit de SVN que dispara la recompilación de una extensión PHP en C++ y el deploy a Apache.
tags:
- jenkins
- php
- devops
- ci-cd
- svn
- apache
extra:
  deprecated_reason: Jenkins moderno tiene UI y DSL muy distintos (Pipeline as code); SVN ha sido reemplazado por Git en casi todos los equipos; PHP 5 y /etc/init.d/apache2 están obsoletos. Las credenciales expuestas en el post original han sido redactadas.
  deprecated: true
---

![Un gancho](/static/images/posts/Jenkins-compila-extension-PHP-CPP/grappling-hook-2-psf.png)

## Intro

Este post es para dar seguimiento a uno anterior: [Programa, compila e instala
tu propia extensión de PHP con PHP-CPP](/blog/php-extension-php-phpcpp).

El siguiente paso es reconstruir el plugin cada vez que se hace *commit* al
repositorio (SVN, pero puede ser Git o Mercurial). El repositorio tiene una
carpeta donde se encuentra el plugin y otra carpeta donde se encuentra la
aplicación PHP. Después de varias pruebas, la manera más adecuada de integrar
el SVN con Jenkins fue mediante un «gancho» (`post-commit` hook) que le
notifica a Jenkins, mediante una URL, que hay novedades en el repositorio.

## Instalando Jenkins en Ubuntu 14.04

La documentación de Jenkins es bastante buena. De ahí saqué las siguientes
instrucciones:

```console
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
```

Por defecto, el paquete de Jenkins lo configurará como un servicio o daemon y
creará el usuario `jenkins`.

## Configurando el proyecto de Jenkins

Estos son los settings que usé para el proyecto:

* **Project Name**: Build PHP module
* **Description**: *vacío*
* **Discard old builds**: desactivado
* **This build is parametrized**: desactivado
* **Disable build...**: desactivado
* **Execute concurrent builds if necessary**: desactivado
* Advanced project options
    - **Quiet period**: desactivado
    - **Retry count**: desactivado
    - **Block build when upstream...**: desactivado
    - **Block build when downstream...**: desactivado
    - **Use custom workspace**: activado
        + **Directory**: `build_php_module`
    - **Display name**: *vacío*
    - **Keep the build logs of dependencies**: desactivado
* **Source code management**: None
* Build triggers:
    - **Trigger builds remotely**: Activado
    - **Authentication Token**: `<token-secreto>` *(redactado)*
    - **Build after other projects are built**: desactivado
    - **Build periodically**: desactivado
    - **Poll SCM**: desactivado
* *Build*: Agregué un comando de shell. Más detalles a continuación.

## Configurando el gancho de SVN

Justo después de agregar el primer proyecto, la URL para disparar la ejecución
del proyecto será algo parecido a esto:

```
http://misitio:8080/job/Build%20PHP%20Project/build?token=<token-secreto>&cause=Revision+$2
```

Esto se puede hacer desde el gancho `post-commit` de SVN. Por ejemplo:

```bash
#!/bin/sh
# Checa post-commit.tpl para ver los comentarios.
REPOS="$1"
REV="$2"
TXN_NAME="$3"
curl "http://misitio:8080/job/Build%20PHP%20Project/build?token=<token-secreto>&cause=Revision+$2"
```

Con eso nos aseguramos que el proyecto de Jenkins se ejecute solamente cada
vez que se haga un *commit* en el SVN.

## Configuración de directorios y permisos

Cuando Jenkins ejecuta un script de shell lo hace con los permisos del usuario
`jenkins`. Es por esta razón que deberemos ajustar algunos permisos en el
servidor para que Jenkins pueda compilar la extensión y actualizar la
aplicación PHP.

Antes de escribir el script de shell hice un checkout del repo de la extensión
en `/opt/extension-php/`. También hice checkout de la aplicación que usa la
extensión en el directorio `/var/www/php_app`. Omito la configuración de la
extensión ya que he comentado cómo configurarla en [Programa, compila e
instala tu propia extensión de PHP con PHP-CPP](/blog/php-extension-php-phpcpp).

Finalmente cambié el usuario de ambas carpetas al usuario `jenkins`:

```bash
chown -R jenkins /opt/extension-php/
chown -R jenkins /var/www/php_app
```

Por último, un requerimiento algo inusual: después de recompilar la extensión
de PHP es necesario reiniciar Apache. El usuario `jenkins` debe tener permisos
para reiniciar el servidor Apache. Esto se logra configurando `sudo`.

En Ubuntu/Debian `sudo` se puede configurar agregando archivos a
`/etc/sudoers.d` en lugar de usar `visudo`. El contenido del archivo
`/etc/sudoers.d/90-jenkins_apache2` será:

```
Cmnd_Alias AP2RESTART=/etc/init.d/apache2
jenkins ALL=NOPASSWD: AP2RESTART
```

Para comprobarlo podemos arrancar una sesión con el usuario `jenkins` e
intentar reiniciar Apache 2:

```bash
root@rtbcore01:~# su jenkins
jenkins@rtbcore01:/root$ cd
jenkins@rtbcore01:~$ sudo /etc/init.d/apache2 restart
 * Restarting web server apache2
   ...done.
```

## Script para construir la extensión y actualizar la aplicación PHP

Ya está todo configurado. El script que deberá correr Jenkins es el siguiente:

```bash
#!/bin/bash

echo "###### Building extension"
cd /var/www/rtb_build/RTB_c++
/usr/bin/svn cleanup --username '<usuario-svn>' --password '<password-svn>' --non-interactive .
/usr/bin/svn update --username '<usuario-svn>' --password '<password-svn>' --non-interactive .
/usr/bin/make clean
PATH=/usr/local/bin:/usr/bin:/bin /usr/bin/make

echo "###### Deploy app"
cd /var/www/vhosts/rtb.srax.com/srax_app
/usr/bin/svn cleanup --username '<usuario-svn>' --password '<password-svn>' --non-interactive .
/usr/bin/svn update --username '<usuario-svn>' --password '<password-svn>' --non-interactive .

echo "###### restarting apache"
sudo /etc/init.d/apache2 restart
```

**FIN**

---

Imagen tomada de:
[Wikimedia](http://upload.wikimedia.org/wikipedia/commons/4/4a/Grappling_hook_2_%28PSF%29.png)
