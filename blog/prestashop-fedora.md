---
title: PrestaShop en Fedora 27
date: 2018-01-30
description: 'Configuración de PrestaShop 1.7 sobre Fedora 27: instalación de paquetes LAMP, configuración de virtualhost Apache, permisos, SELinux y parámetros de la base de datos.'
tags:
- prestashop
- fedora
- lamp
- apache
- php-fpm
- mysql
- selinux
extra:
  deprecated_reason: Fedora 27 EOL desde diciembre de 2018; PrestaShop 1.7 EOL; el flujo moderno en Fedora 39+/40+ usa dnf con paquetes actualizados y DNF module para PHP 8.x. HolokinesisLibros cerró.
  deprecated: true
---

## PrestaShop en Fedora 27

Los comandos son todos como root:

```bash
sudo -i
```

Instalar el software:

```bash
dnf install community-mysql-server
dnf group install 'Web Server'
```

Si la instalación de MySQL es completamente nueva:

```bash
systemctl start mysql
mysql_secure_installation
```

Si ya tienes una instalación previa (por ejemplo, actualizaste de versión de Fedora):

```bash
mysqlcheck --all-databases --check-upgrade --auto-repair
systemctl start mysql
```

Ahora configuramos el virtualhost. El hostname de mi laptop es `starblade`. Voy a crear otro que se llame `pshop.starblade`. Para eso edito `/etc/hosts` y agrego la línea:

```
127.0.0.2  pshop.starblade
```

No hay ninguna razón en especial de por qué elegí `127.0.0.2` en lugar de `1`. El resultado es el mismo. Ahora probamos el nuevo hostname:

```console
$ ping pshop.starblade
PING pshop.starblade (127.0.0.2) 56(84) bytes of data.
64 bytes from pshop.starblade (127.0.0.2): icmp_seq=1 ttl=64 time=0.095 ms
64 bytes from pshop.starblade (127.0.0.2): icmp_seq=2 ttl=64 time=0.185 ms
^C
--- pshop.starblade ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1003ms
rtt min/avg/max/mdev = 0.095/0.140/0.185/0.045 ms
```

Ahora vamos con la configuración de Apache. En el archivo de configuración que está en `/etc/httpd/conf.d/pshop-vhost.conf` y tiene esto:

```apache
<VirtualHost *:80>
    ServerAdmin nnieto@localhost
    DocumentRoot "/var/www/pshop.starblade"
    ServerName pshop.starblade
    ServerAlias phop.starblade
    ErrorLog "/var/log/httpd/pshop.starblade-error_log"
    CustomLog "/var/log/httpd/pshop.starblade-access_log" common
    # LogLevel debug
    ProxyTimeout 300
    <Directory /var/www/pshop.starblade>
        <IfModule mod_php7.c>
            php_value max_execution_time 300
        </IfModule>
    </Directory>
</VirtualHost>
```

Guarda el archivo.

El directorio `/var/www/pshop.starblade` es una liga simbólica a `/home/nnieto/Code/HolokinesisLibros/hkl_pshop`:

```bash
ln -s /home/nnieto/Code/HolokinesisLibros/hkl_pshop /var/www/pshop.starblade
```

## Permisos y SELinux

PrestaShop (en realidad, `php-fpm`) corre como el usuario `apache`, pero necesita tener permisos de escritura en `app/logs`. Por otra parte el directorio `hkl_pshop` está en mi directorio `$HOME` y necesito editar archivos ahí. Así que los permisos de usuario son para mi cuenta y agrego permisos de escritura para el grupo `apache`:

```bash
chmod o+w app/logs/
ausearch -c 'php-fpm' --raw | audit2allow -M my-phpfpm
semodule -i my-phpfpm.pp
setsebool -P httpd_can_network_connect 1
setsebool -P httpd_read_user_content 1
```

## Configuración

PrestaShop 1.7 guarda la configuración en `app/config/`. La configuración de la base de datos está en `app/config/parameters.php`.

**FIN**
