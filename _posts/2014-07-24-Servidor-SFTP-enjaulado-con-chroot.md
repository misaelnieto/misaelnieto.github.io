---
title:  "Servidor SFTP enjaulado con chroot"
categories: Linux Servers DevOps
---

![En serio hice yo todo esto?](/media/4331271101_719f528ec6_o_0)

## Intro

Se trata de hacer un servidor SFTP pero que este _**cherooteado**_, ahem,
quiero decir *enjaulado*). Esto es diferente a un servidor FTP ya que SFTP se
instala en el servidor junto con SSH. Pero en esta ocasión sólo necesitamos
abrir accesso por SFTP para un usuario pero sin accesso a sesiones de SSH.

## Instalación

Cualquier Ubuntu o Fedora/Centos reciente va a funcionar.

## Configuración

Comienzo por crear el usuario `foo`:

```bash
useradd foo -g ftp -s /bin/nologin
```

El `-g` sirve para decirle a Linux qué grupo va a tener el usuario. El `-s`
indica que el intérprete de comandos de `foo`es `/bin/nologin`, esto causa que
el usuario no se pueda meter al sistema mediante ninguna consola, incluyendo
`ssh`.

Para comprobar esto hacemos un intento de logearnos en el servidor SSH con la
cuenta foo:

```bash
ssh foo@192.168.5.41

foo@192.168.5.41\'s password:
This service allows sftp connections only.
Connection to 192.168.5.41 closed.
```

Ahora es el momento de editar `/etc/ssh/sshd_config` y comentar/desabilitar la
directiva `Subsystem` si es que ya esta especificada y finalmente poner lo
sigueinte al final del archivo:

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

Ahora hay que recargar la configuracion de sshd:

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
Yeah! Tambien se pueden subir archivos al directorio `files`:

```console
sftp> cd files
sftp> PUT /home/nnieto/archivo.txt
Uploading /home/nnieto/archivo.txt to /files/archivo.txt
/home/nnieto/archivo.txt                                                                                                                                                                                    100%    0     0.0KB/s   00:00    
sftp>
```

Pero no se pueden subir archivos a la raiz del chroot :(

```console
sftp> cd /
sftp> PUT /home/nnieto/archivo.txt
Uploading /home/nnieto/archivo.txt to /archivo.txt
remote open("/archivo.txt"): Permission denied
```

Esto se debe a una de las limitaciones chroot.

## Links y referencias

Basado en informacion de:

* <https://wiki.archlinux.org/index.php/SFTP_chroot>

* <http://www.thegeekstuff.com/2012/03/chroot-sftp-setup/>

* <http://www.heitorlessa.com/sftp-jail-chroot-with-active-directory-authentication/>

----
Imagen del candado es de <https://flic.kr/p/7AJTZX>