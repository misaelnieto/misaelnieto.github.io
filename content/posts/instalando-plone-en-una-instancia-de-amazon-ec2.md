---
title: "Instalando Plone en una instancia de Amazon EC2"
date: "2011-06-07"
summary: "Apuntes de un demo de 1 hora: t1.micro en EC2, security group, IP elástica y resize temporal a c1.medium para correr buildout."
description: "Notas para arrancar una instancia de Plone en Amazon EC2 con una AMI de 32 bits, security group para SSH/HTTP/8000-8010 y Elastic IP."
categories:
  - "Plone"
  - "DevOps"
tags:
  - plone
  - amazon-ec2
  - aws
  - cloud
  - deployment
locale: "es_MX"
keywords: "plone, amazon ec2, t1.micro, elastic ip, security group, yum"
extra:
  deprecated: true
  deprecated_reason: "Plone 4 y la AMI Fedora/CentOS 32-bits son EOL; el flujo moderno usa Plone 6 + Docker + t3.small"
---

## Intro

Algunas notas acerca de lo que tuve que hacer para arrancar una instancia de
Plone en Amazon EC2 para hacer un demo de 1 hora.

Estoy instalando un servidor de pruebas para un proyecto. Decidí probar con
Amazon EC2 porque puedo apagar el servidor después del demo.

## Usando la consola de administración de Amazon

Algunos pasos que hice:

* Crear una instancia `t1.micro` (1 procesador y 613 MB de RAM) con la AMI de 32 bits que Amazon te ofrece por default. Para mi sorpresa, me encuentro con que ofrece una cantidad de paquetes no tan atrasados (por ejemplo, ya trae instalado Python 2.6.6). La AMI se basa en Fedora/CentOS, así que puedo usar `yum`.

* Crear un par de llaves SSH especiales para esta instancia de prueba. No quiero usar las mismas llaves que uso para servidores en producción.

* Esta es una de las características que más me agradan de Amazon EC2: en 10 segundos pude configurar un firewall (security group) para permitir solamente el tráfico entrante de SSH, HTTP, HTTPS y puertos 8000 al 8010.

* Añadir una IP elástica. También es una característica que me hace la vida más fácil. En mis DNS puedo definir un subdominio que apunte siempre a las instancias de pruebas que arranco en EC2. Podría añadir un `CNAME` a la instancia que arranco, pero da hueva estar cambiando el `CNAME`. La solución es una IP elástica: siempre tiene la misma IP (duh!), pero no siempre apunta a la misma instancia. El cambio se refleja en segundos.

* Cambiar el tamaño de la instancia cuando es adecuado. Una instancia `t1.micro` es más que suficiente para correr un sitio Plone pequeño. Pero es un dolor en la cabeza si quieres correr buildout ahí. Entonces, al momento de ejecutar buildout, aumentas el tamaño de la instancia a `c1.medium` (con 1.7 GB de RAM y lo equivalente a 5 procesadores), por ejemplo, y una vez que terminas de ejecutar buildout, paras la instancia y la regresas a `t1.micro` para evitar que te cobren el uso extra de la `c1.medium`.

## Preparando el sistema operativo

Esta es la lista de paquetes que instalé para que buildout construyera todo:

```bash
sudo yum install -y mercurial emacs subversion git make automake gcc gcc-c++ python-devel zlib-devel libxslt-devel openldap-devel
```

Estos paquetes fueron suficientes para arrancar Plone en modo desarrollo.

## ¿Y cuánto costó el chistecito?

Amazon cobra por lo que uses. Entre que arranqué por primera vez la instancia,
instalé el software necesario, configuré servicios e hice el demo al cliente
me tardé como 2 o tres horas, pero Amazon me cobró solo 1 hora (no dudo que me
lo acumule después).

## Cobro de Amazon EC2

En total, tengo que pagar 0.17 USD, aproximadamente 2 pesos mexicanos.
