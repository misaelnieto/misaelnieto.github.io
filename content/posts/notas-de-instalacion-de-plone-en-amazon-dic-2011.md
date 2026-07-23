---
title: "Notas de instalación de Plone en Amazon (Dic 2011)"
date: "2012-03-10"
summary: "Apuntes de migración: AMI de Amazon con nginx prehistórico vs Ubuntu 11.04, buildout con production.cfg y Data.fs en EBS separado."
description: "Notas para instalar Plone en una instancia EC2 Ubuntu 11.04: paquetes Debian, bootstrap.py, buildout con production.cfg y Data.fs en EBS aparte."
categories:
  - "Plone"
  - "DevOps"
tags:
  - plone
  - amazon-ec2
  - ubuntu-1104
  - buildout
  - nginx
  - ebs
locale: "es_MX"
keywords: "plone, amazon ec2, ubuntu 11.04, buildout, nginx, data.fs, ebs, fstab"
extra:
  deprecated: true
  deprecated_reason: "Ubuntu 11.04 y AMI de Amazon descritas son EOL; el flujo moderno usa Docker o Plone 6 con RelStorage"
---

Estoy actualizando mi sitio web, guardo algunas notas para futura referencia.

* Me quedan aproximadamente 2 meses de la promoción de Amazon (1 año de servicio gratis de una instancia `t1.micro` y 10 GB de EBS).

* Usé una instancia `m1.small` para instalar y compilar todo lo necesario. Después se puede achicar a `t1.micro` para entrar en el *monthly free tier*.

* Probé el AMI de Amazon. Todo de maravilla hasta que intenté instalar nginx (no quiero Apache). Para mi sorpresa, ¡solo trae nginx 0.8.6! Si instalo a mano, no me aprovecho por completo los beneficios de las actualizaciones mediante `yum`. Hacer mis propios RPMs es demasiado complicado para mí aún.

* A pesar de que en los repositorios de EPEL hay una versión más actualizada de nginx, por alguna razón se sigue instalando la anterior. Por estas razones desistí de usar el AMI de Amazon.

* Instalé el AMI oficial de Ubuntu 11.04 y trae nginx 1.0.5 (la última versión estable al día de hoy es la 1.0.11).

La instalación de paquetes es la usual para aplicaciones Python.

```bash
aptitude update
aptitude upgrade
aptitude install python-dev build-essential
aptitude install libpcre3-dev zlib1g-dev libjpeg62-dev libpng12-dev libncurses5-dev libxslt1-dev mercurial git subversion python-pip libsasl2-dev pkg-config
easy_install -U distribute
easy_install -U pip
```

Añadí un *deploy key* en mi repo de GitHub y lo cloné.

Y sigue la receta clásica para inicializar un buildout, solo que con algunas modificaciones:

```bash
python -S bootstrap.py
bin/buildout -c production.cfg
```

Buildout genera la configuración de nginx para mi sitio (en `parts/`), solo
tengo que hacer una liga simbólica y reiniciar nginx:

```bash
ln -s /apps/noenieto/parts/nginx/nginx.cfg /etc/nginx/sites-available/noenieto.com
```

Puse mi `Data.fs` en un EBS fuera del EBS de la instancia. Hay que conectarlo
a la instancia y montarlo. Añadí la siguiente línea al fstab:

```fstab
/dev/sdp1    /MyPloneData    ext3    rw,noatime,auto    0 0
```

Creo que es todo.
