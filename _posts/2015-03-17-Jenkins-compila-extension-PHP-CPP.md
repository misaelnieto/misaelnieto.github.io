---
title: "Jenkins para compilar e instalar una extension de PHP con PHP-CPP"
categories: Jenkins DevOps Php
---

![Un gancho](/media/Grappling_hook_2_PSF.png)

## Intro

Este post es para dar seguimiento a uno anterior:
[Programa, compila e instala tu propia extension de PHP con PHP-CPP]({% post_url 2015-03-12-php-extension-php-phpcpp %}).

El siguiente paso es reconstruir el plugin cada vez que se hace comit al
repositorio (SVN, pero puede ser git o mercurial). El repositorio tiene una
carpeta donde se encuentra el plugin y otra carpeta donde se encuentra la
aplicacion PHP. Después de varias pruebas, la manera más adecuada de integrar
el svn con Jenkins fue mediante un "gancho" (`post-commit` hook) que le notifica
a jenkins, mediante una URL, que hay  novedades en repositorio.

## Instalando Jenkins en Ubuntu 14.04

La documentación de Jenkins es bastante buena. De ahí saqué las siguientes instrucciones:

```console
wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
```

Por default, el paquete de Jenkins lo configurará como un servicio o daemon y creará el usuario jenkins.

## Configurando el proyecto de Jenkins

Estos son los settings que use para el proyecto

* **Project Name**: Build PHP module
* **Description**: <vacio>
* **Discard old builds**: desactivado
* **This build is parametrized**: desactivado
* **Disable build ...**: desactivado
* **Execute concurrent builds if necessary**: desactivado
* Advanced project options
    - **Quiet period**: desactivado
    - **Retry count**: desactivado
    - **Block build when upstream ...**: desactivado
    - **Bloick build when downstream ...**: desactivado
    - **Use custom workspace**: activado
        + **Directory**: build_php_module
    - **Display name**: <vacio>
    - **Keep the build lofs of dependencies**: desactivado
* **Source code management**: None
* Build triggers:
    - **Trigger builds remotely**: Activado
    - **Authentication Token**: df0596e175d43a406ec7c229090bb51e
    - **Build after other projects are built**: desactivado
    - **Build periodically**: desactivado
    - **Poll SCM**: desactivado
* *Build*: Agregué un comando de shell. Mas detalles a continuación.

## Configurando gancho de SVN

Justo despues de agregar el primer proyecto la url para disparar la ejecucion
del proyecto sera algo parecido a esto:

```
http://misitio:8080/job/Build%20PHP%20Project/build?token=a406ec7d75d43c229090bb51ef0596e1&cause=Revision+$2
```

Esto se puede hacer desde el gancho post-commit de svn. Por ejemplo:

```bash
#!/bin/sh
# Checa post-commit.tpl para ver los comentarios.
REPOS="$1"
REV="$2"
TXN_NAME="$3"
curl http://misitio:8080/job/Build%20PHP%20Project/build?token=a406ec7d75d43c229090bb51ef0596e1&cause=Revision+$2
```

Con eso nos aseguramos que el proyecto de jenkins se ejecute solamente cada
vez que se haga un *commit* en el svn.

## Configuracion de directorios y permisos

Cuando Jenkins ejecuta un script de shell lo hace con los permisos del usuario
Jenkins. Es por esta razón que deberemos ajustar algunos permisos en el
servidor para que Jenkins pueda compilar la extensión y actualizar la
aplicacion PHP.

Antes de escribir el script de shell hice un checkout del repo de la extensión
en `/opt/extension-php/`. Tambien hice chechout de la aplicacion en que usa la
extensión en el directorio `/var/www/php_app`. Omito la configuración de la
extensión ya que he comentado cómo configurarla en [Programa, compila e instala
tu propia extensión de PHP con PHP-CPP]({% post_url 2015-03-12-php-extension-php-phpcpp %}).

Finalmente cambie el usuario de ambas carpetas al usuario jenkins.

```shell
chown -R jenkins /opt/extension-php/
chown -R jenkins /var/www/php_app
```

Por ultimo, un requerimiento algo inusual. Despues de recompilar la extensión
de PHP es necesario reinicar apache. El usuario jenkins debe de tener permisos
para reinicar el servidor apache. Esto se logra configurando sudo.

En Ubuntu/Debian sudo se puede configurar agregando archivos a `/etc/sudoers.d`
en lugar de usar `visudo`. El contenido del archivo
`/etc/sudoers.d/90-jenkins_apache2` sera:

```
Cmnd_Alias AP2RESTART=/etc/init.d/apache2
jenkins ALL=NOPASSWD: AP2RESTART
```

Para comprobarlo podemos arrancar una sesion con el usuario jenkins e intentar
reiniciar apache2:

```shell
root@rtbcore01:~# su jenkins
jenkins@rtbcore01:/root$ cd
jenkins@rtbcore01:~$ sudo /etc/init.d/apache2 restart
 * Restarting web server apache2
   ...done.
```

## Script para construir la extension y actualizar la aplicación PHP

Ya esta todo configurado. Es script que debera correr Jenkins es el siguiente:

```bash
#!/bin/bash

echo "###### Building extension"
cd /var/www/rtb_build/RTB_c++
/usr/bin/svn cleanup --username 'ebarradas' --password 'ederbarradas' --non-interactive .
/usr/bin/svn update --username 'ebarradas' --password 'ederbarradas' --non-interactive .
/usr/bin/make clean
PATH=/usr/local/bin:/usr/bin:/bin /usr/bin/make

echo "###### Deploy app"
cd /var/www/vhosts/rtb.srax.com/srax_app
/usr/bin/svn cleanup --username 'ebarradas' --password 'ederbarradas' --non-interactive .
/usr/bin/svn update --username 'ebarradas' --password 'ederbarradas' --non-interactive .

echo "###### restarting apache"
sudo /etc/init.d/apache2 restart
```

Y eso es todo.

----

Imagen tomada de: [Wikimedia](http://upload.wikimedia.org/wikipedia/commons/4/4a/Grappling_hook_2_%28PSF%29.png)


