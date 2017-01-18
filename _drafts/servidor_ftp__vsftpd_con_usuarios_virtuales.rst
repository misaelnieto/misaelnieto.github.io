servidor ftp: vsftpd con usuarios virtuales
===========================================

.. author:: default
.. categories:: none
.. tags:: none
.. comments::

Estas son mis notas de instalacion de un servicio FTP con Ubuntu 12.04, vsftpd
configurado con usuarios virtuales.


Instalacion de VSFTPD
----------------------

Primero instalar vsftpd.

.. code:: bash

    apt-get update
    apt-get upgrade -y
    apt-get install vsftpd

Configurar la base de datos
----------------------------

Luego necesitamos hacer la base de datos de usuarios virtuales. Vsftpd
normalmente se configura para que use la base de datos del sistema. Pero
tambien se puede configurar para usar una base de datos de usuarios de manera
independiente de la del sistema. A este modo de configuracion se le llama
**Usuarios virtuales**.

La documentacion en inglés la encontre `aqui <ftp://vsftpd.beasts.org/users/cevans/untar/vsftpd-3.0.2/EXAMPLE/VIRTUAL_USERS/README>`_.

Un usuario virtual de **vsftpd** no existe en la base de datos de usuarios de
Linux (p.ej. ``/etc/password`). De esta manera, **vsftpd** tiene el control
completo de que usuarios acceden al servicio FTP.

**vsftpd** usa las librerias de `PAM (Pluggable Authentication Modules)
<http://www.linux-pam.org/>`_ para manejar la autenticación de usuarios.
Muy en concreto, el paquete **vsftpd** tambien incluye un plugin para *PAM*.

Hacer diagramita de vsftpd-PAM ....


Configurar MySQL
----------------

.. code:: bash

    apt-get install mysql-server

Hice un archivo de texto con usuarios y contraseñas. El primer usuario
(``usuario_1``) va en la primera linea, y la contraseña de ``usuario_1``
(``f*g01l^n``) va en la linea 2, y as'i sucesivamente.

Ejemplo:

.. code::

    usuario1
    f*g01l^n
    usuario2
    trgw4@^6

Esta informacion la guarde en ``/root/archivo.txt``para usarla con el comando
``db_load`` para inicializar la base de datos de ``vsftpd`` con usuarios
virtuales. El comando ``db_load`` no viene instalado por default en ubuntu
12.04, asi que necesito instalarlo tambi'en.

.. code:: bash
    apt-get install db-util
    db_load -T -t hash -f /root/users.txt /etc/vsftpd.d/vsftpd_login.db
    chmod 600 /etc/vsftpd.d/vsftpd_login.db

Ahora es momento de configurar PAM para que permita que VSFTPD use la base de
datos que acabamos de crear.

La configuraci'on de PAM en Ubuntu 12.04 es una configuracion basada en el
directorio ``/etc/pam.d``, es decir, PAM toma en cuenta el nombre del archivo
dentro de ``/etc/pam.d`` para determinar el nombre del servicio al que le
corresponde la configuracion contenida en ese archivo. Ufff!! Aunque parezca
complejo, en realidad es muy simple: si quiero configurar la aplicaci'on
``vsftpd``, entonces necesito crear un archivo ``/etc/pam.d/vsftpd`` que
contiene la configuracion que deseo. Despues, en el archivo de configuraci'on
deber'e definir ``pam_service_name=vsftpd``.

Tuve que crear una cuenta de ftp para los usuarios:

.. code:: bash

    adduser --disabled-login ftp-user
    chmod 700 /home/ftp-user


Este es el contenido del archivo de configuracion ``/etc/pam.d/vsftpd``:

.. code::

    auth    required pam_userdb.so db=/etc/vsftpd.d/vsftpd_login.db
    account required pam_userdb.so db=/etc/vsftpd.d/vsftpd_login.db


Ahora falta configurar las cuentas virtuales del servidor FTP.



Aca tienes el archivo de configuracion completo:

.. code:: bash

    #########################################################
    # Ejecutar VSFTPD en modo daemon
    listen=YES

    #########################################################
    # Configuraciones de usuario
    anonymous_enable=NO
    local_enable=YES
    write_enable=NO
    use_localtime=YES
    xferlog_enable=YES
    nopriv_user=ftp
    guest_enable=NO
    write_enable=YES
    local_umask=0022
    chroot_local_user=NO
    check_shell=NO
    chmod_enable=NO
    hide_ids=YES
    userlist_enable=YES
    userlist_deny=NO
    user_config_dir=/etc/vsftpd.d/vusers

    #########################################################
    # Mensaje de bienvenida
    dirmessage_enable=YES
    ftpd_banner=Bienvenido a mi servidor FTP

    #########################################################
    # Configurar puerto de control y rango de puerto de datos. (PASIVO)
    connect_from_port_20=NO
    ftp_data_port=20
    listen_port=21
    pasv_enable=YES
    port_enable=YES
    pasv_min_port=3300
    pasv_max_port=3450
    pasv_promiscuous=NO
    port_promiscuous=NO

    #########################################################
    # Configurar autenticacion
    pam_service_name=vsftpd
    rsa_cert_file=/etc/ssl/private/vsftpd.pem

    #########################################################
    # Cosas varias
    vsftpd_log_file=/var/log/vsftpd.log
    dual_log_enable=YES

Este archivo de configuracion hace esto:

* VSFTPD en modo daemon/demonio
* No hay acceso a usuarios anonimos
* blah, blerg


Falta escribir la configuracion de usuarios

    mkdir /etc/vsftpd.d/users


Aañadir esto al final de sudoers (usar visudo)

    www-data ALL = NOPASSWD: /bin/chown root /etc/vsftpd/vusers/[a-zA-Z0-9]*
    www-data ALL = NOPASSWD: /bin/rm /etc/vsftpd/vusers/[a-zA-Z0-9]*




Ya solo falta reiniciar.


Voy a instalar un frontend administrativo para el servidor FTP. Eso es para
que cualquier usuario con permisos pueda administrar las cuentas virtuales del
servidor FTP.

Eleg VsftpdWeb en github https://github.com/Tvel/VsftpdWeb Esta escrito en
PHP. Asi que tengo que instalar el stack LAMP primero:


.. code:: bash

    sudo tasksel install lamp-server

La app tiene un buyen READMe, asi que lo quepongo es casi copia del README.

Instalar la aplicacion en /var/wwww

.. code:: bash

    sudo apt-get install -y git
    cd ~
    git clone https://github.com/Tvel/VsftpdWeb.git
    sudo mv VsftpdWeb/* /var/www/
    sudo chown -R www-data:www-data /var/www/*
    sudo touch /var/log/vsftpdweb.log

Crear subdirectorios
---------------------

.. code:: bash

    mkdir -p /home/ftp-user/ftproot/users
    mkdir /home/ftp-user/ftproot/data
    touch /home/ftp-user/vsftpdweb.log

Configurar la base de datos usando el shell de mysql::

.. code:: mysql

    CREATE DATABASE 'vsftpd' CHARACTER SET utf8 COLLATE utf8_general_ci;
    CREATE USER 'vsftpd'@'localhost' IDENTIFIED BY 'secureftp2014';
    GRANT ALL privileges ON vsftpd.* TO 'vsftpd'@'localhost';
    FLUSH PRIVILEGES;
    USE vsftpd;
    SOURCE  /var/www/install_readme/vsftpd.sql
    UPDATE settings set value=PASSWORD('pasguorsecreto') where name='admin';
    UPDATE settings set value='/home/ftp-user/vsftpdweb.log' where name='log_path';
    UPDATE settings set value='/home/ftp-user/ftproot/users' where name='user_path';
    UPDATE settings set value='/home/ftp-user/ftproot/data' where name='disk1';
    UPDATE settings set value='internalmail.domain.com' where name='mail_server';
    UPDATE settings set value='ftpservice@domain.com' where name='mail_user';
    UPDATE settings set value='ftpapsguor' where name='mail_password';



App administrativa
------------------




Configurar la aplicacion administrativa en /var/wwww

.. code:: bash

    sed -i 's/vsftpdweb/vsftpd/' /var/wwww/application/config/database.php
    sed -i 's/vsftpdadmin/secureftp2014/' /var/wwww/application/config/database.php

La primera linea edita ``/var/wwww/application/config/database.php`` y
configura el nombre de usuario mientras que la segunda configura la contrasena
de acceso la base de datos MySQL.

De manera alternativa, puedes simplemente editar el archivo con vi, nano,
pico, emacs o tu editor favorito.

Finalemente solo queda desactivar el modo de depuracion y quitar acceso a la
carpeta ``install_readme``.

.. code:: bash

    sudo chmod ugo-x /var/www/install_readme/


