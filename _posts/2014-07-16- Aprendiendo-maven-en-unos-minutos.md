 ---
title:  "Aprendiendo maven en unos minutos"
categories: Programación DevOps
tags: Maven Java
---

![Regresando al kinder](/media/404321726_1dd8836d14_o.jpg)



Encontre una pequeña guía: <http://maven.apache.org/guides/getting-started/maven-in-five-minutes.html>

Y lo que aprendí es que:

* Maven es una palabra que significa alguien que sabe mucho acerca de un tema en específico. Link

* Maven se invoca con la orden `mvn`. Por ejemplo: `mvn --version`:

```bash
nnieto@wks-nnieto Code$ mvn --version
Apache Maven 3.1.1 (NON-CANONICAL_2013-11-08_14-32_mockbuild; 2013-11-08 06:32:41-0800)
Maven home: /usr/share/maven
Java version: 1.8.0_05, vendor: Oracle Corporation
Java home: /usr/java/jdk1.8.0_05/jre
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "3.15.4-200.fc20.x86_64", arch: "amd64", family: "unix"
nnieto@wks-nnieto Code$
```

* Hay toda una página dedicada a explicar [qué es Maven](http://maven.apache.org/what-is-maven.html). Segun esto, Maven sirve para:

    - Hacer más fácil la tarea de construir un proyecto de software, obviamente en Java.

    - Se converte en una herramienta standard de la comunidad *Javera*. Los
      iniciados en Maven saben reconstruir un proyecto para tener una idea
      general de cómo funciona el software.

    - Y dicen que también se convierte en documentacion del proyecto.

    - A partir de todo esto concluyo que Maven es una herramienta parecida a
    [Autotools](https://es.wikipedia.org/wiki/GNU_build_system) para el mundo
    de C en Linux y a [zc.buildout](http://www.buildout.org/) en el mundo Pythonero.

* Requiere y/o depende de un SCM como git o subversion.

* Igual de importante es saber lo que **NO** es Maven (aunque Maven pueda hacerlo).

    - *Maven no es* un sitio o una herramienta de documentación.

    - *Maven no* extiende Ant para que te permita bajar dependencias de software (como npm, gem o pip/easy_install).

    - *Maven no es* un conjunto de recetas/scriptlets reusables de Ant.

---
Creo que la imagen de portada la baje de Flickr, pero perdí el link. Si alguien lo sabe avíseme.