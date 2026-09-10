---
title: Servidor SFTP enjaulado con chroot
date: 2014-07-24
description: 'Tutorial para configurar un servidor SFTP enjaulado con chroot en OpenSSH: crear usuario con /bin/nologin, configurar Match User + ForceCommand internal-sftp y los permisos correctos del directorio chroot.'
tags:
- sftp
- ssh
- chroot
- openssh
- sysadmin
---

![SFTP enjaulado con chroot](/static/images/posts/Servidor-SFTP-enjaulado-con-chroot/swan-psf.svg)

## Intro

Se trata de hacer un servidor SFTP pero que esté _**cherooteado**_, ahem,
quiero decir *enjaulado*. Esto es diferente a un servidor FTP ya que SFTP se
instala en el servidor junto con SSH. Pero en esta ocasión sólo necesitamos
abrir acceso por SFTP para un usuario, pero sin acceso a sesiones de SSH.

## Instalación

Cualquier Ubuntu o Fedora/CentOS reciente va a funcionar.

## Configuración

Comienzo por crear el usuario `foo`:

```bash
useradd foo -g ftp -s /bin/nologin
```

El `-g` sirve para decirle a Linux qué grupo va a tener el usuario. El `-s`
indica que el intérprete de comandos de `foo` es `/bin/nologin`; esto causa que
el usuario no se pueda meter al sistema mediante ninguna consola, incluyendo
`ssh`.

Para comprobar esto hacemos un intento de loguearnos en el servidor SSH con la
cuenta `foo`:

```bash
ssh foo@192.168.5.41

foo@192.168.5.41's password:
This service allows sftp connections only.
Connection to 192.168.5.41 closed.
```

Ahora es el momento de editar `/etc/ssh/sshd_config` y comentar/deshabilitar la
directiva `Subsystem` si es que ya está especificada, y finalmente poner lo
siguiente al final del archivo:

```
Match User foo
    ChrootDirectory /var/sftp/foo/chroot
    ForceCommand internal-sftp
    AllowTcpForwarding no
    X11Forwarding no
    AuthorizedKeysFile /var/sftp/foo/chroot/.ssh/authorized_keys
```

Guarda los cambios y crea los directorios (como `root`):

```console
mkdir -p /var/sftp/foo/chroot
chown -R root:root /var/sftp
touch /var/sftp/foo/chroot/.ssh/authorized_keys
chmod 600 /var/sftp/foo/chroot/.ssh/authorized_keys
mkdir /var/sftp/foo/chroot/files
chown foo:foo /var/sftp/foo/files
```

Ahora hay que recargar la configuración de sshd:

```console
service ssh reload
```

Ya comprobamos que el usuario `foo` no puede entrar con ssh. Vamos a ver si se
puede meter con `sftp`:

```console
sftp foo@192.168.5.41
foo@192.168.5.41's password:
Connected to 192.168.5.41.
sftp> ls
files
sftp>
```

Yeah! También se pueden subir archivos al directorio `files`:

```console
sftp> cd files
sftp> PUT /home/nnieto/archivo.txt
Uploading /home/nnieto/archivo.txt to /files/archivo.txt
/home/nnieto/archivo.txt   100%   0   0.0KB/s   00:00
sftp>
```

Pero no se pueden subir archivos a la raíz del chroot :(

```console
sftp> cd /
sftp> PUT /home/nnieto/archivo.txt
Uploading /home/nnieto/archivo.txt to /archivo.txt
remote open("/archivo.txt"): Permission denied
```

Esto se debe a una de las limitaciones de chroot.

## Links y referencias

Basado en información de:

* <https://wiki.archlinux.org/index.php/SFTP_chroot>

* <http://www.thegeekstuff.com/2012/03/chroot-sftp-setup/>

* <http://www.heitorlessa.com/sftp-jail-chroot-with-active-directory-authentication/>

---
Imagen del candado: <https://flic.kr/p/7AJTZX>
