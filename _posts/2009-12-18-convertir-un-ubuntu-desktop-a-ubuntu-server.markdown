---
title: Convertir un Ubuntu desktop a Ubuntu server
layout: post
categories: Linux
---

En la oficina surgiío la necesidad de instalar un servidor ubuntu en una MAC
G5. La red andaba fallando y bajar el ISO de ubuntu-server para powerpc no era
una opción viable. Afortunadamente teníamos un cd de ubuntu-desktop. 9.04
(Jaunty Jackalope)


## Paso 1

Respaldar toda la info del MACOS X. Ya hay muchas guías para esto.

## Paso 2

Instalar Ubuntu Desktop en la máquina. Ya hay muchas guías para esto.

## Paso 3

Instalar el paquete openssh-server para poder conectarse remotamente. Esto lo
necesitamos por que primero vamos a "tirar" las X Window.

Nos conectamos al server

```console
tzicatl@hormiga-negra :~ $ ssh <ip nuevo-server>
Last login: Fri Dec 18 18:49:35 2009

tzicatl@iservices-server :~ $
```

Tiramos las X.

```console
tzicatl@iservices-server:~$ tzicatl@iservices-server:~$ sudo service gdm stop
 * Stopping GNOME Display Manager..

tzicatl@iservices-server:~$
```

Tiramos Avahi

```console
tzicatl@iservices-server:~$ sudo service avahi-daemon stop
 * Stopping Avahi mDNS/DNS-SD Daemon avahi-daemon 

tzicatl@iservices-server:~$
```

Con esto debe ser suficiente para que el servidor se parezca a un ubuntu-
server de manera temporal.

## Paso 4

Vamos a remover la mayor cantidad de paquetes del entorno gráfico.

```console
tzicatl@iservices-server:~ $ sudo apt-get update
tzicatl@iservices-server:~ $ sudo apt-get remove gnome-* x11-*
```

Nota 1: Esta última instrucción puede llevar laaaaaargo tiempo. Ser paciente es la clave.

Nota 2: Al desinstalar el Network Manager te desconecta de ssh. Se puede reconectar con sudo dhclient en la consola del servidor.

```console
tzicatl@iservices-server:~ $ sudo apt-get autoremove
tzicatl@iservices-server:~ $ sudo apt-get autoclean
```

## Paso 5

Ahora instalamos MySQL, Apache2 y PHP5

```console
tzicatl@iservices-server:~ $ sudo apt-get install apache2 php5 libapache2-mod-php5 php5-mysql 
mysql-server
```

 Después instalamos dos buenos paquetes: Vim y Midnight Commander.

```console
 tzicatl@iservices-server:~$ sudo apt-get install mc vim-nox
```

# Paso 6
Ya al final hay que reiniciar y configurar la red a mano.

Salud!
