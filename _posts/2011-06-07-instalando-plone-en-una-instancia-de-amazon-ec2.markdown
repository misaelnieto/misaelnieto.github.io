---
title: Instalando plone en una instancia de Amazon EC2
layout: post
categories: Plone
---

## Intro

Algunas notas acerca de lo que tuve que hacer para arrancar una instancia de
plone en Amazon EC2 para hacer un demo de 1 hora.

Estoy instalando un servidor de pruebas para un proyecto. Decidí probar con
Amazon EC2 por que puedo apagar el servidor después del demo.

## Usando la consola de administración de Amazon

Algunos pasos que hice:

* Crear una instancia t1.micro(1 procesador y 613 MB de RAM) con la AMI de 32
bits que Amazon te ofrece por default. Para mi sorpresa, me encuentro con que
ofrece una cantidad de paquetes no tan atrasados (Por ejmplo, ya trae
instalado Python 2.6.6). La AMI se basa en Fedora/CentOS, así que puedo usar
`yum`.

* Crear un par de llaves SSH especiales para esta instancia de prueba. No quiero
usar las mismas llaves que uso para servidores en producción.

* Esta es una de las características que mas me agradan de Amazon EC2: En 10
segundos pude configurar un firewall (Security group) para permitir solamente
el tráfico entrante de SSH, HTTP, HTTPs y puertos 8000 al 8010.

* Añadir una IP elástica. También es una característica que me hace la vida más
fácil. En mis DNS puedo definir un subdominio que apunte siempre a las
instancias de pruebas que arranco en EC2. Podría añadir un `CNAME` a la
instancia que arranco, pero da hueva estar cambiando el `CNAME`. La solución es
una IP elástica, siempre tiene la misma IP (duh!), pero no siempre apunta a la
misma instancia. El cambio se refleja en segundos.

* Cambiar el tamaño de la instancia cuando es adecuado. Una instancia t1.micro
es más que suficiente para correr un sitio Plone pequeño. Pero es un dolor en
la cabeza si quieres correr buildout ahí. Entonces, al momento de ejecutar
buildout, aumentas el tamaño de la instancia a c1.medium (con 1.7 GB de RAM y
lo equivalente a 5 procesadores), por ejemplo, y una vez que terminas de
ejecutar buildout, paras la instancia y la regresas a t1.micro para evitar que
te cobren el uso extra de la c1.medium.

## Preparando el sistema operativo

Esta es la lista de paquetes que instalé para que buildout construyera todo:

```bash
sudo yum install -y mercurial emacs subversion git make automake gcc gcc-c++ python-devel zlib-devel libxslt-devel openldap-devel
```

Estos paquetes fueron suficientes para arrancar Plone en modo desarrollo.

¿Y cuánto costo el chistecito?

Amazon cobra por lo que uses. Entre que arranqué por primera vez la instancia,
instalé el software necesario, configuré servicios e hice el demo al cliente
me tarde como 2 o tres horas, pero Amazon me cobró solo 1 hora. (No dudo que
me lo acumule después).

## Cobro de Amazon EC2

En total, tengo que pagar 0.17 USD, aproximadamente 2 pesos de México.
