servidor ftp: proftpd con usuarios virtuales
===========================================

.. author:: default
.. categories:: none
.. tags:: none
.. comments::

Estas son mis notas de instalacion de un servicio FTP con Ubuntu 12.04 y proftpd
configurado con usuarios virtuales.


Instalacion y configuracion de proftpd
--------------------------------------

Primero instalar proftpd.

.. code:: bash

    apt-get update
    apt-get upgrade -y
    apt-get install proftpd proftpd-mod-mysql mysql-server chrootuid

Instale proftpd como modo standalone.


Configurar la base de datos
----------------------------

Luego necesitamos hacer la base de datos de usuarios virtuales. proftpd
normalmente se configura para que use la base de datos del sistema. Pero
tambien se puede configurar para usar una base de datos de usuarios de manera
independiente de la del sistema. A este modo de configuracion se le llama
**Usuarios virtuales**.

Encontre un buen howto `aqui <https://www.digitalocean.com/community/articles/how-to-set-up-proftpd-with-a-mysql-backend-on-ubuntu-12-10>`_.

Un usuario virtual de **proftpd** no existe en la base de datos de usuarios de
Linux (es decir, en ``/etc/password`). De esta manera, **proftpd** tiene el control
completo de que usuarios acceden al servicio FTP.

Primero, hice un usuario llamado ftp-user en la BD Mysql. Use MySQL Workbench.

Anhade una BD que se llama proftpd, collation UTF-8

    CREATE SCHEMA `proftpd` DEFAULT CHARACTER SET utf8 ;


le di permisos SELECT, INSERT, UPDATE, DELETE, EXECUTE SHOW VIEW al usuario
ftp-user@localhost en la BD proftpd.


Ahora hay que crear dos bases de datos para guardar informacion de cuentas.

* Se puede crear con laravel.

    USE proftpd;

    CREATE TABLE `ftp_groups` (
      `group_name` varchar(16) NOT NULL,
      `gid` smallint(6) NOT NULL DEFAULT '5500',
      `members` varchar(16) NOT NULL,
      KEY `groupname` (`group_name`)
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='ProFTP group table';


    CREATE TABLE `ftp_users` (
      `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
      `user_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
      `passwd` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
      `uid` int(11) NOT NULL,
      `gid` int(11) NOT NULL,
      `home_dir` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
      `shell` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
      `count` int(11) NOT NULL,
      `accessed_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
      `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
      `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
      PRIMARY KEY (`id`),
      UNIQUE KEY `ftp_users_user_id_unique` (`user_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



Ahora hay que crear un usuario virtual.

    INSERT INTO `proftpd`.`ftp_users` (
        `user_id`,
        `passwd`,
        `uid`,
        `gid`,
        `homedir`
    )

    VALUES (
        "ftp-teste",
        "{md5}JdVa0oOqQAr0ZMdtcTwHrQ==",
        5500,
        5500,
        "/var/ftp/ftp-teste"
    );


LoadModule mod_sql.c
LoadModule mod_sql_mysql.c


Create Your User
Click on the "ftpuser" table in the left column and then on the "Insert" tab.

This allows you to insert a user. Populate the userid (which is the username a user will login to FTP) and homedir (the FTP user home - should be present on the system).

Password in the passwd field should be encrypted, to do so you can use this snippet (on your server shell) to generate the password string you can paste into the passwd field:

/bin/echo "{md5}"`/bin/echo -n "12345678" | openssl dgst -binary -md5 | openssl enc -base64`


Of course replace "password" with your/users desired password.
Here you can see some other field that are self explanatory and are usually used later (login count, last logged in...).

There, you have the correct database, now we just need to configure ProFTPD to use it.



Permisos de usuario
mkdir /var/ftp
chown proftpd:nogroup ftp
chmod 755 /var/ftp

mkdir /var/ftp/ftp-teste
chown 5500:5500 /var/ftp/ftp-teste
chmod 755 /var/ftp/ftp-teste



Continua configuracion de proftpd
---------------------------------


Es buena idea crear una cuenta de ftp para que el servicio corra sin
privilegios de root.

.. code:: bash

    adduser --disabled-login ftp-user
    chmod 700 /home/ftp-user


Este es el contenido del archivo de configuracion ``/etc/pam.d/proftpd``:

.. code::

    auth    required pam_userdb.so db=/etc/proftpd.d/proftpd_login.db
    account required pam_userdb.so db=/etc/proftpd.d/proftpd_login.db


Ahora falta configurar las cuentas virtuales del servidor FTP.



Aca tienes el archivo de configuracion completo:

.. code:: apache

    DefaultServer Off
    DefaultAddress 127.0.0.1
    RequireValidShell Off
    LoadModule mod_sql.c
    LoadModule mod_sql_mysql.c

    <VirtualHost 10.2.0.67 internalftp.valuout.com ftp.valuout.com>
       ServerAdmin          nnieto@valuout.com
       ServerName           "Valutech FTP"
       DeferWelcome         on
       Port                 21
       MaxLoginAttempts     3
       Maxclients           25
       DefaultRoot          ~
       RequireValidShell    Off
       SQLBackend           mysql
       SQLAuthTypes         OpenSSL
       SQLAuthenticate      users groups
       SQLConnectInfo       proftpd@localhost proftpd Pa$$w0rD!
       SQLUserInfo          ftp_user user_id passwd uid gid home_dir shell
       SQLGroupInfo         ftp_group group_name gid members
       SQLMinId             5500
       SQLLog               PASS update_count
       SQLNamedQuery        update_count UPDATE "count=count+1, accessed=now() WHERE user_id='%u'" user_id
       SQLLog               STOR,DELE modified
       SQLNamedQuery        modified UPDATE "modified=now() WHERE user_id='%u'" user_id
       SQLLogFile           /var/log/proftpd/mod_sql.log
    </Virtualhost>





