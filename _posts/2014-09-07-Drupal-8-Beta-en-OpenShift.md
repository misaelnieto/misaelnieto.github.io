---
layout: post
title:  "Drupal 8 Beta en OpenShift"
date:   2014-05-07 16:26:10 -0800
categories: Web Drupal
---

Decidi instalar el core de Drupal 8 Beta en OpenShift para hacerme un blog
gratis.


1. Primero abrí mi cuenta en [OpenShift](https://www.openshift.com/)

2. En el panel de control de OpenShift seleccioné `Applications -> Add Application`.

3. Puse Drupal en el cuadro de busqueda. Como opciones se encuentra Drupal 7 y
Drupal 8. Escogí el 8 por que me gusta complicarme la vida.

3. El segundo paso es escoger el nombre de la aplicación. Elegi `mosaiko`
(mosaico en esperanto) y deje todas las demas configuraciones sin tocar. Solo
faltó presionar el botoncito azul de `Create Application`.

4. Inmediatamente se desactiva el botoncito azul y sale una ruedita de esas
que dan vueltas para indicarte que "_no me molestes hasta que yo te diga que ya
esta listo_". Y se tarda unos 5 minutos en crear el gear de Drupal.

5. Hasta el momento de escribir este post, no tengo la menor idea lo que es un
Gear pero se parece mucho a un container de Docker.

6. Cuando termina de crear el Gear, el sitio te muestra un cuadrito verde con
el nombre de usuario de MySQL, el passowrd y la base de datos de Drupal, que
es el mismo nombre que la instancia de Drupal: `mosaiko`.

7. Mi sitio Drupal quedo accesible desde `mosaiko-nnieto.rhcloud.com`. Este es
el alias de la aplicacion. Se pueden anhadir muchos alias. En la pagina de
_overview_ de la aplicacion se muestra el nombre de dominio que quedo
configurado (`mosaiko-nnieto.rhcloud.com`).

    A un lado hay link chiquito que dice change. Ahi es donde hay que picarle
    para dar de alta el alias para la aplicacion. El alias no es otra cosa que
    el _CNAME_. Primero configure el _CNAME_ para que apunte a
    `mozaiko-nnieto.rhcloud.com`, luego puse el nombre de dominio completo en "_Domain
    name_"; en este caso el nombre es `mozaico.noenieto.com`.

9. Falta una cosa: la contraseña del administrador. Por default es
`openshift_changeme`. OBVIAMENTE, le cambie el `user_id`, el password y muchas
otras cosas, asi que no intentes hackear este sitio ¿Ok?

10. Inmediatamente despues de entrar a Drupal y cambiar la contraseña del
admin, me puse a escribir este post. El editor WYSIWYG que trae el Drupal 8 es
una maravilla ¡Me encanta!

Eso es todo. Es mi primera experiencia seria con OpenShift y Drupal 8.

* Foto de Elke Blok CC BY-NC-SA 2.0
