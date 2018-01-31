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


Ahora configuramos el virtualhost. My hostname 
