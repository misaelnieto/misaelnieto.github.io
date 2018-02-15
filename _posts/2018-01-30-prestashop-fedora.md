---
published: false
---
## Prestashop en Fedora 27

Los comandos son todos como root

sudo -i

Instalar el software

dnf install community-mysql-server
dnf group install 'Web Server'

Si la instalacion de mysql es completamente nueva

systemctl start mysql
mysql_secure_installation

Si ya tienes una instalacion previa (por ejemplo, actualizaste de version de Fedora):

mysqlcheck --all-databases --check-upgrade --auto-repair
systemctl start mysql

Ahora configuramos el virtualhost. El hostname de mi laptop es starblade. Voy a crear otro que se llame pshop.starblade. Para eso edito /etc/hosts y agrego la linea:

127.0.0.2  pshop.starblade

No hay ninguna razon en especial de por que elegí 127.0.0.2 en lugar de 1. El resultado es el mismo. Ahora probamos el nuevo hostname:

ping pshop.starblade
PING pshop.starblade (127.0.0.2) 56(84) bytes of data.
64 bytes from pshop.starblade (127.0.0.2): icmp_seq=1 ttl=64 time=0.095 ms
64 bytes from pshop.starblade (127.0.0.2): icmp_seq=2 ttl=64 time=0.185 ms
^C
--- pshop.starblade ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1003ms
rtt min/avg/max/mdev = 0.095/0.140/0.185/0.045 ms

Ahora vamos con la configuración de Apache. En el archivo de configuracion es `/etc/httpd/conf.d/pshop-vhost.conf` y tiene esto: 

```apache
<VirtualHost *:80>
    ServerAdmin nnieto@localhost
    DocumentRoot "/var/www/pshop.starblade"
    ServerName pshop.starblade
    ServerAlias phop.starblade
    ErrorLog "/var/log/httpd/pshop.starblade-error_log"
    CustomLog "/var/log/httpd/pshop.starblade-access_log" common
    LogLevel debug
    ProxyTimeout 300
    <Directory /var/www/pshop.starblade>
        <IfModule mod_php7.c>
            php_value max_execution_time 300
        </IfModule>
    </Directory>
</VirtualHost>
```

Guarda el archivo. /var/www/pshop.starblade es una liga simbolica a /home/nnieto/Code/HolokinesisLibros/hkl_pshop

ln -s /home/nnieto/Code/HolokinesisLibros/hkl_pshop /var/www/pshop.starblade


## Permisos y SE Linux

chmod o+w app/logs/
ausearch -c 'php-fpm' --raw | audit2allow -M my-phpfpm
semodule -i my-phpfpm.pp
setsebool -P httpd_can_network_connect 1
setsebool -P httpd_read_user_content 1

## Configuracion

Prestashop 1.7 guarda la configuración en app/config/. La configuración de la base de datos esta en app/config/parameters.php
