---
title: Cómo montar unidades con formato NTFS en RHEL 7.3
date: 2017-08-02
description: Tutorial paso a paso para montar unidades con formato NTFS en RHEL 7.3 (Red Hat Enterprise Linux) instalando ntfs-3g y ntfsprogs desde el repositorio EPEL, ya que el soporte NTFS no viene en los repos oficiales de RHEL.
image: /static/images/posts/ntfs-rhel7/oil-lamps-294331.svg
tags:
- rhel
- linux
- ntfs
- filesystem
- epel
- ntfs-3g
extra:
  deprecated: true
  deprecated_reason: RHEL 7 entró en fase de Maintenance Support (EOL total en 2024); el flujo moderno en RHEL 8/9 sigue siendo ntfs-3g desde EPEL, pero los paquetes específicos referenciados ya cambiaron de versión.
---

Instalé RHEL 7.3 en una laptop (HP Probook 4720s) para poder correr [TCAD de
Silvaco](https://www.silvaco.com/products/tcad.html "Click para ver qué diablos
es TCAD").

![Propiedades del sistema en RHEL 7](/static/images/posts/ntfs-rhel7/screenshot-2017-08-02-165641.png)

Mientras que Fedora 26 ya trae [GNOME
3.24](https://www.gnome.org/news/2017/03/gnome-3-24-released/), RHEL 7.3 viene
con [GNOME 3.14](https://help.gnome.org/misc/release-notes/3.14/), con dos
años de diferencia. Eso implica que aún le falta una gran cantidad de mejoras
recientes del entorno GNOME. Por otro lado, es una lástima que TCAD no corra
en absoluto en Fedora.

Hoy me topé con el frustrante problema de que RHEL 7 no viene con soporte para
NTFS por defecto y tampoco se puede instalar desde los repositorios oficiales
de RHEL. Buscando un poco recordé que existen los repositorios EPEL. Esto es
lo que hice.

- Instalar el RPM con la configuración de EPEL.
  - Como root:

  ```
  wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-10.noarch.rpm
  rpm -i epel-release-7-10.noarch.rpm
  ```
- Instalar últimas actualizaciones.
  ```
  yum update -y
  ```
- Instalar el soporte para NTFS:
  ```
  yum install -y ntfs-3g ntfsprogs
  ```
- Listo. Ahora RHEL ya abre mi memoria USB con formato NTFS. No necesité
  reiniciar la sesión ni la máquina.

![La herramienta Disks abriendo una memoria USB con formato NTFS](/static/images/posts/ntfs-rhel7/screenshot-2017-08-02-170700.png)

**FIN**
