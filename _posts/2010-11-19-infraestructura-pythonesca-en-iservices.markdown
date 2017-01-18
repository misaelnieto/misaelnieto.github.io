---
title: Infraestructura Pythonesca en iServices
layout: post
categories: Python
---

(This post is in spanish and is somewhat more directed to the spanish-speaking
world).

En este post trataré de describir un poco la infraestructura que hemos
adoptado para mantener nuestros sitios web hechos con Python.

## Intro

Trabajo en la empresa iServices de México. Esta empresa se distingue de otras
empresas mexicanas en la tecnología usada para ofrecer sus servicios y
soluciones: Python.

[Un logo de Python de color verde](/media/python.png)

Durante varios meses he estado en contacto directo con diferentes técnicas y
tecnologías asociadas a Python. Por mencionar algunas: Python, Zope, Plone,
Distutils, pip, Pypi, Buildout, y Django.

En este post intento dar una vista de águila de cómo usamos estas tecnologías
para resolver los retos que nos plantean nuestros clientes.

## Linux y MacOS

Haré solo una breve mención: Usamos Linux para los servidores y para la
máquinas de algunos desarrolladores inadaptados. La distro preferida es Debian
o alguna de sus derivativas como Ubuntu.

Algunos developers han mordido la manzana y se compraron su mac. No tengo
mucho que decir acerca de ellos. Tal vez les gusta el mundo de colores grises
metálicos. :)

No hay regla acerca del editor o IDE. Cada quién usa lo que mejor le sienta :)

## Bases de datos y servidor web

* Bases de datos: MySQL, Postgresql, SQLite y ZODB (para Plone y Grok).

* Servidor web: Apache. Aunque a veces se tiene la intención de usar nginx.

## Python, setuptools, distribute, pip

He aquí la estrella de la película. En iServices, todo lo que se pueda hacer
con Python se hace con Python, a menos que exista otro software que ya hace lo
que requerimos y no valga la pena reinventar la rueda.

En nuestros servidores tenemos instaladas varias versiones de Python, a saber:
2.4, 2.5 y 2.6. Además tenemos instalados compiladores y librerías de
desarrollo a nivel de sistema para tenerlas disponibles para cualquier
proyecto.

Ya que estamos en esto, he de mencionar que cualquier versión de Python que
usemos tiene instalado easy_install, pip y virtualenv. Estos tres componentes
son clave para que podamos sacar provecho en nuestros servidores y meter todos
los proyectos que le quepan a un servidor (sin demeritar el performance, claro
esta).

## Virtualenv , los huevos de reptil y el indice de paquetes de Python

A últimas fechas he estado jugando mucho con Virtualenv. Durante algún tiempo
tuve desagrado hacia Virtualenv debido a que añade un nivel más a un stack de
software - que de por si ya está intrincado. Pero recientemente, al trabajar
con Django y Buildout me he encontrado con que Virtualenv ayuda mucho a no
contaminar la instalación de Python.

¿Qué quiero decir con contaminar la instalación de Python?

Pues lo que pasa es que al desarrollar aplicaciones web con Python se tiende a
re-usar mucho código de terceros. Hace algún tiempo, la comunidad Pythonera
acordó un formato para redistribuir librerías hechas en Python. Se creó
setuptools y apareció el Cheesse Shop. A decir verdad, no me se bien la
historia de cómo evolucionó todo el stack de python a como es hoy, pero de
seguro Tarek Ziadek sabe la historia.

Pues, como decía, no estoy seguro de cómo llegaron las cosas a ser como son el
día de hoy, pero lo resumo así: Las librerías de Python se distribuyen en
forma de huevos (eggs) y están disponibles en línea en el Python Package Index
(Alias, el Cheese Shop).

Para poder usar alguna nuevas librerías en python, hay al menos 3
posibilidades:

* Instalarla a mano. Esto implica bajar el tarball de la librería y seguir el proceso de instalación - que de seguro involucra a setuptools. Lo más común es instalarla en el sistema como root. A esto se le llama instalar un huevo (egg) en el System Python. Muchas veces no hay mecanismos para desinstalar tal librería y si se quiere remover, tendrá que ser de manera manual. Esto es problemático si la nueva librería instalada ocasiona conflictos en el sistema. En Ubuntu podemos dejar una máquina parcialmente inútil gracias a esto.
* Instalarla mediante el sistema de administración de paquetes del sistema operativo. Esto, inevitablemente, instalará librerías a nivel de sistema, como root y en el System Python. Instalar una librería de Python mediante el sistema de administración de paquetes del sistema operativo tiene la ventaja de que es posible desinstalar una librería de manera sencilla sin dejar rastros. Desgraciadamente, se dificulta la administración al usar diferentes versiones de Python y a veces se requieren versiones actualizadas de librerías que no se encuentran disponibles en los repositorios de paquetes. El riesgo de crear un conflicto en el sistema debido a la instalación de algún huevo/librería aún está latente.
* Instalarla mediante easy_install o pip. Este método ofrece las mismas ventajas que las dos opciones anteriores, además de que podemos elegir qué versión de una librería se irá a instalar. Desgraciadamente, aún se requiere permisos de administrador para instalar un huevo en el System Python.

Virtualenv nos ofrece una alternativa: Crear un entorno virtual, una copia de
nuestro System Python, pero independiente de éste. Esto nos ofrece una gran
ventaja debido a que podemos instalar tantos huevos deseemos sin atentar
contra la estabilidad del sistema.

## Buildout

Buildout es una de las herrmientas más importantes que usamos en iServices.
Con Buildout respondemos a ciertas preguntas que nos hacemos a la hora de
hechar a andar nuestras aplicaciones web con python:

* ¿Cómo replico de manera automatizada todo el entorno que tengo en mi máquina de desarrollo en el servidor de producción?
* ¿Cómo me aseguro que se instalen exactamente las mismas versiones de utilerías y librerías que se están usando en la máquina de desarrollo?
* ¿Como automatizo el proceso de instalación y de actualización de las aplicaciones web?
* ¿Cómo replico el entorno del servidor en una máquina de pruebas?


Buildout está escrito en Python y nos permite automatizar todo el proceso de
instalación de una aplicación web de una manera predecible y con unos cuantos
comandos.

Últimamente hemos estado probando utilizar Buildout y Virtualenv y hemos
conseguidos resultados modestos pero contundentes: funciona a la maravilla.
Gracias a Buildout y Virtualenv es como podemos instalar varias aplicaciones
web en un servidor sin que se interfieran entre ellas demasiado y sin recurrir
a virtualizaciones o servicios en la nube.

## Outro

Este fue un resumen de las herramientas que usamos en iServices para hacer
aplicaciones web con Python. Es un resumen escueto y espero que a alguien le
sirva.
