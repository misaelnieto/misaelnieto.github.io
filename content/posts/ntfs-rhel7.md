---
title: "Cómo montar unidades con formato NTFS en RHEL 7.3"
date: "2017-08-02"
categories: []
tags:
  - rhel
  - linux
  - ntfs
  - filesystem
image: "/static/images/posts/ntfs-rhel7/oil-lamps-294331.svg"
---

Instale RHEL 7.3 en una laptop (HP Probook 4720s) para poder correr [TCAD de Silvaco](https://www.silvaco.com/products/tcad.html "Click para ver que diablos es TCAD").

![Propiedades del sistema en RHEL 7](/static/images/posts/ntfs-rhel7/screenshot-2017-08-02-165641.png)



Mientras que Fedora 26 ya trae [Gnome 3.24](https://www.gnome.org/news/2017/03/gnome-3-24-released/), RHEL 7.3 viene con [Gnome 3.14](https://help.gnome.org/misc/release-notes/3.14/), con dos años de diferencia. Eso implica que aun le falta una gran cantidad de mejoras recientes del entorno Gnome. Por otro lado, Es una lastima que TCAD no corra en absoluto en Fedora).

Hoy me tope con el frustrante problema de que  RHEL 7 no viene con soporte para NTFS por default y tampoco se puede instalar desde los repositorios oficiales de RHEL. Buscando un poco recorde que exsiten los repositorios EPEL. Esto es lo que hice.

- Instalar el RPM con la configuracion de EPEL.
  - Como root:
  
  ```
  wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-10.noarch.rpm
  rpm -i epel-release-7-10.noarch.rpm
  ```
- Instalar ultimas actualizaciones.
  ```
  yum update -y
  ```
- Instalar el soporte para ntfs:
  ```
  yum install -y ntfs-3g ntfsprogs
  ```
- Listo. Ahora RHEL ya abre mi memoria USB con formato NTFS. No necesité reiniciar la sesión ni la máquina.

![La herramienta Disks abriendo una memoria USB con formato NFTS](/static/images/posts/ntfs-rhel7/screenshot-2017-08-02-170700.png)

FIN
